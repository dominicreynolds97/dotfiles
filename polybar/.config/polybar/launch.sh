#!/usr/bin/env bash

killall -q polybar

# Find this machine's CPU temperature sensor (AMD: k10temp, Intel: coretemp)
for hwmon in /sys/class/hwmon/hwmon*; do
    case "$(cat "$hwmon/name")" in
        k10temp|coretemp)
            export CPU_TEMP="$hwmon/temp1_input"
            break
            ;;
    esac
done

polybar main >/tmp/polybar.log 2>&1 &
disown
