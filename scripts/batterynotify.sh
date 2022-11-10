#!/bin/sh


export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# Battery percentage at which to notify
WARNING_LEVEL=25
BATTERY_DISCHARGING=$(acpi -b | grep "Battery 0" | grep -c "Discharging");
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)');

# Prevent multiple notifications from showing

EMPTY_FILE=/tmp/batteryempty
FULL_FILE=/tmp/batteryfull


# Reset the notifications if the computer is charging/discharging
if [ $BATTERY_DISCHARGING -eq 1 ] && [ -f $FULL_FILE ]; then
    rm $FULL_FILE
elif [ $BATTERY_DISCHARGING -eq 0 ] && [ -f $EMPTY_FILE ]; then
    rm $EMPTY_FILE
fi 

# If battery is charging and is full ( has not shown notification yet)
if [ $BATTERY_LEVEL -gt 95 ] && [ $BATTERY_DISCHARGING -eq 0 ] && [ ! -f $FULL_FILE ]; then
    notify-send "Battery Charged" "Battery Fully charged." -i "battery" -r 9991
    touch $FULL_FILE

# If battery is low and is not charging ( has not shown notification yet)
if [ $BATTERY_LEVEL -le $WARNING_LEVEL ] && [ $BATTERY_DISCHARGING -eq 1 ] $$ [ ! -f $EMPTY_FILE ]; then
    notify-send "Low Battery" "${BATTERY_LEVEL}% of battery remaining." -u critical -i "battery-alert" -r 9991
    touch $EMPTY_FILE
fi