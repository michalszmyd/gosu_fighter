# frozen_string_literal: true

module Fighter
  class Hero
    ANIMATION_EXECUTE_DEFAULT = 500

    def initialize(position:, window:)
      @window          = window
      @position        = position
      @current_anim    = :idle
      @blocked         = false
      @penality_combat = 1
      @animation       = Animation.new(idle_anim, 1)

      @y_pos = 700
      @x_pos = position == :left ? 100 : 1000
    end

    def draw
      if @animation.finished?
        @current_anim = :idle
        @animation = Animation.new(idle_anim, 1)
        @blocked = false
      end

      @window.load_image(src: @animation.current_frame).draw_rot(@x_pos, @y_pos, 2, 0)
    end

    def animation_execute_time
      ANIMATION_EXECUTE_DEFAULT / agility * @penality_combat
    end

    def blocked?
      @blocked
    end

    def move_left
      return if blocked?

      @current_anim = :idle
      @x_pos -= speed
    end

    def move_right
      return if blocked?

      @current_anim = :move

      @animation = Animation.new(send(:"#{@current_anim}_anim"), 0)
      @animation.play

      @x_pos += speed
    end

    def jump
      return if blocked?

      @current_anim = :jump

      @animation = Animation.new(send(:"#{@current_anim}_anim"), { duration: 13, count: 1 })
      @animation.play
      @blocked = true

      @y_pos -= 15
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
      @animation = Animation.new(send(:"#{@current_anim}_anim"), animation_execute_time)
      @animation.play
      @blocked = true

      @x_pos
    end
  end
end
