# frozen_string_literal: true

module Fighter
  class Stacy < Hero
    attr_reader :strength, :health, :speed, :agility


    def initialize(position:, window:)
      @strength = 15
      @health   = 100
      @speed    = 8
      @agility  = 3

      super
    end

    def name
      'Stacy'
    end

    def income_damage_anim
      {
        path: 'assets/images/characters/stacy/',
        name: 'damage-income',
        count: 3,
        ext: 'gif'
      }
    end

    def jump_anim
      {
        path: 'assets/images/characters/stacy/',
        name: 'jump',
        count: 1,
        ext: 'png'
      }
    end

    def move_anim
      {
        path: 'assets/images/characters/stacy/',
        name: 'move',
        count: 1,
        ext: 'gif'
      }
    end

    def idle_anim
      {
        path: 'assets/images/characters/stacy/',
        name: 'move',
        count: 1,
        ext: 'gif'
      }
    end

    def low_kick_anim
      {
        path: 'assets/images/characters/stacy/',
        name: 'l-kick',
        count: 6,
        ext: 'gif'
      }
    end

    def high_kick_anim
      {
        path: 'assets/images/characters/stacy/',
        name: 'h-kick',
        count: 4,
        ext: 'gif'
      }
    end

    def low_punch_anim
      {
        path: 'assets/images/characters/stacy/',
        name: 'l-punch',
        count: 3,
        ext: 'gif'
      }
    end

    def high_punch_anim
      {
        path: 'assets/images/characters/stacy/',
        name: 'h-punch',
        count: 3,
        ext: 'gif'
      }
    end
  end
end
