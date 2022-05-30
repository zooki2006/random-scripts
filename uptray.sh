#!/bin/sh
update (){
pkill -RTMIN+25 dwmblocks
}
update 
sleep 10 && update
