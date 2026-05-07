1from itertools import zip_longest
2class Solution:
3    def mergeAlternately(self, word1: str, word2: str) -> str:
4        op=[]
5        for w1,w2 in zip_longest(word1,word2):
6            if w1 is not None:
7                op.append(w1)
8            if w2 is not None:
9                op.append(w2)
10        return "".join(op)
11
12        
13        