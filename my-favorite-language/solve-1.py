#!/usr/bin/env python3
import math
import subprocess

def count_beta_reduction(s):
    proc = subprocess.Popen([ './a.out', 'problem.lazy' ], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = proc.communicate(s.encode(), timeout=3)
    if b'correct flag' in stdout:
        return math.inf
    else:
        return int(stderr[len('beta reduction: ') :])

flag = 'HarekazeCTF{'
while True:
    letter = None
    count = -1
    for c in '0123456789ABCDEF':
        k = count_beta_reduction(flag + c + '}')
        print('[*]', flag + c + '}', k)
        if count < k:
            letter = c
            count = k
    flag += letter
    print('[+]', flag + '}')
    if math.isinf(count):
        break
