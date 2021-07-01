#!/bin/bash
## 2.1.1 Turn off Bluetooth, if no paired devices exist
bt_power=$(defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState)
bt_datatype=$(system_profiler SPBluetoothDataType | grep "Bluetooth:" -A 20 | grep Connectable)
if [[ $bt_power == 1 && $bt_datatype == "Connectable: No." ]]; then
    defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerstate -int 0 & killall -HUP blued;
fi

## 2.1.2 Show Bluetooth status in menu bar 
users=$(dscl . list /Users | grep -v '^_' | grep -v 'daemon' | grep -v 'nobody' | grep -v 'root')
for user in $users; do
    echo "Adding BT icon to menu bar for user $user"
    su $user defaults -currentHost write com.apple.controlcenter.plist Bluetooth -int 18
done

## 2.3.1 Set an inactivity interval of 20 minutes or less for the screen saver 
 for user in $users; do 
    echo "Setting idle time for user $users to 20 minutes"
    su $user defaults -currentHost write com.apple.screensaver idleTime -int 1200
done

## 2.3.2 Secure screen saver corners
cornerone= $user defaults read com.apple.dock wvous-tl-corner
cornertwo= $user defaults read com.apple.dock wvous-bl-corner
cornerthree= $user defaults read com.apple.dock wvous-tr-corner
cornerfour= $user defaults read com.apple.dock wvous-br-corner
corneronefix= $user defaults write com.apple.dock wvous-tl-corner -int 0
cornertwofix= $user defaults write com.apple.dock wvous-bl-corner -int 0
cornerthreefix= $user defaults write com.apple.dock wvous-tr-corner -int 0
cornerfourfix= $user defaults write com.apple.dock wvous-br-corner -int 0 

for user in $users; do
    if [ $cornerone == 6 ]; then 
        $corneronefix
    fi 
    if [$cornertwo == 6 ]; then
        $cornertwofix
    fi
    if [ $cornerthree == 6 ]; then
        $cornerthreefix
    fi
    if [ $cornerfour == 6 ]; then
        $cornerfourfix
    fi