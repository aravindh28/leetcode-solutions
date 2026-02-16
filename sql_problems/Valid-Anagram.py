1from collections import Counter
2class Solution:
3    def isAnagram(self, s: str, t: str) -> bool:
4        return Counter(s) == Counter(t)
5        