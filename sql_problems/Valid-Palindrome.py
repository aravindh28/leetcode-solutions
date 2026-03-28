1class Solution:
2    def isPalindrome(self, s: str) -> bool:
3        left, right = 0, len(s) - 1
4        while left < right:
5            while not s[left].isalnum() and left!= len(s)-1:
6                left+=1
7            while not s[right].isalnum() and right != 0:
8                right-=1
9
10            if s[left].lower() == s[right].lower():
11                left+=1
12                right-=1
13            else:
14                if left > right:
15                    return True
16                return False
17        
18        return True
19            
20            
21                
22
23        