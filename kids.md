arduino-cli compile --fqbn arduino:avr:mega <path>
arduino-cli upload --fqbn arduino:avr:mega -p <port> <path>

arduino-cli compile --fqbn arduino:avr:mega nav2_motor_control/nav2_motor_control.ino
arduino-cli upload --fqbn arduino:avr:mega -p /dev/ttyACM0 nav2_motor_control/nav2_motor_control.ino