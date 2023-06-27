def generate_secret_code
  # Generates a random secret code of four unique numbers from 1 to 6.
  secret_code = (1..6).to_a.sample(4)
  secret_code
end

def get_guess
  # Asks the human player for a guess and returns an array of four numbers.
  loop do
    print "Enter your guess (four numbers from 1 to 6): "
    guess = gets.chomp.split.map(&:to_i)
    return guess if guess.length == 4 && guess.all? { |num| (1..6).include?(num) }
    puts "Invalid guess. Please try again."
  end
end

def evaluate_guess(secret_code, guess)
  # Compares the guess with the secret code and returns the number of exact matches and partial matches.
  exact_matches = 0
  partial_matches = 0

  secret_counts = Array.new(6, 0)
  guess_counts = Array.new(6, 0)

  secret_code.each_with_index do |num, index|
    if num == guess[index]
      exact_matches += 1
    else
      secret_counts[num - 1] += 1
      guess_counts[guess[index] - 1] += 1
    end
  end

  partial_matches = secret_counts.zip(guess_counts).map { |a, b| [a, b].min }.sum

  [exact_matches, partial_matches]
end

def display_feedback(exact_matches, partial_matches)
  # Displays the feedback to the player based on the number of exact matches and partial matches.
  puts "Exact matches: #{exact_matches}"
  puts "Partial matches: #{partial_matches}"
end

def play_mastermind
  puts "Welcome to Mastermind!"
  secret_code = generate_secret_code

  12.times do |turn|
    puts "\nTurn #{turn + 1}:"
    guess = get_guess
    exact_matches, partial_matches = evaluate_guess(secret_code, guess)
    display_feedback(exact_matches, partial_matches)

    if exact_matches == 4
      puts "\nCongratulations! You guessed the secret code correctly!"
      return
    end

    if turn == 11
      puts "\nGame over! You ran out of turns. The secret code was: #{secret_code.join(' ')}"
    end
  end
end

loop do
  play_mastermind
  print "Do you want to play again? (yes/no): "
  play_again = gets.chomp.downcase
  break if play_again == "no"
end
