# frozen_string_literal: true

module Fighter
  class Hero
    attr_accessor :scale
    attr_reader :x_pos, :health

    ANIMATION_EXECUTE_DEFAULT = 500

    def initialize(position:, window:)
      @window          = window
      @position        = position
      @current_anim    = :idle
      @blocked         = false
      @penality_combat = 1
      @animation       = Animation.new(idle_anim, 1)

      play_anim(1)

      @y_pos = 700
      @x_pos = position == :left ? 500 : 700

      @scale = position == :left ? -1 : 1
    end

    def died?
      return if health > 0
      true
    end

    def decrease_health(points)
      @health -= points

      @current_anim = :income_damage
      play_anim_blocked(100)
    end

    def draw
      if @animation.finished?
        @current_anim = :idle
        @y_pos = 700
        @animation = Animation.new(idle_anim, 1)
        @blocked = false
      end

      @window.load_image(src: @animation.current_frame).draw_rot(@x_pos, @y_pos, 2, 0, 0.5, 0.5, scale)
    end

    def animation_execute_time
      ANIMATION_EXECUTE_DEFAULT / agility * @penality_combat
    end

    def blocked?
      @blocked
    end

    def move_left
      return if blocked?

      @current_anim = :move
      play_anim(1)

      @x_pos -= speed
    end

    def move_right
      return if blocked?

      @current_anim = :move
      play_anim(1)

      @x_pos += speed
    end

    def jump
      return if in_jump? || blocked?

      @current_anim = :jump
      play_anim(200)

      @y_pos -= 100
    end

    def in_jump?
      @current_anim == :jump
    end

    def combat_action(name)
      return if blocked?

      case name
      when (:low_kick || :low_punch)
        @penality_combat = 1
      when (:high_kick || :high_punch)
        @penality_combat = 1.3
      end

      @current_anim = name
      play_anim_blocked(animation_execute_time)

      @x_pos
    end

    def play_anim(duration)
      @animation = Animation.new(send(:"#{@current_anim}_anim"), duration)
      @animation.play
    end

    def play_anim_blocked(duration)
      @animation = Animation.new(send(:"#{@current_anim}_anim"), duration)
      @animation.play
      @blocked = true
    end
  end
end
