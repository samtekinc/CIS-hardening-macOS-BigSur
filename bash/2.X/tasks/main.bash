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