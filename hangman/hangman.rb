class HangmanGame
    attr_reader :secret_word
  
    def initialize
      @dictionary = load_dictionary("google-10000-english-no-swears.txt")
      @secret_word = select_random_word(@dictionary)
      @guesses = []
      @incorrect_guesses = 0
      @max_incorrect_guesses = 6
    end
  
    def play
      puts "Welcome to Hangman!"
      puts "Guess the secret word. You can save the game at any time by typing 'save'."
      puts "The word has #{secret_word.length} characters."
  
      while @incorrect_guesses < @max_incorrect_guesses
        display_word_with_guesses
        puts "\n"
  
        print "Enter a letter: "
        guess = gets.chomp.downcase
  
        if guess == "save"
          save_game
          puts "Game saved. See you next time!"
          return
        end
  
        if valid_guess?(guess)
          if correct_guess?(guess)
            puts "Correct guess!"
          else
            puts "Incorrect guess!"
            @incorrect_guesses += 1
          end
        else
          puts "Invalid guess! Please enter a single letter."
        end
  
        break if game_over?
  
        puts "----------------------"
      end
  
      end_game
    end
  
    private
  
    def load_dictionary(file_path)
      words = []
      File.open(file_path, "r") do |file|
        file.each_line do |line|
          words << line.chomp
        end
      end
      words
    end
  
    def select_random_word(dictionary)
      filtered_words = dictionary.select { |word| word.length >= 5 && word.length <= 12 }
      filtered_words.sample.downcase
    end
  
    def display_word_with_guesses
      word_with_guesses = @secret_word.chars.map do |char|
        @guesses.include?(char) ? char : "_"
      end.join(" ")
  
      puts word_with_guesses
    end
  
    def valid_guess?(guess)
      guess.length == 1 && guess.match?(/[a-z]/)
    end
  
    def correct_guess?(guess)
      @guesses << guess
      @secret_word.include?(guess)
    end
  
    def game_over?
      @secret_word.chars.all? { |char| @guesses.include?(char) } || @incorrect_guesses == @max_incorrect_guesses
    end
  
    def end_game
      if @secret_word.chars.all? { |char| @guesses.include?(char) }
        puts "Congratulations! You won!"
      else
        puts "Sorry, you lost. The secret word was: #{@secret_word}"
      end
    end
  
    def save_game
      saved_data = Marshal.dump(self)
      File.open("saved_game.txt", "wb") do |file|
        file.write(saved_data)
      end
    end
  
    def self.load_game(file_path)
      saved_data = File.read(file_path)
      Marshal.load(saved_data)
    end
  end
  
  # Start a new game
  game = HangmanGame.new
  game.play
 
  
  
  
  
  
  
  
  