#!/bin/bash

# Your application code here

# Create a temporary directory for icons
tmp_icon_dir="/tmp/myapp-icon"
mkdir -p "$tmp_icon_dir"

# Create a custom icon for your app
icon_path="$tmp_icon_dir/myapp-icon.png"
convert -size 16x16 xc:none -fill green -draw 'circle 8,8 8,1' "$icon_path"

dbus-send --session --print-reply --dest=org.freedesktop.Notifications --type=method_call --reply-timeout=10000 /org/freedesktop/Notifications org.freedesktop.Notifications.Notify \
    string:"MyApp" \
    uint32:123 \
    string:"General" \
    string:"Hello, this is a notification message!" \
    string:"MyAppSender" \
    array:string:"Dismiss" \
    dict:string:string: \
    int32:10000

