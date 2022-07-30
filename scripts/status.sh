

clear
while true; do
    BAT0=$(cat /sys/class/power_supply/BAT0/capacity)
    BAT1=$(cat /sys/class/power_supply/BAT1/capacity)

    echo -n "\033[2J \033[H"
    echo -n "BAT0: ${BAT0}%  
BAT1: ${BAT1}%  "
    echo -n "\033[H"
    sleep 1
done 