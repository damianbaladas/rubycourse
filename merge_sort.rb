def merge_sort(array)
    return array if array.length <= 1  # Base case: return the array if it has 0 or 1 element
  
    # Split the array into two halves
    mid = array.length / 2
    left_half = merge_sort(array[0...mid])
    right_half = merge_sort(array[mid..-1])
  
    # Merge the sorted halves
    merge(left_half, right_half)
end
  
def merge(left, right)
    sorted = []
  
    # Compare the elements in the left and right arrays and add them to the sorted array in the correct order
    while !left.empty? && !right.empty?
      if left[0] <= right[0]
        sorted << left.shift
      else
        sorted << right.shift
      end
    end
  
    # Add any remaining elements from the left or right array
    sorted.concat(left).concat(right)
end

puts merge_sort([5, 1, 3, 8, 2, 7, 4, 6])

  