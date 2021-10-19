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
      next_node = if node.right.nil? == false && node.left.nil?
                    node.right
                  elsif node.left.nil? == false && node.right.nil?
                    node.left
                  elsif node.right.data > value
                    node.left
                  else
                    node.right
                  end
      insert(value, next_node)
    end
  end

  def delete(value, node = @root)
    if node.right.nil? == false && node.right.data == value || node.left.nil? == false && node.left.data == value
      if node.right.nil? == false && node.right.data == value
        if node.right.right.nil? && node.right.left.nil?
          node.right = nil
        elsif node.right.right.nil? == false && node.right.left.nil?
          node.right = node.right.right
        elsif node.right.right.nil? && node.right.left.nil? == false
          node.right = node.right.left
        elsif node.right.right.nil? == false && node.right.left.nil? == false
          successor = inorder_successor(node.right.right)
          delete(successor.data)
          temp_right_node = node.right.right
          temp_left_node = node.right.left
          node.right = Node.new(successor.data, temp_left_node, temp_right_node)
        end
      elsif node.left.nil? == false && node.left.data == value
        if node.left.right.nil? && node.left.left.nil?
          node.left = nil
        elsif node.left.right.nil? == false && node.left.left.nil?
          node.left = node.left.right
        elsif node.left.right.nil? && node.left.left.nil? == false
          node.left = node.left.left
        elsif node.left.right.nil? == false && node.left.left.nil? == false
          successor = inorder_successor(node.left.right)
          delete(successor.data)
          temp_right_node = node.left.right
          temp_left_node = node.left.left
          node.left = Node.new(successor.data, temp_left_node, temp_right_node)
        end
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

  def inorder_successor(next_node)
    if next_node.right.nil? && next_node.left.nil?
      next_node
    elsif next_node.right.nil? == false && next_node.left.nil?
      next_node
    else
      inorder_successor(next_node.left)
    end
  end

  def find(value, node = @root)
    if node.left.nil? == false && node.left.data == value
      node.left
    elsif node.right.nil? == false && node.right.data == value
      node.right
    else
      next_node = if node.data > value
                    node.left
                  else
                    node.right
                  end
      find(value, next_node)
    end
  end

  def level_order(node = @root)
    result_array = []
    if node.right.nil? && node.left.nil?
      node.data
    else
      temp_result_right = level_order(node.right) if node.right.nil? == false
      temp_result_left = level_order(node.left) if node.left.nil? == false
      if temp_result_right.nil? == false
        result_array << temp_result_right
      end
      if temp_result_left.nil? == false
        result_array << temp_result_left
      end
      result_array.unshift node.data
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
i = 0
array = [9, 5, 12, 15, 20, 49, 23, 52, 50]
tree = Tree.new(array)
binding.pry
test = 'test'
tree.delete(49)
bin = 'bin'
