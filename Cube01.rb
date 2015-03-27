

require './led'
require "rubygems"
require "serialport"

RED   =  'FF0000'
GREEN =  '00FF00'
BLUE =   '0000FF'

begin
sp = SerialPort.new("COM20",9600)
rescue
end

# sp.write("{000000000}") # BOTTOM CORNER LED = GREEN

led_cube = Array.new(64)

led = Led.new(2,1,2)
led_cube[0] = led
led = Led.new(0,1,1)
led_cube[1] = led


led_cube[0].green = 255
sp.write( led_cube[0].cube_command)
sleep(10)
led_cube[0].turn_off
sp.write( led_cube[0].cube_command)

sp.close


