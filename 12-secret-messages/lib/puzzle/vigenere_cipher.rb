class VigenereCipher

  attr_accessor :alphabet, :caesar, :key

  def initialize(alphabet = ('A'..'Z').to_a)
    @alphabet = alphabet
    @caesar = CaesarCipher.new(@alphabet)
  end

  def encrypt(text)
    process_text(text) do |char, key_char|
      @caesar.encrypt(char, key_char)
    end
  end

  def decrypt(text)
    process_text(text) do |char, key_char|
      @caesar.decrypt(char, key_char)
    end
  end

  def process_text(text)
    key = @key * text.size
    new_text = ''
    key_index = 0
    text.chars do |char|
      key_char = key[key_index]
      new_char = yield(char, key_char)
      key_index += 1 if @alphabet.include? char
      new_text += new_char
    end
    new_text
  end

end