""" Typing Test implementation """

from utils import *
from ucb import main

# BEGIN Q1-5
def lines_from_file(path):
    file = open(path, mode='r')
    stripped = []
    for line in readlines(file):
        stripped.append(line.strip())
    return stripped

def new_sample(path, i):
        return lines_from_file(path)[i]
 
def analyze(sample_paragraph, typed_string, start_time, end_time):
    wpm = (len(typed_string)/5)/((end_time-start_time)/60)

    sample_list = split(sample_paragraph)
    typed_list = split(typed_string)
    min_length = min(len(sample_list), len(typed_list))
    correct_words = 0

    if len(typed_list) == 0:
        return [wpm, 0.0]
    else:
        for i in range(min_length):
            if sample_list[i] == typed_list[i]:
                correct_words += 1
        accuracy = (correct_words/min_length)*100

    return [wpm, accuracy]

    """def wpm(typed_string, start_time, end_time):
        characters = []
        while start_time != end_time:
            for line in typed_string:
                for c in line:
                    characters.append(c)
            return characters/5"""

    """def accuracy(sample_paragraph, typed_string):
        sample_words = []
        typed_words = []
        for line in sample_paragraph:
            sample_words = sample_words.append(line.split())
        print(sample_words)

        for line in typed_string:
            typed_words = typed_words.append(line.split())
        print(typed_words)
#len or range?
        if sample_words == typed_words:
            return float(100)
        else:
            return typed_words/sample_words"""
def pig_latin(word):
    vowels = ['a', 'e', 'i', 'o', 'u']
    cluster = word[0]
    if cluster in vowels:
        return word + 'way'
    else:
        for i in range(1, len(word)):
            if word[i] in vowels:
                return word[i:] + cluster + 'ay'
            cluster += word[i]
        return cluster + 'ay'

def key_of_min_value(d):
    return min(d, key = lambda x: d[x])

def autocorrect(user_input, words_list, score_function):
    if user_input in words_list:
        return user_input
    for word in words_list:
        smallest_difference = {word : score_function(user_input,word) for word in words_list}
        return key_of_min_value(smallest_difference)
        
def swap_score(word1, word2):
    if word1 == '' or word2 == '':
        return 0
    elif word1[0] == word2[0]:
        return swap_score(word1[1:], word2[1:])
    else:
        return 1 + swap_score(word1[1:], word2[1:])

# END Q1-5

# Question 6

def score_function(word1, word2):
    """A score_function that computes the edit distance between word1 and word2."""

    if word1 == '': #if word1 is shorter than word 2
        return len(word2)
    elif word2 == '': #if word1 is longer than word 2
        return len(word1)
    elif word1[0] == word2[0]: #if word1 and word2 are the same length
        return score_function(word1[1:], word2[1:])
    else:
        add_char = score_function(word1, word2[1:])  # Fill in these lines
        remove_char = score_function(word1[1:], word2) 
        substitute_char = score_function(word1[1:], word2[1:])
        operations = (add_char, remove_char, substitute_char)
        return 1 + min(operations)
        # END Q6

KEY_DISTANCES = get_key_distances()

# BEGIN Q7-8
def score_function_accurate(word1, word2): #similar to score_function until substitute_char with key_distances etc.
    if word1 == '':
        return len(word2)
    elif word2 == '':
        return len(word1)
    elif word1[0] == word2[0]:
        return score_function_accurate(word1[1:], word2[1:])
    else:
        add_char = score_function_accurate(word1, word2[1:])
        remove_char =score_function_accurate(word1[1:], word2)
        substitute_char = KEY_DISTANCES[word1[0], word2[0]] + score_function_accurate(word1[1:], word2[1:])
        comparison = min(add_char, remove_char)
        if comparison < substitute_char:
            return 1 + comparison
        return substitute_char

memoization = {} #memoize each and every recursive call
def score_function_final(word1, word2):
    pair1 = (word1, word2)
    pair2 = (word2, word1) #if its in dictionary return dictionary with index
    if pair1 in memoization:
        return memoization[pair1]
    if pair2 in memoization:
        return memoization[pair2]
    if word1 == '':
        memoization[pair1] = len(word2)
        return len(word2)
    elif word2 == '':
        memoization[pair2] = len(word1)
        return len(word1)
    elif word1[0] == word2[0]:
        return score_function_final(word1[1:], word2[1:])
    elif word1[0] == word2[0]:
        return score_function_final(word1[1:], word2[1:])
    else:
        add_char = score_function_final(word1, word2[1:])
        remove_char =score_function_final(word1[1:], word2)
        substitute_char = KEY_DISTANCES[word1[0], word2[0]] + score_function_final(word1[1:], word2[1:])
        comparison = min(add_char, remove_char)
        if comparison < substitute_char:
            memoization[pair1] = 1 + comparison
            memoization[pair2] = 1 + comparison
        else:
            memoization[pair1] = substitute_char
            memoization[pair2] = substitute_char
        return memoization[pair1]

    #if its not in dictionary, add it to dictionary return minimum of add/remove/substitute
    
# END Q7-8
