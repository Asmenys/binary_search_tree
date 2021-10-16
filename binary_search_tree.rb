# frozen_string_literal: true

require 'pry-byebug'

class Node
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  attr_reader :root

  def initialize(initial_array)
    initial_array = initial_array.sort.uniq
    @root = build_tree(initial_array)
  end

  def build_tree(array)
    if array.empty?
      return nil
    else
      mid_element = array.delete_at((array.length - 1) / 2)
      left_sub_array = array[0...array.length / 2].to_a
      right_sub_array = array[array.length / 2...array.length].to_a
      node = Node.new(mid_element, build_tree(left_sub_array),
                      build_tree(right_sub_array))
    end

    node
  end

  def insert(value, node = @root)
    if node.right.nil? && node.left.nil?
      if node.data > value
        node.left = Node.new(value)
      else
        node.right = Node.new(value)
      end
    else
      next_node = if node.data > value
                    node.left
                  else
                    node.right
                  end
      insert(value, next_node)
    end
  end

  def delete(value, node = @root)
    if node.right.data == value
      node.right = nil if node.right.right.nil? && node.right.left.nil?
    elsif node.left.data == value
      if node.left.right.nil? && node.left.left.nil?
        node.left = nil
      end
    else
      next_node = if node.data > value
                    node.left
                  else
                    node.right
                  end
      delete(value, next_node)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
i = 0
array = Array.new(9) { i += 1 }
tree = Tree.new(array)
binding.pry
bin = 'bin'
