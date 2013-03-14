module Chess
  class Move
    attr_reader :from, :to

    def initialize(from, to)
      @from = from
      @to = to
    end

    def file(square)
      square[0]
    end

    def rank(square)
      square[1]
    end

    def up?
      rank(@to) > rank(@from)
    end

    def down?
      rank(@to) < rank(@from)
    end

    def left?
      file(@to) < file(@from)
    end

    def right?
      file(@to) > file(@from)
    end

    def vertical?
      (file(@from) == file(@to)) and (up? or down?)
    end

    def horizontal?
      (rank(@from) == rank(@to)) and (left? or right?)
    end

    def diagonal?
      delta_file = (file(@to).ord - file(@from).ord).abs
      delta_rank = (rank(@to).to_i - rank(@from).to_i).abs
      delta_file == delta_rank
    end

    def l?
      delta_file = (file(@to).ord - file(@from).ord).abs
      delta_rank = (rank(@to).to_i - rank(@from).to_i).abs
      [[1, 2], [2, 1]].include? [delta_file, delta_rank]
    end

    def valid?
      vertical? or horizontal? or diagonal? or l?
    end

    def distance
      path.size
    end

    def path
      path = []
      files = Range.new(*[file(@from), file(@to)].minmax, true)
      ranks = Range.new(*[rank(@from), rank(@to)].minmax, true)
      if vertical?
        path = ranks.map { |rank| "#{file(@to)}#{rank}" }
        path.shift
        up? ? path : path.reverse
      elsif horizontal?
        path = files.map { |file| "#{file}#{rank(@to)}" }
        path.shift
        right? ? path : path.reverse
      elsif diagonal?
        files = files.map { |f| f }
        ranks = ranks.map { |r| r }
        files.shift
        ranks.shift
        files.reverse! if left?
        ranks.reverse! if down?
        files.each_with_index { |f, i| path << "#{f}#{ranks[i]}" }
        path
      elsif l?
        path
      end
    end
  end
end

