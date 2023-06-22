def bubble_sort(array)
    n = array.length
  
    # Perform n-1 iterations
    (n - 1).times do
      swapped = false
  
      # Compare adjacent elements and swap if necessary
      (0..n - 2).each do |i|
        if array[i] > array[i + 1]
          array[i], array[i + 1] = array[i + 1], array[i]
          swapped = true
        end
      end
  
      # If no swaps were made in an iteration, the array is already sorted
      break unless swapped
    end
  
    array
  end

  puts bubble_sort([4, 3, 78, 2, 0, 2])