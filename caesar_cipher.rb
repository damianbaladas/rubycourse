def caesar_cipher(text, shift)
    result = ""
    
    text.each_char do |char|
      ascii = char.ord
      
      if char.match(/[a-z]/i)
        base = char =~ /[a-z]/ ? 'a'.ord : 'A'.ord
        shifted_ascii = ((ascii - base + shift) % 26) + base
        result += shifted_ascii.chr
      else
        result += char
      end
    end
    
    result
  end
  
  # Ejemplo de uso
  plaintext = "Hola, Mundo!"
  shift_amount = 3
  ciphertext = caesar_cipher(plaintext, shift_amount)
  
  puts "Texto original: #{plaintext}"
  puts "Texto cifrado: #{ciphertext}"