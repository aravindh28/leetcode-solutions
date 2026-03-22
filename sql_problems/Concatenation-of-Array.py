1class Solution:
2    def getConcatenation(self, nums: List[int]) -> List[int]:
3        nums.extend(nums)
4        return nums
5        