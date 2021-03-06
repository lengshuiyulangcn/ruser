require 'gosu'
class Save_panel < Gosu::TextInput
  # Some constants that define our appearance.
  INACTIVE_COLOR  = 0xcc666666
  ACTIVE_COLOR    = 0xccff6666
  SELECTION_COLOR = 0xcc0000ff
  CARET_COLOR     = 0xffffffff
  PADDING = 5

   attr_reader :height, :width

  def initialize(window, font, height=40,width=500)
    # TextInput's constructor doesn't expect any arguments.
    super()

    @window, @font, @height, @width = window, font, height, width
    @x=0
    @y=0
    @save_datas=Dir["*.data"]
    # Start with a self-explanatory text in each field.
    self.text = "null"
  end
  def filter text
    text.upcase
  end

  def draw
      background_color = INACTIVE_COLOR
      # @background = Gosu::Image.new(@window, 'background/pic2.jpg', true)
      # @background.draw(0, 0, 0)
    # 渲染文字框
    x=100
    y=0
    for i in 0..9
     y=i*60
    @window.draw_quad(x - PADDING,         y - PADDING,          background_color,
                      x + width + PADDING, y - PADDING,          background_color,
                      x - PADDING,         y + height + PADDING, background_color,
                      x + width + PADDING, y + height + PADDING, background_color, 0)
    if @save_datas.include? "save_data#{i.to_s}.data"
      title=Marshal.load(File.open("save_data#{i.to_s}.data").read).title
    @font.draw("save_data#{i.to_s}.data", x, y, 0)
    @font.draw(title, x, y+@font.height, 0)
    else
    @font.draw("No."+i.to_s, x, y, 0)
    end
    end
    @window.draw_quad(700,         100,         ACTIVE_COLOR,
                      750,         100,         ACTIVE_COLOR,
                      700,         150,         ACTIVE_COLOR,
                      750,         150,         ACTIVE_COLOR, 0)
    @font.draw("return", 700, (50-@font.height)/2+100, 0)
  end
#是否在该区域中发生点击
  def under_point?(mouse_x, mouse_y)
    mouse_x > x - PADDING and mouse_x < x + width + PADDING and
      mouse_y > y - PADDING and mouse_y < y + height + PADDING
  end
  def return_game(mouse_x, mouse_y)
    mouse_x > 700 - PADDING and mouse_x < 750 + PADDING and
      mouse_y > 100 - PADDING and mouse_y < 150 + PADDING
    end
  def which_selected(mouse_x, mouse_y)
      (0..9).to_a.find do |i|
          mouse_x > 100 - PADDING and mouse_x < 600 + PADDING and
            mouse_y > i*60 - PADDING and mouse_y < i*60 + 40 + PADDING
      end
  end
  # 保持实例数据的同步
  def flash_instance
    @save_datas=Dir["*.data"]
  end
end
