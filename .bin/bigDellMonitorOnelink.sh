# Fix the resolution of the office 27" Dell monitor (U2713H)
# To find out the specs of your monitor, run:
# > sudo apt install read-edid
# > ls /sys/class/drm/*/edid | xargs -i{} sh -c "echo {}; parse-edid < {}"
# from: http://askubuntu.com/a/852857/329328
xrandr --newmode "2560x1440_55" 220.812 2560 2608 2640 2720 1440 1443 1448 1478 -hsync -vsync
xrandr --addmode DP2 "2560x1440_55"

