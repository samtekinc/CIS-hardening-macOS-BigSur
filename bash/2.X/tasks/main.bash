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
cornerone=$(defaults read com.apple.dock wvous-tl-corner)
cornertwo=$(defaults read com.apple.dock wvous-bl-corner)
cornerthree=$(defaults read com.apple.dock wvous-tr-corner)
cornerfour=$(defaults read com.apple.dock wvous-br-corner)
corneronefix="defaults write com.apple.dock wvous-tl-corner -int 0"
cornertwofix="defaults write com.apple.dock wvous-bl-corner -int 0"
cornerthreefix="defaults write com.apple.dock wvous-tr-corner -int 0"
cornerfourfix="defaults write com.apple.dock wvous-br-corner -int 10" 

for user in $users; do
    su $user
    cornerone=$(defaults read com.apple.dock wvous-tl-corner)
    if [ $cornerone == 6 ]; then 
        $corneronefix
    fi 
    cornertwo=$(defaults read com.apple.dock wvous-bl-corner)
    if [ $cornertwo == 6 ]; then
        $cornertwofix
    fi
    cornerthree=$(defaults read com.apple.dock wvous-tr-corner)
    if [ $cornerthree == 6 ]; then
        $cornerthreefix
    fi
    cornerfour=$(defaults read com.apple.dock wvous-br-corner)
    if [ $cornerfour == 6 ]; then
        $cornerfourfix
    fi
done


# 2.3.3 Familiarize users with screen lock tools or corner to Start Screen Saver (Manual)
# This remediation is made in 2.3.2.
# In this case the bottom right corner's functionality is to start the Screensaver.

# 2.4.7 Disable Bluetooth Sharing
for user in $users; do
    su $user
    defaults -currentHost write com.apple.Bluetooth PrefKeyServicesEnabled -bool false
done 

# 2.4.12 Ensure AirDrop is Disabled
for user in $users; do 
    su $user 
    defaults write com.apple.NetworkBrowser DisableAirDrop -bool true 
done 

# 2.5.6 Limit Ad tracking and personalized Ads
for user in $users; do
    su $user
    defaults -currentHost write /Users/$user/Library/Preferences/com.apple.Adlib.plist allowApplePersonalizedAdvertising -bool false
done 
# 2.6.1 iCloud configuration is a level 2 remediation 

# 2.6.2 iCloud keychain is a level 2 remediation

# 2.6.3 iCloud Drive is a level 2 remediation

# 2.6.4 iCloud Drive Document and Desktop sync is a level 2 remediation

# 2.7.1 Time Machine Auto-Backup is a level 2 remediation

# 2.7.2 check 



# 2.10 Enable Secure Keyboard Entry in terminal.app 
for user in $users; do
    su $user
    defaults write -app Terminal SecureKeyboardEntry -bool true
done

# 2.11 skipped

# 2.12 Automatic Actions for Optical Media
for user in $users; do
    su $user
    media_type=("com.apple.digihub.blank.cd.appeared" "com.apple.digihub.blank.dvd.appeared" "com.apple.digihub.cd.music.appeared" "com.apple.digihub.cd.picture.appeared" "com.apple.digihub.dvd.video.appeared")
    for i in "${media_type[@]}"; do
        defaults write /Users/$user/Library/Preferences/com.apple.digihub $i -dict action 1
    done
done
# 2.13 Review Siri Settings
for user in $users; do
    su $user
    defaults write com.apple.assistant.support.plist 'Assistant Enabled' -bool false
    defaults write com.apple.Siri.plist LockscreenEnabled -bool false
    defaults write com.apple.Siri.plist StatusMenuVisible -bool false
    defaults write com.apple.Siri.plist VoiceTriggerUserEnabled -bool false
    killall -HUP cfprefsd
    killall SystemUIServer
done
# 2.14 Review Sidecar Settings: Sidecar has no known security issues. 

