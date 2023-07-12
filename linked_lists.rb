class Node
    attr_accessor :value, :next_node
  
    def initialize(value)
      @value = value
      @next_node = nil
    end
end
  
class LinkedList
    def initialize
      @head = nil
      @tail = nil
    end
  
    def append(value)
      new_node = Node.new(value)
  
      if @head.nil?
        @head = new_node
        @tail = new_node
      else
        @tail.next_node = new_node
        @tail = new_node
      end
    end
  
    def prepend(value)
      new_node = Node.new(value)
  
      if @head.nil?
        @head = new_node
        @tail = new_node
      else
        new_node.next_node = @head
        @head = new_node
      end
    end
  
    def size
      count = 0
      current_node = @head
  
      while !current_node.nil?
        count += 1
        current_node = current_node.next_node
      end
  
      count
    end
  
    def head
      @head
    end
  
    def tail
      @tail
    end
  
    def at(index)
      return nil if index < 0 || index >= size
  
      current_node = @head
      count = 0
  
      while count < index
        current_node = current_node.next_node
        count += 1
      end
  
      current_node
    end
  
    def pop
      return nil if @head.nil?
  
      if @head == @tail
        popped_node = @head
        @head = nil
        @tail = nil
        return popped_node
      end
  
      current_node = @head
  
      while current_node.next_node != @tail
        current_node = current_node.next_node
      end
  
      popped_node = @tail
      @tail = current_node
      @tail.next_node = nil
  
      popped_node
    end
  
    def contains?(value)
      current_node = @head
  
      while !current_node.nil?
        return true if current_node.value == value
        current_node = current_node.next_node
      end
  
      false
    end
  
    def find(value)
      current_node = @head
      index = 0
  
      while !current_node.nil?
        return index if current_node.value == value
        current_node = current_node.next_node
        index += 1
      end
  
      nil
    end
  
    def to_s
      return 'Empty list' if @head.nil?
  
      current_node = @head
      result = ""
  
      while !current_node.nil?
        result += "( #{current_node.value} ) -> "
        current_node = current_node.next_node
      end
  
      result += "nil"
  
      result
    end
  
    def insert_at(value, index)
      return if index < 0 || index > size
  
      if index == 0
        prepend(value)
      elsif index == size
        append(value)
      else
        new_node = Node.new(value)
        current_node = @head
        count = 0
  
        while count < index - 1
          current_node = current_node.next_node
          count += 1
        end
  
        new_node.next_node = current_node.next_node
        current_node.next_node = new_node
      end
    end
  
    def remove_at(index)
      return if index < 0 || index >= size
  
      if index == 0
        @head = @head.next_node
        @tail = nil if @head.nil?
      else
        current_node = @head
        count = 0
  
        while count < index - 1
          current_node = current_node.next_node
          count += 1
        end
  
        if current_node.next_node == @tail
          current_node.next_node = nil
          @tail = current_node
        else
          current_node.next_node = current_node.next_node.next_node
        end
      end
    end
  end
  
  # Prueba de la clase LinkedList
  list = LinkedList.new
  
  list.append(1)
  list.append(2)
  list.prepend(3)
  list.append(4)
  list.insert_at(5, 2)
  list.remove_at(1)
  
  puts list.to_s  # ( 3 ) -> ( 5 ) -> ( 4 ) -> nil
  puts list.size  # 3
  puts list.head.value  # 3
  puts list.tail.value  # 4
  puts list.at(2).value  # 4
  puts list.pop.value  # 4
  puts list.contains?(4)  # true
  puts list.find(3)  # 0
  