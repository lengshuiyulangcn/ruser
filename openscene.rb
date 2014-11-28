class Openscene
   attr_accessor :background
  def initialize(background="background/pic2.jpg")
      @background=background
      @show_full=false
  end
  # load text from line number
  def load_bgm str
  end
  def load_background str
     @background=str
  end
  #show all of the selections
  def show_full
    @show_full=true
  end
end
