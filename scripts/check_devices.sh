#!/bin/bash

echo "=== Serial Device Check ==="
echo "Checking for available serial devices..."

# Check for USB serial devices
echo "USB Serial Devices:"
ls -la /dev/ttyUSB* 2>/dev/null || echo "  No /dev/ttyUSB* devices found"

# Check for ACM devices (Arduino)
echo "ACM Devices (Arduino):"
ls -la /dev/ttyACM* 2>/dev/null || echo "  No /dev/ttyACM* devices found"

# Check for other common serial devices
echo "Other Serial Devices:"
ls -la /dev/ttyS* 2>/dev/null || echo "  No /dev/ttyS* devices found"

# Show USB devices
echo ""
echo "USB Devices:"
lsusb

echo ""
echo "=== Device Permissions ==="
for device in /dev/ttyUSB* /dev/ttyACM* /dev/ttyS*; do
    if [ -e "$device" ]; then
        echo "$device: $(ls -la $device)"
    fi
done 