puts "List of jobs please. Put each job on a new line and write 'END' after your last job."

$/ = 'END'

jobs = STDIN.gets.chomp('END')

puts "Jobs:"
puts jobs