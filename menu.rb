require 'gosu'
class Menu < Gosu::TextInput
  INACTIVE_COLOR  = 0xcc666666
  ACTIVE_COLOR    = 0xccff6666
  SELECTION_COLOR = 0xcc0000ff
  CARET_COLOR     = 0xffffffff
  PADDING = 5

   attr_reader :height, :width, :x,:y

  def initialize(window, font, title,height=40,width=40)
    # TextInput's constructor doesn't expect any arguments.
    super()
    @window, @font, @height = window, font, height
    @x=0
    @y=0
    # Start with a self-explanatory text in each field.
    self.text =title
    @width=@font.text_width(title)
  end
  def filter text
    text.upcase
  end

  def draw(x,y)
      background_color = ACTIVE_COLOR
    @x=x
    @y=y
    # 渲染文字框
    @window.draw_quad(x - PADDING,         y - PADDING,          background_color,
                      x + width + PADDING, y - PADDING,          background_color,
                      x - PADDING,         y + height + PADDING, background_color,
                      x + width + PADDING, y + height + PADDING, background_color, 0)
    @font.draw(self.text, x, y, 0)
  end

  def under_point?(mouse_x, mouse_y)
    mouse_x > x - PADDING and mouse_x < x + width + PADDING and
      mouse_y > y - PADDING and mouse_y < y + height + PADDING
  end

end
