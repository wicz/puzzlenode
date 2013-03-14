require_relative '../chess'

module Chess
  class Validator

    FILES = %w{ a b c d e f g h }
    RANKS = %w{ 1 2 3 4 5 6 7 8 }.reverse

    def initialize(factory = PieceFactory.new)
      @piece_factory = factory
      @board = nil
    end

    def build_board(board_scheme = nil)
      board = Board.new
      board_scheme.split(/\n/).each_with_index do |line, i|
        rank = RANKS[i]
        line.split(/\s/).each_with_index do |square, k|
          file = FILES[k]
          next if square == "--"
          board.pieces["#{file}#{rank}"] = @piece_factory.new_piece(square, board, "#{file}#{rank}")
        end
      end
      board
    end

    def run(args)
      board_scheme = File.read(args.first)
      moves_scheme = File.read(args.last)
      moves_scheme.split(/\n/).each do |line|
        board = build_board(board_scheme)
        move = line.split(/\s/)
        # puts "#{board.pieces[move[0]].class}\t#{move[0]}:#{move[1]} #{board.move(*move) ? 'LEGAL' : 'ILLEGAL'}"
        puts board.move(*move) ? "LEGAL" : "ILLEGAL"
      end
    end
  end
end
