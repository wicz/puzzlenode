class CaesarCipher

  attr_accessor :alphabet

  def initialize(alphabet = ('A'..'Z').to_a)
    @alphabet = alphabet
  end

  def encrypt(text, key)
    process_text(text, key) do |char, key_index|
      encrypt_char(char, key_index)
    end
  end

  def decrypt(text, key)
    process_text(text, key) do |char, key_index|
      decrypt_char(char, key_index)
    end
  end

  def encrypt_char(char_index, key_index)
    cipher_index = (char_index + key_index) % alphabet_size
    @alphabet[cipher_index]
  end

  def decrypt_char(char_index, key_index)
    cipher_index = (char_index - key_index) % alphabet_size
    @alphabet[cipher_index]
  end

  def alphabet_size
    @alphabet_size ||= @alphabet.size
  end

  def process_text(text, key, &block)
    key_index = @alphabet.index(key)
    raise RuntimeError unless key_index
    new_text = ''
    text.chars do |char|
      char_index = @alphabet.index(char)
      new_char = char_index ? yield(char_index, key_index) : char
      new_text += new_char
    end
    new_text
  end

end