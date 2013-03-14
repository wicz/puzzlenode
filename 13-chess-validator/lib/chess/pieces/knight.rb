require_relative "../piece"

module Chess
  class Knight < Piece
    def initialize(color, board, square)
      super(color, :knight, board, square)
    end

    def can_move?(move)
      move.l?
    end
  end
end

