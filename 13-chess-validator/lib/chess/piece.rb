require_relative 'move'

module Chess
  class Piece
    attr_reader :type, :color, :board, :square

    def initialize(color, type, board, square)
      @color = color
      @type = type
      @board = board
      @square = square
    end

    def can_move?(to)
      raise '#can_move? must be implemented in child classes'
    end

    def opponent?(piece)
      piece.color != @color
    end

    def white?
      color == :white
    end

    def black?
      color == :black
    end

    def move(to)
      move = Move.new(@square, to)
      return false unless move.valid? and can_move?(move)

      move.path.each do |square|
        return false unless @board.free(square)
      end

      unless @board.free(to)
        return false unless opponent?(@board.piece_at(to))
      end

      @square = to
      true
    end
  end
end

