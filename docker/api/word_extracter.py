import numpy as np
import MeCab

def extract_only_nouns(text):
    tagger = MeCab.Tagger()
    words = []
    for c in tagger.parse(text).splitlines()[:-1]:
        word, feature = c.split('\t')
        word_class = feature.split(',')[0]
        if (word_class == '名詞'):
            words.append(word)
    return words

def extract_important_words(documents, number_of_extract):
    words_list = sum(([extract_only_nouns(text) for text in documents]), [])
    _, word_index = np.unique(words_list, return_inverse=True)
    word_dictionary = dict(zip(word_index, words_list))

    number_of_words = len(word_index)
    if number_of_words <= 3:
        return word_list

    link_list = [word_index[i:i+2] for i in range(number_of_words-1)]

    matrix = np.zeros((number_of_words, number_of_words))
    for link in link_list:
        matrix[link[0]][link[1]] += 1
        matrix[link[1]][link[0]] += 1

    rank = np.array([[m] for m in np.zeros(number_of_words)])
    rank[0] = 1
    for n in range(100):
        rank = np.dot(matrix, rank)
        rank = rank/rank.max()

    rank = rank.flatten()
    important_words = [word_dictionary[np.where(rank==np.sort(rank)[-(val+1)])[0][0]] for val in range(number_of_extract)]

    return important_words