#!/usr/bin/env ruby

require_relative 'print_ascii'
require_relative 'board'

board = Board.new(3)

print_header
board.print_grid
