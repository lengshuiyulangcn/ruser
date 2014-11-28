class Flag
  attr_accessor :flags,:selected
  def initialize(str)
      @flags=[]
      str.split(':').each do |f|
        tokens=f.split('#')
        at=tokens[1].split('@')
      @flags << [tokens[0],at[0],at[1]]
      @selected=-1
    end
  end
  def selected_content
        @flags[@selected]
  end
  def selected
      @selected
  end
end
