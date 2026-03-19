1class Solution:
2    def isValid(self, s: str) -> bool:
3        stack = []
4        valid_pairs = {'(':')', '{': '}', '[':']'}
5        for char in s:
6            if char in valid_pairs.keys():
7                stack.append(char)
8            else:
9                if not stack:
10                    return False
11            
12                elif valid_pairs.get(stack.pop())==char:
13                    pass
14
15                else:
16                    return False
17            
18        return len(stack)==0
19
20
21
22        