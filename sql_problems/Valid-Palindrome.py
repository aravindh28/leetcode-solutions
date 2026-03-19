1class Solution:
2    def isPalindrome(self, s: str) -> bool:
3        left, right = 0, len(s) - 1
4
5        print(left, right)
6
7        while (left< right):
8            while left < right and not s[left].isalnum():
9                left+=1 
10            while left < right and not s[right].isalnum():
11                right-=1
12
13            if s[left].lower() != s[right].lower():
14                print(s[left])
15                print(s[right])
16                print(left)
17                print(right)
18
19                return False
20            else:
21                left+=1
22                right-=1
23        
24        return True
25
26
27        