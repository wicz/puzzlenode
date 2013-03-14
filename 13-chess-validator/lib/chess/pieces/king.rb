require_relative "../piece"

module Chess
  class King < Piece
    def initialize(color, board, square)
      super(color, :king, board, square)
    end

    def can_move?(move)
      (move.vertical? or move.horizontal? or move.diagonal?) and
      move.distance == 0 and
      !@board.check?(self, move.to)
      # TODO: castling
    end
  end
end

