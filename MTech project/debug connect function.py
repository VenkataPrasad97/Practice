import random
import numpy as np
import copy

betta = 0.5

def replace_random_indices(x1, x2, num_indices, min_val, max_val):
    n = len(x1)
    if num_indices > n:
        raise ValueError("Number of indices to replace should be less than or equal to length of array.")
    indices = set(random.sample(range(n), num_indices))
    new_arr = copy.deepcopy(x1)
    while True:
        for i in indices:
            a = random.random()
            b = np.sin(betta) * a
            c = round(x1[i] * ((1 - b) + ((x1[i] + x2[i]) / 2) * b))
            z = max(c, min_val)
            z = min(z, max_val)
            new_arr[i] = z
        if sum(new_arr) == sum(x1):
            if new_arr != x1 and new_arr != x2:
                return new_arr
        else:
            new_arr = copy.deepcopy(x1)

x1 = [10, 20, 25, 15, 25]
x2 = [11, 21, 24, 14, 25]
new_x1 = replace_random_indices(x1, x2, 2, 10, 30)

print("Old x1:", x1)
print("New x1:", new_x1)
print("Old sum:", sum(x1))
print("New sum:", sum(new_x1))
