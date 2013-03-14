require_relative "../piece"

module Chess
  class Queen < Piece
    def initialize(color, board, square)
      super(color, :queen, board, square)
    end

    def can_move?(move)
      move.vertical? or move.horizontal? or move.diagonal?
    end
  end
end

