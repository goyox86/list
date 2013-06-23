#
# = list.rb
#
# Copyright (c) 2013 Jose Narvaez
#
# Written and maintained by Jose Narvaez <goyox86@gmail.com>.
#
# This program is free software. You can re-distribute and/or
# modify this program under the same terms of ruby itself ---
# Ruby Distribution License or GNU General Public License.
#

require_relative './node'

# == A single linked list implementation in Ruby.
#
#
# == Example
#
#   list = List.new
#   list.insert(1)
#   list.reverse!
#
class List
  attr_reader :head, :size
  include Enumerable

  #
  # Creates a new empty List object
  #
  def initialize
    @head = nil
    @size = 0
  end

  #
  # Deletes the node in +self+ containing the same value of +obj+
  # returning a reference to +obj+.
  #
  # See also List#delete_front
  # list = List.new
  # list.insert(1)
  # list.delete(1) #=> 1
  #
  def delete(obj)
    return nil if empty?

    if @head.obj == obj
      current_node = @head.obj
      @head = nil
      @size -= 1
      return current_node
    end

    current_node = @head
    until current_node.nil?
      next_node = current.next
      if next_node.obj == obj
        current_node.next = next_node.next
        @size -= 1
        return next_node
      end
      current_node = current_node.next
    end
  end

  #
  # Deletes the node in +self+ currently at the head
  # returning a reference to it.
  #
  # See also List#delete
  # list = List.new
  # list.insert(1)
  # list.delete_front #=> 1
  #
  def delete_front
    return nil if empty?

    front_node = @head  
    @head = front_node.next
    @size -= 1

    front_node.obj
  end

  #
  # Calls the given block once for each element in +self+,
  # passing that element as a parameter.
  #
  def each
    current = @head

    until current.nil?
      yield current
      current = current.next
    end
  end

  #
  # Returns +true+ if +self+ contains no elements.
  #
  # list = List.new
  # list.empty? #=> true
  #
  def empty?
    @head.nil?
  end

  alias_method :enumerable_find, :find
  #
  # Returns the first element on +self+ equal to +obj+. nil otherwise
  #
  # list = List.new
  # list.insert(1)
  # list.find(1) #=> 1
  #
  def find(obj)
    enumerable_find { |node| node.obj == obj }
  end

  # Inserts +obj+ in +self+ returning a reference to +self+.
  #
  # list = List.new
  # list.insert(1) #=> [1]
  # list.insert(2) #=> [2, 1]
  #
  def insert(obj)
    if @head.nil?
      @head = Node.new(nil, obj)
    else
      new_node = Node.new(@head, obj)
      @head = new_node
    end
    @size += 1

    self
  end

  # Reverses +self+ destructively (in-place) using iteration returning a
  # reference to +self+.
  #
  # See also List#recursive_reverse!
  #
  # list = List.new
  # list.insert(1)
  # list.insert(2)
  # list.reverse! #=> [1, 2]
  #
  def reverse!
    reversed_list = List.new

    current_node = @head
    while current_node
      reversed_list.insert(current_node.obj)
      current_node = current_node.next
    end

    @head = reversed_list.head

    self
  end

  # Reverses +self+ destructively (in-place) using recursion returning a
  # reference to +self+.
  #
  # See also List#reverse!
  #
  # list = List.new
  # list.insert(1)
  # list.insert(2)
  # list.recursive_reverse! #=> [1, 2]
  #
  def recursive_reverse!
    _recursive_reverse(@head)

    self
  end

  alias_method :inspect, :to_s

  def to_s
    map { |node| node.obj }
  end

  private

  def _recursive_reverse(node) #:nodoc:
    if node && node.next
      _recursive_reverse(node.next)
      node.next.next = node
      node.next = nil
    else
      @head = node
      return
    end
  end
end

