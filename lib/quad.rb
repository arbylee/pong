class Quad
  def draw window
    color = Gosu::Color::WHITE
    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color,
    )
  end
end
