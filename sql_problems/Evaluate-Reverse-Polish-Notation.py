1from functools import reduce
2class Solution:
3    def evalRPN(self, tokens: List[str]) -> int:
4        stack = []
5        for token in tokens:
6            if token in ['+','-','*','/']:
7                op2 = stack.pop()
8                op1 = stack.pop()
9                if token == '+':
10                    stack.append(op1 + op2)
11                if token == '-':
12                    stack.append(op1 - op2)
13                if token == '*':
14                    stack.append(op1 * op2)
15                if token == '/':
16                    stack.append(int(op1/op2))
17            else:
18                stack.append(int(token))     
19        return stack[-1]
20
21
22        