# frozen_string_literal: true

require 'gosu'

module Fighter
  class Game < Gosu::Window
    P1_KEYS = [Gosu::KbA, Gosu::KbQ, Gosu::KbW, Gosu::KbS, Gosu::KbUp].freeze
    P2_KEYS = [Gosu::KbK, Gosu::KbI, Gosu::KbL, Gosu::KbO].freeze

    def initialize
      super(1024, 768, false)

      @p1_hero = Fighter::Stacy.new(window: self, position: :right)
      @p2_hero = Fighter::Stacy.new(window: self, position: :left)
      @winner  = nil
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
      draw_health_bars

      p1_keyboard_settings
      p2_keyboard_settings

      draw_winner
    end

    def update
      players_direction
    end

    private

    def draw_winner
      Gosu::Font.new(40).draw_text("#{@winner.name} WIN!", 475, 200, 10) if @winner
    end

    def draw_health_bars
      Gosu::Font.new(20).draw_text(@p1_hero.health, 700, 100, 3)
      Gosu::Font.new(20).draw_text(@p2_hero.health, 100, 100, 3)
    end

    def players_direction
      if @p2_hero.x_pos > @p1_hero.x_pos
        @p2_hero.scale = 1
        @p1_hero.scale = -1
      elsif
        @p2_hero.scale = -1
        @p1_hero.scale = 1
      end
    end

    def detect_colision(from:, to:, attack:)
      return if from.blocked?

      if (attack == :low_kick || attack == :low_punch) && ((from.x_pos - to.x_pos).to_r < 65)
        to.decrease_health(5)
      elsif (attack == :high_kick || attack == :high_punch) && ((from.x_pos - to.x_pos).to_r < 100)
        to.decrease_health(10)
      end

      @winner = from if to.died?
    end

    def p1_keyboard_settings
      @p1_hero.move_right if button_down?(Gosu::KbRight)
      @p1_hero.move_left if button_down?(Gosu::KbLeft)
    end

    def p2_keyboard_settings
    end

    def button_down(id)
      if P1_KEYS.include?(id)
        case id
        when Gosu::KbUp
          @p1_hero.jump
        when Gosu::KbA
          detect_colision(from: @p1_hero, to: @p2_hero, attack: :low_kick)
          @p1_hero.combat_action(:low_kick)
        when Gosu::KbQ
          detect_colision(from: @p1_hero, to: @p2_hero, attack: :high_kick)
          @p1_hero.combat_action(:high_kick)
        when Gosu::KbS
          detect_colision(from: @p1_hero, to: @p2_hero, attack: :low_punch)
          @p1_hero.combat_action(:low_punch)
        when Gosu::KbW
          detect_colision(from: @p1_hero, to: @p2_hero, attack: :high_punch)
          @p1_hero.combat_action(:high_punch)
        end
      end

      if P2_KEYS.include?(id)
        case id
        when Gosu::KbK
          detect_colision(from: @p2_hero, to: @p1_hero, attack: :low_kick)
          @p2_hero.combat_action(:low_kick)
        when Gosu::KbI
          detect_colision(from: @p2_hero, to: @p1_hero, attack: :high_kick)
          @p2_hero.combat_action(:high_kick)
        when Gosu::KbL
          detect_colision(from: @p2_hero, to: @p1_hero, attack: :low_punch)
          @p2_hero.combat_action(:low_punch)
        when Gosu::KbO
          detect_colision(from: @p2_hero, to: @p1_hero, attack: :high_punch)
          @p2_hero.combat_action(:high_punch)
        end
      end
    end
  end
end
