require 'gosu'
class TextField < Gosu::TextInput
  # Some constants that define our appearance.
  INACTIVE_COLOR  = 0xcc666666
  ACTIVE_COLOR    = 0xccff6666
  SELECTION_COLOR = 0xcc0000ff
  CARET_COLOR     = 0xffffffff
  PADDING = 5

   attr_reader :height, :width, :x,:y

  def initialize(window, font, height=100,width=700)
    # TextInput's constructor doesn't expect any arguments.
    super()

    @window, @font, @height, @width = window, font, height, width
    @x=0
    @y=0
    # Start with a self-explanatory text in each field.
    self.text = ""
  end
  def filter text
    text.upcase
  end

  def draw(x,y)
      background_color = INACTIVE_COLOR
    @x=x
    @y=y
    # 渲染文字框
    @window.draw_quad(x - PADDING,         y - PADDING,          background_color,
                      x + width + PADDING, y - PADDING,          background_color,
                      x - PADDING,         y + height + PADDING, background_color,
                      x + width + PADDING, y + height + PADDING, background_color, 0)
    @font.draw(self.text, x, y, 0)
  end
#是否在该区域中发生点击
  def under_point?(mouse_x, mouse_y)
    mouse_x > x - PADDING and mouse_x < x + width + PADDING and
      mouse_y > y - PADDING and mouse_y < y + height + PADDING
  end

  # Tries to move the caret to the position specifies by mouse_x
  def move_caret(mouse_x)
    # Test character by character
    1.upto(self.text.height) do |i|
      if mouse_x < x + @font.text_width(text[0...i]) then
        self.caret_pos = self.selection_start = i - 1;
        return
      end
    end
    # Default case: user must have clicked the right edge
    # self.caret_pos = self.selection_start = self.text.height
  end
end
