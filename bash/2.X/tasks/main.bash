## 2.1.1 Turn off Bluetooth, if no paired devices exist
bt_power=$(defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState)
bt_datatype=$(system_profiler SPBluetoothDataType | grep "Bluetooth:" -A 20 | grep Connectable)
if [[ $bt_power == 1 && $bt_datatype == "Connectable: No." ]]; then
    defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerstate -int 0 & killall -HUP blued;
fi

## 2.1.2 Show Bluetooth status in menu bar 
sudo -u <username> defaults -currentHost write com.apple.controlcenter.plist Bluetooth -int 18