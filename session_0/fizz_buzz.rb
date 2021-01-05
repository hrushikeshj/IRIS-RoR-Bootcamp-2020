# Fizz Buzz
# fizz_buzz(n: 6, x: 2, y: 3)
# ["1", "Fizz", "Buzz", "Fizz", "5", "FizzBuzz"]

def fizz_buzz(n:, x: 3, y: 5)
  if(n<0 || x<=0 || y<=0)
    raise ArgumentError
  end
  a=(1..n).to_a
  a.map! do |i|
    if (i % x == 0) && (i % y == 0)
      i="FizzBuzz"
    elsif(i % x == 0)
      i="Fizz"
    elsif(i % y == 0)
      i="Buzz"
    else
     i=i.to_s
    end
  end
  return a
end
