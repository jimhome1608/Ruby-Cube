
require './dmd'
require './led'
require 'rubygems'
require 'serialport'

ON = 255
OFF = 0

begin
  sp_cube = SerialPort.new('COM20',38400) # 9600
rescue
end
begin
  sp_dmd = SerialPort.new('COM4',9600) # 9600
rescue
end
sleep(5) #DMD AND MOST ARDUINO RESET THEMSELVES ON NEW CONNECTION SO HAVE TO WAIT TO RESET FINSIEHD BEFORE CAN CONTINUE

dmd_cube = DMDLeds.new
led_cube = LedCube.new
led_cube.all_off
redLed = dmd_cube.get_led(31,15)
redLed.on = true

sp_dmd.write(dmd_cube.dmd_command) # {0A0A1}
idx = 0
while idx < 2 do
  led_cube.reverse_all
  sleep(0.15)
  sp_cube.write( led_cube.cube_command)
  if idx % 2 == 0  then
    sp_dmd.write('{0A0A1}')
  else
    sp_dmd.write('{0A0A0}')
  end
  idx = idx +1
end

sp_cube.close
sp_dmd.close
led = nil
led_cube = nil
dmd_cube = nil
sp_cube = nil
sp_dmd = nil


