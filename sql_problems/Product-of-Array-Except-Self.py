1from functools import reduce
2class Solution:
3    def productExceptSelf(self, nums: List[int]) -> List[int]:
4        op=[]
5        prev_res = 1
6        prev= 1
7        zero_flag = 0
8        num_length = len(nums)
9        for i,num in enumerate(nums):
10            if i == 0:
11                prev_res = reduce(lambda x, y: x * y, nums[1:])
12                if prev_res == 0:
13                    #print("flag set")
14                    zero_flag = 1
15
16                prev = num
17                op.append(prev_res)
18            else:
19                print(i)
20                if zero_flag == 1:
21                    if num == 0:
22                        #print("inside", i)
23                        try:
24                            if i == num_length -1:
25                                res = reduce(lambda x, y: x * y, nums[:i])
26                            else:
27                                res = reduce(lambda x, y: x * y, nums[:i]) * reduce(lambda x, y: x*y, nums[i+1:])
28                            op.append(res)
29                        except:
30                            #print("except")
31                            op.append(nums[0])
32                    else:
33                        op.append(0)
34                else:
35                    op.append(int(op[i-1]* nums[i-1] / nums[i]))
36        #print(op)
37        return op
38
39
40
41        