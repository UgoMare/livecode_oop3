require_relative 'player'
require_relative 'star'
require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 1280, 720
    self.caption = "Archies sick as f game"

    @background_image = Gosu::Image.new("media/space.png", :tileable => true)
    @player = Player.new
    @player.warp(640, 360)

    @star_anim = Gosu::Image::load_tiles("media/star.png", 25, 25)
    @stars = Array.new

    @font = Gosu::Font.new(20)
  end

  def update
    if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
      @player.turn_right
    end
    if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then
      @player.accelerate
    end

    @player.move
    @player.collect_stars(@stars)

    if rand(100) < 4 and @stars.size < 25 then
      @stars.push(Star.new(@star_anim))
    end
  end

  def draw
    @player.draw
    @background_image.draw(0, 0, 0);

    @stars.each { |star| star.draw }

    @font.draw("Score: #{@player.score}", 10, 10, 0, 1.0, 1.0, 0xff_ffff00)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
