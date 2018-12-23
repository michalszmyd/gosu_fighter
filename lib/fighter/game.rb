# frozen_string_literal: true

require 'gosu'

module Fighter
  class Game < Gosu::Window
    def initialize
      super(1024, 768, false)

      @p1_hero = Fighter::Stacy.new(window: self, position: :right)
      @p2_hero = Fighter::Stacy.new(window: self, position: :left)
    end

    def load_image(src:)
      Gosu::Image.new(self, src, true)
    end

    def load_tiles(src:)
      Gosu::Image.load_tiles(src, 1, 1)
    end

    def draw
      Fighter::DesertScreen.new.draw
      @p1_hero.draw
      @p2_hero.draw
    end

    def update
      @p1_hero.move_right if button_down?(Gosu::KbRight)
      @p1_hero.move_left if button_down?(Gosu::KbLeft)

      @p1_hero.jump if button_down?(Gosu::KbUp)

      @p1_hero.combat_action(:low_kick) if button_down?(Gosu::KbA)
      @p1_hero.combat_action(:high_kick) if button_down?(Gosu::KbQ)
      @p1_hero.combat_action(:low_punch) if button_down?(Gosu::KbS)
      @p1_hero.combat_action(:high_punch) if button_down?(Gosu::KbW)
    end
  end
end
