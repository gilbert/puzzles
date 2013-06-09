# #
# Edit Distance
#
# This is a very inefficient solution to the edit distance string function.
# It traverses through every possible combination, probably multiple times.
# There are many things that could be done to speed this up, including
# something called "dynamic programming", but I just wanted to come up with
# a solution without first researching the problem.
#
# Estimated Time Spent:
# 3 hours
#
#
# Overall Strategy
# If you start doing hand-written examples of strings and their edit distances,
# patterns will start to emerge. One of these patterns is that if strings A and B
# are of the same length, their edit distance is a simple count of how many
# differences there are in each character index.
#
# If they're not the same, however, you'll need to either add or subtract
# characters from the source string. If chosen carefully, you can avoid trying
# unnecessary operations. For example:
#     edit_distance("axxc", "abc")
# Here you need to subtract a character from "axxc". Clearly subtracting 'a' or
# 'c' would be counterproductive, so you would choose an 'x' instead.
#
# You can easily choose which characters to add or subtract by taking the set
# difference of each string. In the above example, since you're subtracting, you
# would take the difference of Set('axc') minus Set('abc'), which gives you Set('x').
#
# Doing this all recursively takes the least amount of effort code-wise, and only
# requires keeping track of the number of operations done at each call.
#
#
require 'set'

def edit_distance(source, target)
  helper(source, target, 0)
end

def helper(source, target, current_distance)
  return current_distance if source == target

  if source.length == target.length
    # Simply count how many chars need to change
    n = (0..source.length-1).map {|i| source[i] == target[i] ? 0 : 1 }.reduce(:+)
    return current_distance + n
  else
    # Need to add or subtract, as well as keep track of the lowest distance.
    # Preset lowest to be max possible operations
    lowest_distance = [source.length, target.length].max + current_distance

    # Get a set of characters to play with
    if source.length > target.length
      mod_chars = set_difference(source, target)
    else
      mod_chars = set_difference(target, source)
    end

    # Try using each character from our set
    mod_chars.each {|current_char|

      if source.length > target.length
        # Source is longer; we need to make it shorter to match target's length.
        # Try subtracting current_char from each occurence in the source string
        distance = char_indicies(source, current_char).map {|char_index|
          # Create a new source with a character removed at char_index
          new_source = source.dup
          new_source.slice!(char_index)

          # Recursive call to travel down the tree of possible combinations
          helper(new_source, target, current_distance + 1)
        }.min

        lowest_distance = distance if distance < lowest_distance
      else
        # Try adding current_char in each slot in the source string
        distance = (0..source.length).map {|i|
          # Create a new source with a character inserted at i
          new_source = source.dup.insert(i,current_char)

          # Recursive call to travel down the tree of possible combinations
          helper(new_source, target, current_distance + 1)
        }.min

        lowest_distance = distance if distance < lowest_distance
      end
    }

    return lowest_distance
  end
end

def set_difference(one, two)
  one.chars.to_set - two.chars.to_set
end

def char_indicies(str, char)
  str.chars.each_with_index.map {|c,i| (c == char) ? i : -1}.reject {|x| x == -1}
end
