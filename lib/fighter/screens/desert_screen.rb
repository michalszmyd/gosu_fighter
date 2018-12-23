# frozen_string_literal: true

module Fighter
  class DesertScreen < Game
    def initialize
      @background = load_image(src: 'assets/images/desert.jpg')
    end

    def draw
      @background.draw(0, 0, 1)
    end
  end
end
