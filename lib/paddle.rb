require_relative './quad'

class Paddle < Quad
  WIDTH = 16
  HEIGHT = 96
  SPEED = 6
  attr_reader :side, :y, :ai

  alias ai? ai

  def initialize side, ai=false
    @ai = ai
    @side = side
    @y = Pong::HEIGHT / 2
  end

  def x1
    case @side
    when :left
      0
    when :right
      Pong::WIDTH - WIDTH
    end
  end

  def x2
    x1 + WIDTH
  end

  def y1
    y - HEIGHT/2
  end

  def y2
    y1 + HEIGHT
  end

  def up!
    @y -= SPEED

    if y1 < 0
      @y = HEIGHT / 2
    end
  end

  def down!
    @y += SPEED
    @y = Pong::HEIGHT if @y > Pong::HEIGHT

    if y2 > Pong::HEIGHT
      @y = Pong::HEIGHT - HEIGHT/2
    end
  end

  def ai_move! ball
    if ball.y > y
      down!
    elsif ball.y < y
      up!
    end
  end
end
