1class Solution:
2    def containsDuplicate(self, nums: List[int]) -> bool:
3        return len(set(nums)) != len(nums)
4 
5
6        