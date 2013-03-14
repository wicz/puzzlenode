require_relative "../piece"

module Chess
  class Pawn < Piece
    def initialize(color, board, square)
      super(color, :pawn, board, square)
    end

    def can_move?(move)
      first_move = ['2', '7'].include? move.from[1]
      one_or_to_squares = first_move ? move.distance <= 1 : move.distance == 0

      ((white? and move.up?) or (black? and move.down?)) and

      (
        (move.vertical? and one_or_to_squares) or

        (move.diagonal? and
          piece = @board.piece_at(move.to) and
          opponent?(piece) and
          move.distance == 0)
      )
      # TODO: en passant
    end
  end
end

