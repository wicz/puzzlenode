require_relative "../piece"

module Chess
  class Rook < Piece
    def initialize(color, board, square)
      super(color, :rook, board, square)
    end

    def can_move?(move)
      move.vertical? or move.horizontal?
      # TODO: castling
    end
  end
end

