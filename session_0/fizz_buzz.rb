# Fizz Buzz
# fizz_buzz(n: 6, x: 2, y: 3)
# ["1", "Fizz", "Buzz", "Fizz", "5", "FizzBuzz"]

def fizz_buzz(n:, x: 3, y: 5)
  a=[]
  if(n<0 || x<=0 || y<=0)
    raise ArgumentError
  end
  for i in 1..n
    if((i % x==0) && (i % y==0))
      a.append("FizzBuzz")
    elsif(i % x==0)
      a.append("Fizz")
    elsif(i % y==0)
      a.append("Buzz")
    else
      a.append(i.to_s)
    end
  end
  return a
  #raise NotImplementedError # TODO
end
