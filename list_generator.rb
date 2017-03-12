RUNES = (%w(a b c d e f) + [2,3,4,5,6,7,8,9]).shuffle
FILE_NAME = ARGV[0]

guess = [""] * 10

def generator(cur_state, index)
  if index < 9
    RUNES.each do |r|
      cur_state[index] = r
      if cur_state[index] == cur_state[index -1 ] &&
         cur_state[index] == cur_state[index -2 ]
         next
      end if index >= 2
      generator(cur_state, index + 1)
    end
  else
    open(FILE_NAME, 'w') do |file|
      RUNES.each do |r|
        cur_state[index] = r
        file.puts cur_state.join("")
      end
    end
  end
end

File.new(FILE_NAME,'w').close

puts "Starting at #{RUNES.to_s}"
generator(guess, 0)
