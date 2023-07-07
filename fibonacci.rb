def fibs(n)
    sequence = [0, 1]  # Initialize the sequence with the first two Fibonacci numbers
  
    (n - 2).times do  # Subtract 2 to account for the initial numbers
      next_number = sequence[-1] + sequence[-2]  # Calculate the next Fibonacci number
      sequence << next_number  # Add the next number to the sequence
    end
  
    sequence
end

def fibs_rec(n, sequence = [0, 1])
    return sequence[0, n] if sequence.length >= n
  
    next_number = sequence[-1] + sequence[-2]
    sequence << next_number
  
    fibs_rec(n, sequence)
end

puts fibs(8)

puts fibs_rec(8)

