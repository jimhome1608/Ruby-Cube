
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

dmd_cube = DMDLeds.new        # redLed = dmd_cube.get_led(31,15)   right bottom
led_cube = LedCube.new        # led = led_cube.get_led(0,0,0)< left Front Botttom  led_cube.get_led(3,3,3) right, back top
led_cube.all_off
dmd_cube.all_off
sp_cube.write( led_cube.cube_command)

# led = led_cube.get_led(1,0,0)
# led.red = ON;
# sp_cube.write( led_cube.cube_command)

while true do

y = 0
while y < 16 do
  redLed = dmd_cube.get_led(15,y)
  redLed.turn_on
  redLed.turn_on
  sp_dmd.write(redLed.dmd_command)
  y = y +1
  sleep(0.1)
  redLed.turn_off
  sp_dmd.write(redLed.dmd_command)
end

z = 3
while z >=0 do
  led = led_cube.get_led(2,0,z)
  if led.is_on
    led = led_cube.get_led(1,0,z)
    if led.is_on
      led = led_cube.get_led(3,0,z)
      if led.is_on
        led = led_cube.get_led(0,0,z)
        if led.is_on
          led = led_cube.get_led(1,0,z+1)
          if led.is_on
            led = led_cube.get_led(2,0,z+1)
            led.blue = ON
            sp_cube.write( led_cube.cube_command)
            sleep(5)
            led_cube.all_off
            sp_cube.write( led_cube.cube_command)
            break
          end
        end
      end
    end
  end
  #led.red = ON
  led.blue = ON
  sp_cube.write( led_cube.cube_command)
  sleep(0.2)
  if z > 0
    led.red = OFF
    led.blue = OFF
    sp_cube.write( led_cube.cube_command)
  end
  z = z -1
end

end

sleep(5)

sp_cube.close
sp_dmd.close
led = nil
led_cube = nil
dmd_cube = nil
sp_cube = nil
sp_dmd = nil


