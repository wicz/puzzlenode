require_relative "../piece"

module Chess
  class Bishop < Piece
    def initialize(color, board, square)
      super(color, :bishop, board, square)
    end

    def can_move?(move)
      move.diagonal?
    end
  end
end

