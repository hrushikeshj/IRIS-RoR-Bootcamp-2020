# The function `lower_case` takes an array of strings and converts
# any non-lower case alphabet (A..Z) to corresponding lower case
# alphabet
def lower_case(words)
	return words.map { |w| w.downcase }
end
#print lower_case(['', 'HELLO', 'WoRlD', 'nice'])
# Similar to `lower_case`, this function modifies the array in-place
# and does not return any value.
def lower_case!(words)
  words.map do |w|
    w.downcase!
   end
  return words
end

# Given a prefix and an array of words, return an array containing
# words that have same prefix.
#
# For example:
# words_with_prefix('apple', ['apple', 'ball', 'applesauce']) would
# return the words 'apple' and 'applesauce'.
def words_with_prefix(prefix, words)
	return words.select { |w| w.start_with?(prefix)}
end
#print words_with_prefix('apple', ['apple', 'ball', 'applesauce'])
# The similarity score between two words is defined as the length of
# largest common prefix between the words.
#
# For example:
# - Similarity of (bike, bite) is 2 as 'bi' is the largest common prefix.
# - Similarity of (apple, bite) is 0 as there are no common letters in
#   the prefix
# - similarity of (applesauce, apple) is 5 as 'apple' is the largest
#   common prefix.
# 
# The function `similarity_score` takes two words and returns the
# similarity score (an integer).
def similarity_score(word_1, word_2)
	l=word_1.size > word_2.size ? word_2.size : word_1.size
	max=0
	for i in 1..l
		if word_1[0,i].downcase == word_2[0,i].downcase
			max=i
		else
			break
		end
	end
	return max
end
#print similarity_score('applepie', 'apple')
# Given a chosen word and an array of words, return an array of word(s)
# with the maximum similarity score in the order they appear.
def most_similar_words(chosen_word, words)
	max=0
	arr=[]
	words.each do |w|
		score=similarity_score(w,chosen_word)
		if score > max
			max=score
			arr=[w]
		elsif score == max
			arr.push(w)
		end
	end
	return arr
end
#print most_similar_words('apple', ['ball', 'applesauce', 'bike', 'apple']) 