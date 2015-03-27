

class RGBColor
  def init_rgb(red=0,green=0,blue=0)
    @red = red
    @green = green
    @blue = blue
   end

  def red=(value)
    @red = value
  end
  def red
    @red
  end
  def green=(value)
    @green = value
  end
  def green
    @green
  end
  def blue=(value)
    @blue = value
  end
  def blue
    @blue
  end
  def has_color
    result = false
    if @red > 0
      result = true
    end
    if @green > 0
      result = true
    end
    if @blue > 0
      result = true
    end
    result
  end

  def to_hex
    red = sprintf('%x', @red)
    red = red.upcase
    if red.length <2
      red = '0'+red;
    end
    green = sprintf('%x', @green)
    green = green.upcase
    if green.length <2
      green = '0'+green
    end
    blue = sprintf('%x', @blue)
    blue = blue.upcase
    if blue.length <2
      blue = '0'+blue
    end
    red+green+blue
  end
end


class Led < RGBColor
  def initialize(x,y,z)
    @x = x
    @y = y
    @z = z
    init_rgb(0,0,0)
  end
  def is_on
    has_color
  end
  def turn_off
    @red = 0
    @green = 0
    @blue = 0
  end
  def cube_command
    '{'+@x.to_s+@y.to_s+@z.to_s+to_hex+'}'
  end
end

class LedCube

end