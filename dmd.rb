

class RedLed
  def initialize(x,y)
    @x = x
    @y = y
    @on = false
  end
  def x
    @x
  end
  def y
    @y
  end
  def on
    @on
  end
  def on=(value)
    @on = value
  end

  def dmd_command
    x_command = sprintf('%x', @x)
    x_command = x_command.upcase
    if x_command.length <2
      x_command = '0'+x_command
    end
    y_command = sprintf('%x', @y)
    y_command = y_command.upcase
    if y_command.length <2
      y_command = '0'+y_command;
    end
    if @on then
      '{'+x_command+y_command+'1}'
    else
      '{'+x_command+y_command+'0}'
    end
  end
end


class DMDLeds
  def initialize
    @x=0
    @y=0
    @idx = 0
    @leds = Array.new(512)
    @index = 0
    while @x < 32 do
      @y = 0
      while @y < 16 do
        @redLed = RedLed.new(@x,@y)
        @leds[@idx] = @redLed
        @idx = @idx +1
        @y = @y +1
      end
      @x = @x +1
    end
  end

  def index=(value)
    @index = value
  end
  def index
    @index
  end

  def dmd_command
    @idx = 0
    @command = ''
    while @idx <512 do
      @redLed = @leds[@idx]
      @command = @command+@redLed.dmd_command
      @idx = @idx+1
    end
    @command
  end

  def get_led(x,y)
    @idx = 0
    while @idx <512 do
      @redLed = @leds[@idx]
      if @redLed.x == x and @redLed.y == y
        @redLed
        break
      end
      @idx = @idx+1
    end
    @redLed
  end

  def all_off
    @idx = 0
    while @idx <64 do
      @redLed = @leds[@idx]
      @redLed.turn_off
      @idx = @idx+1
    end
  end

  def all_on
    @idx = 0
    while @idx <512 do
      @redLed = @leds[@idx]
      @redLed.on = true
      @idx = @idx+1
    end
  end

  def reverse_all
    @idx = 0
    while @idx <512 do
      @redLed = @leds[@idx]
      if @redLed.on then
        @redLed.on = false
      else
        @redLed.on = true
      end
      @idx = @idx+1
    end

  end

  def get_next_led
    if @index < 512
      @index = @index + 1;
    end
    @redLed = @leds[@index]
  end

  def get_current_led
    @leds[@index]
  end
end