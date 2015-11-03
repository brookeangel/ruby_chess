def square_root(n)
  if n < 0
    raise ArgumentError.new "Cannot take square root of negative number."
  end

  Math.sqrt(n)
end

def square_root_with_rescue
  begin
    puts "Enter a number:"
    print ">"
    n = gets.chomp.to_i
    square_root(n)
  rescue ArgumentError => e
    puts "Could not take square root of #{n}."
    puts "Error was: #{e.message}"
    retry
  end
end
