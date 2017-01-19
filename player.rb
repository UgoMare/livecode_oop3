class Player
attr_reader :score

  def initialize
    @image = Gosu::Image.new("media/starfighter.bmp")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0

    @beep = Gosu::Sample.new("media/beep.wav")
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 100
  end

  def turn_right
    @angle += 20
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 9999999999)
    @vel_y += Gosu::offset_y(@angle, 9999999999)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 1280
    @y %= 720

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu::distance(@x, @y, star.x, star.y) < 35 then
        @score += 10
        @beep.play
        true
      else
        false
      end
    end
  end
end
