

require './led'
require 'rubygems'
require 'serialport'

ON = 255
OFF = 0

begin
sp = SerialPort.new('COM20',38400) # 9600
rescue
end

led_cube = LedCube.new
led_cube.all_on
# led_cube.index = 32
led = led_cube.get_current_led;
led.turn_off
led.red = ON

sp.write( led_cube.cube_command)
while led_cube.index < 63 do
  # sleep(0.1)
  led = led_cube.get_next_led
  led.turn_off
  led.red = ON
  sp.write( led_cube.cube_command)
end
idx = 0
while idx < 50 do
  led_cube.reverse_all
  sleep(0.15)
  sp.write( led_cube.cube_command)
  idx = idx +1
end

sp.close
led = nil
led_cube = nil
sp = nil


