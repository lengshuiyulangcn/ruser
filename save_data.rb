
class SaveData
    attr_accessor :scene,:title
    def initialize(scene,img='',title='')
        @scene=scene
        @icon=img
        @title=title
    end
end
