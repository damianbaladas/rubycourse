class Node
    include Comparable
  
    attr_accessor :data, :left, :right
  
    def initialize(data)
      @data = data
      @left = nil
      @right = nil
    end
  
    def <=>(other)
      data <=> other.data
    end
  end
  
  class Tree
    attr_reader :root
  
    def initialize(array)
      @root = build_tree(array.uniq.sort)
    end
  
    def build_tree(array)
      return if array.empty?
  
      mid = array.length / 2
      root = Node.new(array[mid])
      root.left = build_tree(array[0...mid])
      root.right = build_tree(array[mid + 1..-1])
      root
    end
  
    def insert(value, node = @root)
      return Node.new(value) if node.nil?
  
      if value < node.data
        node.left = insert(value, node.left)
      elsif value > node.data
        node.right = insert(value, node.right)
      end
  
      node
    end
  
    def delete(value, node = @root)
      return node if node.nil?
  
      if value < node.data
        node.left = delete(value, node.left)
      elsif value > node.data
        node.right = delete(value, node.right)
      else
        return node.right if node.left.nil?
        return node.left if node.right.nil?
  
        temp = find_min(node.right)
        node.data = temp.data
        node.right = delete(temp.data, node.right)
      end
  
      node
    end
  
    def find(value, node = @root)
      return nil if node.nil?
  
      return node if node.data == value
  
      if value < node.data
        find(value, node.left)
      else
        find(value, node.right)
      end
    end
  
    def level_order(node = @root, &block)
      return [] if node.nil?
  
      queue = [node]
      result = []
  
      while !queue.empty?
        current = queue.shift
        block_given? ? yield(current) : result << current.data
  
        queue << current.left unless current.left.nil?
        queue << current.right unless current.right.nil?
      end
  
      result unless block_given?
    end
  
    def inorder(node = @root, &block)
      return if node.nil?
  
      inorder(node.left, &block)
      block_given? ? yield(node) : (print "#{node.data} ")
      inorder(node.right, &block)
    end
  
    def preorder(node = @root, &block)
      return if node.nil?
  
      block_given? ? yield(node) : (print "#{node.data} ")
      preorder(node.left, &block)
      preorder(node.right, &block)
    end
  
    def postorder(node = @root, &block)
      return if node.nil?
  
      postorder(node.left, &block)
      postorder(node.right, &block)
      block_given? ? yield(node) : (print "#{node.data} ")
    end
  
    def height(node = @root)
      return -1 if node.nil?
  
      left_height = height(node.left)
      right_height = height(node.right)
  
      [left_height, right_height].max + 1
    end
  
    def depth(node)
      return -1 if node.nil?
  
      parent = find_parent(node)
  
      return 0 if parent.nil?
  
      depth(parent) + 1
    end
  
    def balanced?(node = @root)
      return true if node.nil?
  
      left_height = height(node.left)
      right_height = height(node.right)
  
      (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
    end
  
    def rebalance
      array = []
      inorder { |node| array << node.data }
      @root = build_tree(array)
    end
  
    private
  
    def find_min(node)
      current = node
  
      while !current.left.nil?
        current = current.left
      end
  
      current
    end
  
    def find_parent(node, root = @root, parent = nil)
      return parent if root.nil?
  
      return root if root.left == node || root.right == node
  
      if node < root.data
        find_parent(node, root.left, root)
      else
        find_parent(node, root.right, root)
      end
    end
  end
  
  # Driver script
  array = Array.new(15) { rand(1..100) }
  tree = Tree.new(array)
  
  puts "Initial Tree:"
  puts "Level order: #{tree.level_order.join(' ')}"
  puts "Preorder: #{tree.preorder.join(' ')}"
  puts "Inorder: #{tree.inorder.join(' ')}"
  puts "Postorder: #{tree.postorder.join(' ')}"
  puts "Is the tree balanced? #{tree.balanced?}"
  puts
  
  puts "Adding numbers > 100 to unbalance the tree..."
  array = Array.new(5) { rand(101..200) }
  array.each { |num| tree.insert(num) }
  
  puts "Updated Tree:"
  puts "Level order: #{tree.level_order.join(' ')}"
  puts "Preorder: #{tree.preorder.join(' ')}"
  puts "Inorder: #{tree.inorder.join(' ')}"
  puts "Postorder: #{tree.postorder.join(' ')}"
  puts "Is the tree balanced? #{tree.balanced?}"
  puts
  
  puts "Rebalancing the tree..."
  tree.rebalance
  
  puts "Rebalanced Tree:"
  puts "Level order: #{tree.level_order.join(' ')}"
  puts "Preorder: #{tree.preorder.join(' ')}"
  puts "Inorder: #{tree.inorder.join(' ')}"
  puts "Postorder: #{tree.postorder.join(' ')}"
  puts "Is the tree balanced? #{tree.balanced?}"
  
  