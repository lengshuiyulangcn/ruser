require "./flag.rb"
class Scene
  attr_accessor :text_count, :background,:active_flag,:flags
  def initialize
      @texts=File.open("test.txt").read.lines.map{|line| line.chomp}
      @text_count=0
      @background="background/pic2.jpg"
      @flags=[]
      @active_flag=''
  end
  def load_text(str,line=0)
      @texts=File.open(str).read.lines[line..-1].map{|line| line.chomp}
      @text_count=-1
      # print @texts
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
  i=@text_count
  while @texts[i][0]=='[' and @text_count!=0
      i=i-1
  end
  return  @texts[i]
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
          when "flags"
            flag=Flag.new(tokens[1])
            # @flags<< flag
            @active_flag=flag
          else
            raise("no such command")
          end
      end
    end
end
