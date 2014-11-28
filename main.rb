require "./scene.rb"
require "./textfield.rb"
require "./menu.rb"
require "./flag.rb"
require "./flagscene.rb"
require "./save_panel.rb"
require "./load_panel.rb"
require "./openscene.rb"
require "./save_data.rb"
require 'gosu'
class TextInputWindow < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "Novel Engine"
    font = Gosu::Font.new(self, Gosu::default_font_name, 25)
    @text_field=TextField.new(self,font)
    @savepanel=Save_panel.new(self,font)
    @loadpanel=Save_panel.new(self,font)
    @cursor = Gosu::Image.new(self, "media/Cursor.png", false)
    @scene=Scene.new
    @openscene=Openscene.new
    @background = Gosu::Image.new(self, @openscene.background, true)
    @text_field.text=@scene.line
    @start=Menu.new(self,font,"start")
    @save=Menu.new(self,font,"save")
    @load=Menu.new(self,font,"load")
    @config=Menu.new(self,font,"config")
    @title=Menu.new(self,font,"title")
    @playingscene=@openscene
  end

  def draw
      case @playingscene
      when @scene
        draw_scene
      when @openscene
       draw_openscene
     when @savepanel
       @savepanel.draw
     when @loadpanel
         @loadpanel.draw
    when @flagscene
        @background.draw(0, 0, 0)
        @text_field.text=@scene.line
        @text_field.draw(50,500)
        if mouse_y >550
        @save.draw(100,580)
        @load.draw(200,580)
        @config.draw(300,580)
        @title.draw(400,580)
        end
        @flagscene.draw
      end
    @cursor.draw(mouse_x, mouse_y, 0)
  end

  def update
      #skip

  end

  def button_down(id)
    if id == Gosu::MsLeft
      case @playingscene
      when @scene
        if mouse_y<550
             show_next
        end
      if @scene.active_flag!=""
        @flagscene=Flagscene.new(self,Gosu::Font.new(self, Gosu::default_font_name, 25),@scene.active_flag)
        @playingscene=@flagscene
      end
        if @title.under_point?(mouse_x, mouse_y)
            jmp_title
      elsif @save.under_point?(mouse_x,mouse_y)
          @playingscene=@savepanel
          # save_data
        elsif @load.under_point?(mouse_x,mouse_y)
          @playingscene=@loadpanel
          # load_data
        end
       when @openscene
         if @start.under_point?(mouse_x, mouse_y)
           start_game
       elsif @load.under_point?(mouse_x, mouse_y)
          @playingscene=@loadpanel
        elsif @save.under_point?(mouse_x,mouse_y)
              @playingscene=@savepanel
         end
       when @savepanel
          if @savepanel.return_game(mouse_x, mouse_y)
              @playingscene=@scene
              @background = Gosu::Image.new(self, @scene.background, true)
              @text_field.text=@scene.line
          else
            selected=@savepanel.which_selected(mouse_x, mouse_y)
              if selected!=nil
                  save_data("save_data"+selected.to_s+".data")
                  @savepanel.flash_instance
              end
            end
        when @loadpanel
           if @loadpanel.return_game(mouse_x, mouse_y)
               @playingscene=@scene
               @background = Gosu::Image.new(self, @scene.background, true)
               @text_field.text=@scene.line
           else
             selected=@loadpanel.which_selected(mouse_x, mouse_y)
               if selected!=nil and Dir['*.data'].include? "save_data"+selected.to_s+".data"
                   load_data("save_data"+selected.to_s+".data")
                   @loadpanel.flash_instance
               end
             end
        when @flagscene
            @text_field.text=@scene.line
            selected=@flagscene.which_selected(mouse_x, mouse_y)
            if selected!=nil
              # @scene.active_flag=""
              @scene.load_text @scene.active_flag.flags[selected][1],@scene.active_flag.flags[selected][2].to_i
              @playingscene=@scene
              @scene.active_flag.selected=selected
              @scene.flags << @flag
              @scene.active_flag=""
              @text_field.text=@scene.next_line
            end
            if @title.under_point?(mouse_x, mouse_y)
                jmp_title
          elsif @save.under_point?(mouse_x,mouse_y)
              @playingscene=@savepanel
              # save_data
            elsif @load.under_point?(mouse_x,mouse_y)
              @playingscene=@loadpanel
              # load_data
            end
       end
  end
end

  def draw_scene
      @background.draw(0, 0, 0)
      @text_field.draw(50,500)
      if mouse_y >550
      @save.draw(100,580)
      @load.draw(200,580)
      @config.draw(300,580)
      @title.draw(400,580)
      end
  end
  def draw_openscene
      @background.draw(0, 0, 0)
      @start.draw(100,100)
      @load.draw(100,200)
      @config.draw(100,300)
  end
  def load_data(name="save.data")
    str=File.open(name).read
    @scene=Marshal.load(str).scene
    @playingscene=@scene
    @background = Gosu::Image.new(self, @scene.background, true)
    @text_field.text=@scene.line
    warn "load success"
  end
  def save_data(name="save.data")
    data=SaveData.new(@scene,'',@scene.line)
    str=Marshal.dump(data)
    file=File.open(name,"w")
    file.print str
    file.close
    warn "save success"
  end
  def start_game
    @scene=Scene.new
    @playingscene=@scene
    @text_field.text=@scene.line
    @background = Gosu::Image.new(self, @scene.background, true)
  end
  def jmp_title
      @playingscene=@openscene
      @background = Gosu::Image.new(self, @openscene.background, true)
  end
  def show_next
  @background = Gosu::Image.new(self, @scene.background, true)
  @text_field.text=@scene.next_line
  end
end

TextInputWindow.new.show
