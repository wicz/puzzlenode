module Chess
  class PieceFactory

    def new_piece(notation, board, square)
      color = color_from_notation(notation)
      klass = type_from_notation(notation)
      klass.new(color, board, square)
    end

    def color_from_notation(notation)
      case notation[0]
      when 'w' then :white
      when 'b' then :black
      else raise "Unknown color"
      end
    end

    def type_from_notation(notation)
      case notation[1]
      when 'R' then Rook
      when 'B' then Bishop
      when 'N' then Knight
      when 'Q' then Queen
      when 'K' then King
      when 'P' then Pawn
      else raise "Unknown type"
      end
    end

  end
end