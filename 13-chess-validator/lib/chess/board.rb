module Chess
  class Board
    attr_accessor :pieces

  	def initialize(pieces = {})
  		@pieces = pieces
  	end

    def piece_at(square)
      return nil unless valid_squares?(square)

      @pieces[square]
    end

    def valid_squares?(*squares)
      squares.each do |square|
        return false unless square.to_s.match(/^[a-h][1-8]$/i)
      end

      true
    end

    def move(from, to)
      return false unless
        from != to and
        valid_squares?(from, to) and
        has_piece?(from)

      moved = piece_at(from).move(to)
      if moved
        @pieces[to] = @pieces[from]
        @pieces[from] = nil
      end

      moved
    end

    def free(square)
      !@pieces[square]
    end

    def has_piece?(square)
      !free(square)
    end

    def walk(from, direction, &block)
      path = []
      file = from[0].ord
      rank = from[1].to_i
      square = from
      direction = direction.to_s
      while valid_squares?(square)
        path << square
        file -= 1 if direction.match(/left/)
        file += 1 if direction.match(/right/)
        rank -= 1 if direction.match(/down/)
        rank += 1 if direction.match(/up/)
        square = "#{file.chr}#{rank}"
      end
      path.each { |square| yield square } if block_given?

      path
    end

    def l_squares_from(square)
      squares = []
      file = square[0].ord
      rank = square[1].to_i
      excludes = [[-2,2], [2,-2], [-1,1], [1,-1]]
      coords = [-2, -1, 1, 2].permutation(2).to_a - excludes
      coords.each do |x, y|
        squares << "#{(file + x).chr}#{rank + y}"
      end
      squares.delete_if { |sq| ! valid_squares? sq }
      squares
    end

    def check?(king, override_square = nil)
      perpendicular = [:up, :down, :left, :right]
      diagonal = [:upright, :upleft, :downright, :downleft]
      square = override_square || king.square

      l_squares_from(king.square).each do |sq|
        if has_piece?(sq)
          piece = piece_at(sq)
          return true if king.opponent?(piece) and piece.is_a?(Knight)
        end
      end

      (perpendicular + diagonal).each do |dir|
        walk(square, dir) do |sq|
          if has_piece?(sq)
            piece = piece_at(sq)
            break unless king.opponent? piece

            move = Move.new(square, sq)
            if move.vertical? or move.horizontal?
              return (piece.is_a?(Rook) or piece.is_a?(Queen))
            end

            if move.diagonal?
              return ((piece.is_a?(Bishop) or piece.is_a?(Queen)) or
                        (piece.is_a?(Pawn) and move.distance == 0 and
                        ((piece.black? and move.up?) or (piece.white? and move.down?))))
            end
          end
        end
      end

      false
    end
  end
end

