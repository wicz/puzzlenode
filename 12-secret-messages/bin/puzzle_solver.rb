require "puzzle"

class PuzzleSolver
  def self.solve
    key, text = File.read("data/complex_cipher.txt").split(/^$/)
    key.strip!
    caesar = CaesarCipher.new
    keys = []

    caesar.alphabet.each_with_index do |char|
      keys << caesar.decrypt(key, char)
    end

    keys.each_with_index do |item, i|
      puts "#{i}: #{item}"
    end

    opt = gets.chomp.to_i
    vigenere = VigenereCipher.new
    vigenere.key = keys[opt]
    puts vigenere.decrypt(text)
  end
end

PuzzleSolver.solve

