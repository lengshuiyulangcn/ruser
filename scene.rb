class Scene
  attr_accessor :text_count, :background,:first_img
  def initialize
      @texts=File.open("test.txt").read.lines.map{|line| line.chomp}
      @text_count=0
      @background="background/pic2.jpg"
      @first_img=@background
  end
  def load_text(str,line)
      @texts=File.open(str).read.lines[line+1..-1].map{|line| line.chomp}
  end
  def load_bgm str
  end
  def load_background str
     @background=str
  end
  def load_character
  end
  def next_line
    @text_count+=1 if @text_count< @texts.size-1
    if @texts[@text_count][0]=='['
    parse_control
    @text_count+=1
    end
    @texts[@text_count]
  end
  def line
    @texts[@text_count]
  end

  private

  def parse_control
      commands=@texts[@text_count][1..-2].split(",")
      warn commands
      commands.each do |command|
          tokens=command.split("=")
          case tokens[0]
          when "background"
            load_background(tokens[1])
          when "bgm"
            load_bgm(tokens[1])
          else
            raise("no such command")
          end
      end
    end
end
