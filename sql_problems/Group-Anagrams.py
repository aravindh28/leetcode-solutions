1from collections import defaultdict, Counter
2class Solution:
3    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
4        count_dict = defaultdict(list)
5        for s in strs:
6            cnt = Counter(s)
7            hash_key = frozenset(cnt.items())
8            count_dict[hash_key].append(s)
9
10        
11        return list(count_dict.values())
12
13
14        
15        