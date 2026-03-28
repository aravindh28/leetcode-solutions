1class Solution:
2    def twoSum(self, numbers: List[int], target: int) -> List[int]:
3        left, right = 0, len(numbers) - 1
4        while left < right:
5            if numbers[left] + numbers[right] > target:
6                right-=1
7            if numbers[left] + numbers[right] < target:
8                left+=1
9            if numbers[left] + numbers[right] == target:
10                return [left+1,right+1]