# frozen_string_literal: true

module Fighter
  class WelcomeScreen < Fighter::Game
    def initialize
      @background = load_image(src: 'assets/images/1.jpg')
    end

    def draw
      @background.draw(100, 100, 100)
    end
  end
end
