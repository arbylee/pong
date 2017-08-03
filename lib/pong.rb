class Pong < Gosu::Window
  WIDTH = 768
  HEIGHT = 576

  def initialize options
    super WIDTH, HEIGHT, false
    self.caption = "Pong"
    @left_score = 0
    @right_score = 0
    @font = Gosu::Font.new(self, Gosu::default_font_name, 30)

    @left_paddle = Paddle.new(:left, options[:ai])
    @right_paddle = Paddle.new(:right)
    @ball_count = options[:balls]
    @balls = []
    @ball_count.times do
      @balls.push(Ball.new)
    end
    self.show
  end

  def update
    @balls.each do |ball|
      ball.update
      if ball.off_left?
        @right_score += 1
        ball.reset
      end

      if ball.off_right?
        @left_score += 1
        ball.reset
      end

      if ball.intersect?(@left_paddle)
        ball.bounce_off_paddle!(@left_paddle)
      end

      if ball.intersect?(@right_paddle)
        ball.bounce_off_paddle!(@right_paddle)
      end
    end

    if @left_paddle.ai?
      @left_paddle.ai_move!(@balls[0])
    else
      if button_down?(Gosu::KbW)
        @left_paddle.up!
      end

      if button_down?(Gosu::KbS)
        @left_paddle.down!
      end
    end

    if button_down?(Gosu::KbUp)
      @right_paddle.up!
    end

    if button_down?(Gosu::KbDown)
      @right_paddle.down!
    end
  end

  def draw
    @balls.each do |ball|
      ball.draw(self)
    end
    @left_paddle.draw(self)
    @right_paddle.draw(self)
    @font.draw(@left_score, 30, 30, 0)
    @font.draw(@right_score, WIDTH-50, 30, 0)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end
