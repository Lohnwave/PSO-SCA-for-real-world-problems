#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar 19 16:23:20 2019

@author: waveluozu
algorithm: PSO
handle problems: realproblems
"""

import PSO
# import realproblems as real
import numpy as np


# z = real.real(np.array([1,3,4,5,4,6]),2)
# print(z)

D = np.array([4,6])
Xmin = np.array([12, -6.4])
Xmax = np.array([60, 6.35])

pop_size = 10
Max_iter = np.array([2000, 3000])
Max_FES = np.array([20000, 30000])
runs = 2
func_number = 2

Data1 = np.zeros((func_number, runs), dtype = float)
Data2 = np.zeros((func_number, runs), dtype = float)
f_mean = np.zeros((func_number,), dtype = float)
def main():
    for i in range(0, func_number):
        print('problem: ', i)
        for j in range(0, runs):
            print('run = ', j)
            [gbestval, allgbestval, gbest] = PSO.PSO(Max_iter[i], Max_FES[i], pop_size, D[i], Xmin[i], Xmax[i], i)
            Data1[i, j] = gbestval
        f_mean[i] = np.mean(Data1[i, :])
        print('Mean: %f\n' % f_mean[i])

if __name__ == '__main__':
    main()
