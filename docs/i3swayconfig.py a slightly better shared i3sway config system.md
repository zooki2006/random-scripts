i3swayconfig.py a slightly better shared i3sway config system
========================
### why?
i3 and sway the same config format with some slight tweaks i want to use the same config across both for all my systems since sway still isn't quite perfect.

You may ask why not just have a sway and i3 config that source a third config, and primary use the third config with the sway and i3 configs only being used for things you want excluded from each other. There is a problem with this though and that is while you can import variables from the sway and i3 configs into configs you source, you can't do the inverse. 

So you may need to set $Mod in sway and i3 configs if you want to use it outside the shared config, which is really annoying. 
This script aims to avoid that by allowing you to define a single config with relitively clean i3 and sway exclusive parts.

### how?
I've written a script that uses a config system like so...
```
[i3config]
set $term xterm

[swayconfig]
set $term foot

[shared]
bindsym $mod+Return exec $term
bindsym $mod+q kill
```
This extremely basic example would then be converted into a i3 and sway config.
The outputs should be...
### i3config
```
set $term xterm

bindsym $mod+Return exec $term
bindsym $mod+q kill
```
### swayconfig
```
set $term foot

bindsym $mod+Return exec $term
bindsym $mod+q kill
```

Its also posable to swap between shared/swayconfig/i3config modes almost endless times.

## known bugs/flaws

### mode switching picky
mode switching with [i3config]/[swayconfig]/[shared] only works if the line exactly matches [i3config]/[swayconfig]/[shared]  even a space, indentation or a comment will stop it from working.

## extras
if you want to you could rebind i3/sway reload to a script that runs i3swayconfig.py then runs i3/sway reload for a more seemless exprence.

