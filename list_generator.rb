RUNES = (%w(a b c d e f) + [2,3,4,5,6,7,8,9]).shuffle
FILE_NAME = ARGV[0]

guess = RUNES[0..9]

def generator(cur_state, index)
  RUNES.each do |r|
    cur_state[index] = r
    # Chances are that we will never get more than 2 of the same letter in a row
    if cur_state[index] == cur_state[index -1 ] &&
       cur_state[index] == cur_state[index -2 ]
       next
    end if index > 1
    generator(cur_state, index + 1) if index < 9
    open(FILE_NAME, 'a') do |file|
        cur_state[index] = r
        file.puts cur_state.join("")
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
