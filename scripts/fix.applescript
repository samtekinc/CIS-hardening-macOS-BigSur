tell application "System Preferences" 
    activate
    set current pane to pane "Apple ID"
    tell application "System Events"
        click radio button "Options" of tab group 1 of application process "System Preferences"
    end tell
end tell      