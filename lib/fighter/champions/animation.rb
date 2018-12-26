# frozen_string_literal: true

module Fighter
  class Animation
    def initialize(images_info, duration)
      @path = images_info[:path]
      @name = images_info[:name]
      @count = images_info[:count]
      @ext = images_info[:ext]
      @frame = 1
      @duration = duration
      @current_loop = 0
      @started_at = 0
      @finished = false
    end

    def play
      @started_at = Gosu.milliseconds
    end

    def current_frame
      return render_path if !@duration || !@count || finished?

      deviation = Gosu.milliseconds - @started_at
      recounted = (deviation / (@duration / @count)).to_i

      return render_path if deviation.to_i > @duration.to_i && @finished = true

      if recounted == 0
        @frame = 1
      elsif recounted.to_i >= @count
        @frame = @count - 1
      else
        @frame = recounted
      end

      render_path
    end

    def render_path
      if @count == 1
        "#{@path}#{@name}.#{@ext}"
      else
        "#{@path}#{@name}-#{@frame + 1}.#{@ext}"
      end
    end

    def finished?
      @finished
    end
  end
end
