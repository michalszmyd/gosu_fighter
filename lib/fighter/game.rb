# frozen_string_literal: true

require 'gosu'

module Fighter
  class Game < Gosu::Window
    def initialize
      super(640, 480, false)
    end

    def load_image(src:)
      Gosu::Image.new(self, src, false)
    end

    def draw
      Fighter::WelcomeScreen.new.draw
    end
  end
end
