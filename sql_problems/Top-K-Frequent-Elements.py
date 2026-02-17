1from collections import Counter
2class Solution:
3    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
4        counter = Counter(nums)
5        ordered_list = sorted(list(counter.items()), reverse = True, key = lambda x: x[1])
6        op=[]
7        for i in range(0,k):
8            op.append(ordered_list[i][0])
9        return op
10
11
12        