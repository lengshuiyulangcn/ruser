require 'gosu'
class Flagscene < Gosu::TextInput
  # Some constants that define our appearance.
  INACTIVE_COLOR  = 0xcc666666
  ACTIVE_COLOR    = 0xccff6666
  SELECTION_COLOR = 0xcc0000ff
  CARET_COLOR     = 0xffffffff
  PADDING = 5

   attr_reader :height, :width

  def initialize(window, font,flag,height=40,width=500)
    # TextInput's constructor doesn't expect any arguments.
    super()

    @window, @font, @height, @width = window, font, height, width
    @x=0
    @y=0
    @flag=flag
  end
  def filter text
    text.upcase
  end

  def draw
      background_color = INACTIVE_COLOR
    # 渲染文字框
    x=100
    y=300
    for i in 0..@flag.flags.size-1
     y=300+i*60
    @window.draw_quad(x - PADDING,         y - PADDING,          background_color,
                      x + width + PADDING, y - PADDING,          background_color,
                      x - PADDING,         y + height + PADDING, background_color,
                      x + width + PADDING, y + height + PADDING, background_color, 0)
    @font.draw(@flag.flags[i][0],x,y,0)
    end
  end
#是否在该区域中发生点击
  def under_point?(mouse_x, mouse_y)
    mouse_x > x - PADDING and mouse_x < x + width + PADDING and
      mouse_y > y - PADDING and mouse_y < y + height + PADDING
  end

  def which_selected(mouse_x, mouse_y)
      (0..@flag.flags.size-1).to_a.find do |i|
          mouse_x > 100 - PADDING and mouse_x < 600 + PADDING and
            mouse_y > 300+i*60 - PADDING and mouse_y < 300+i*60 + 40 + PADDING
      end
  end
  # 保持实例数据的同步
  # def flash_instance
  #   @save_datas=Dir["*.data"]
  # end
end
