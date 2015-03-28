

require 'rubygems'
require 'serialport'

ON = 1
OFF = 0

begin
  sp = SerialPort.new('COM4',9600) # 9600
rescue
end
sleep(5) #DMD AND MOST ARDUINO RESET THEMSELVES ON NEW CONNECTION SO HAVE TO WAIT TO RESET FINSIEHD BEFORE CAN CONTINUE

idx = 0
while idx < 10 do
  sp.write('{0A0A1}') # {0A0A1}
  sleep(1)
  sp.write('{0A0A0}')
  sleep(1)
  idx = idx +1
end

# sp.close
# sp = nil