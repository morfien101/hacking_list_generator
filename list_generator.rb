#!/bin/env ruby
# This script was to be used to create a list of passwords for
# a BT Homehub5 which is then passed onto something like airocrack.
# This script is for learning purposed only.
# Use at your own risk.
# Licence: Apache 2.0

# READ THIS HELP SECTION FOR HOW TO USE THIS SCRIPT.
# Very simple help menu
if ARGV[0] =~ /-h|--help/
  puts 'You can to pass in a file to hold the keys as arugment 1 or you will get a'
  puts 'keys.txt file in the root of the directory you are running this script from.'
  puts 'you can also pass in a ruleset for the list as arguments 2 and 3 for'
  puts 'charactor array and password length.'
  puts 'Example:'
  puts ' ruby list_generator.rb /tmp/keys.txt "%w(a b c d e f) + [2,3,4,5,6,7,8,9]" 10'
  exit 0
end

FILE_NAME = ARGV[0].nil? ? 'keys.txt' : ARGV[0]
RUNES = ARGV[1].nil? ? (%w(a b c d e f) + [2,3,4,5,6,7,8,9]).shuffle : eval(ARGV[1].shuffle)
LENGTH = ARGV[2].nil? ? 10 : ARGV[2].to_i - 1

guess = RUNES[0..LENGTH]

def generator(cur_state, index)
  RUNES.each do |r|
    cur_state[index] = r
    # Chances are that we will never get more than 2 of the same letter in a row
    if cur_state[index] == cur_state[index -1 ] &&
       cur_state[index] == cur_state[index -2 ]
       next
    end if index > 1
    generator(cur_state, index + 1) if index < LENGTH - 1
    open(FILE_NAME, 'a') do |file|
        cur_state[index] = r
        file.puts cur_state.join
    end
  end
end

def create_file(guess)
  File.new(FILE_NAME,'w').close
  open(FILE_NAME, 'a') do |file|
      file.puts guess.join()
  end
end

puts "Starting at #{RUNES.to_s}"
create_file(guess)
generator(guess, 0)
