

require './led'
require "rubygems"
require "serialport"

ON = 255
OFF = 0

begin
sp = SerialPort.new("COM20",9600)
rescue
end

led_cube = LedCube.new

led = led_cube.get_led(2,3,3)
led.green = ON
led = led_cube.get_led(3,2,3)
led.blue = ON
led.red = OFF
sp.write( led_cube.cube_command)

sp.close
led = nil
led_cube = nil
sp = nil


