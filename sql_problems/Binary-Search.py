1class Solution:
2    def search(self, nums: List[int], target: int) -> int:
3        left, right = 0, len(nums) - 1
4
5        while (left <= right):
6            mid = (left + right) // 2
7            if target == nums[mid]:
8                return mid
9            if target < nums[mid]:
10                right = mid - 1
11            if target > nums[mid]:
12                left = mid + 1
13        
14        return -1
15        
16
17        