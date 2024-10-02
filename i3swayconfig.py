#!/usr/bin/env python

import os

def makedir(path):
    if not os.path.exists(path):
        os.makedirs(path)


def writetoconfig(path,writelist):
    # open file in write mode
    with open(path + "config", "w") as fp:
        for item in writelist:
            # write each item on a new line
            fp.write("%s\n" % item)
        print("Writen to " + path + "config")

def readconfig(path):
    towritetosway = []
    towritetoi3 = []
    configmode = 0 # config mode 0 adds to both configs, config mode 1 only to i3 and mode 2 only to sway.
    
    f = open(path + "config", "r")
    contents = f.read()
    f.close
    for x in contents.split('\n'):
      if x == "[shared]":
          #print("mode shared")
          configmode = 0
      elif x == "[i3config]":
          #print("mode i3")
          configmode = 1
      elif x == "[swayconfig]":
          #print("mode sway")
          configmode = 2
      else:
          if configmode == 0:
              towritetosway.append(x)
              towritetoi3.append(x)
          elif configmode == 1:
              towritetoi3.append(x)
          elif configmode == 2:
              towritetosway.append(x)
    return towritetoi3, towritetosway


def main():
    _home = os.path.expanduser("~")
    xdg_config_home = os.environ.get('XDG_CONFIG_HOME') or \
            os.path.join(_home, '.config')

    #print("xdgconfigpath =" + xdg_config_home)
    
    swaydir = xdg_config_home + "/sway/"
    i3dir = xdg_config_home + "/i3/"
    swayi3dir = xdg_config_home + "/swayi3/"
    makedir(i3dir)
    makedir(swaydir)
    makedir(swayi3dir)
    
    try:
        towritetoi3, towritetosway = readconfig(swayi3dir)
    except FileNotFoundError:
        print("ERROR: swayi3 config file not found, to use this script create one at " + swayi3dir + "config.")
        exit()
    writetoconfig(i3dir,towritetoi3)
    writetoconfig(swaydir,towritetosway)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("(Ctrl-C)")
