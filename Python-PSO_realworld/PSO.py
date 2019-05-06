#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar 19 16:21:25 2019

@author: waveluozu
oringal PSO algorithm
"""
#test
import numpy as np 
import realproblems as real
def PSO(Max_iter, Max_FES, N, dim, lb, ub, func_num):
    #initialize 
    cc = np.array([2,2])# acceleration constants
    w = np.zeros(Max_iter, dtype = float)
    w = 0.9 - np.arange(1, Max_iter+1, 1)*(0.5/Max_iter)
    
#    if np.size(lb, 1) == 1:
#        LB = np.tile(lb, (N, dim))
#        UB = np.tile(ub, (N, dim))
    
    LB = np.tile(lb, (N, 1))
    UB = np.tile(ub, (N, 1))
    
    X = LB + (UB - LB) * np.random.rand(N, dim)

    Vmin = -0.5*(UB - LB)
    Vmax = -Vmin
    vel = Vmin + 2*Vmax*np.random.rand(N, dim) # initialize velocity
    # fitness
    e = np.zeros(N, dtype = float)
    for i in range(0, N):
        e[i] = real.real(X[i, :], func_num)
    # initilize pbest and gbest
    pbest = X
    pbestval = e
    gbestval = np.min(e)
    gbest = X[np.where(e == gbestval)]
    
    gbestrep = np.tile(gbest[0], (N, 1))
    
    t = 0
    allgbestval = np.empty(Max_iter, dtype = float)
    allgbestval[t] = gbestval
    
    for t in range(1, Max_iter):
        aa = cc[0]*np.random.rand(N, dim) * (pbest - X) + cc[1]*np.random.rand(N, dim)*(gbestrep - X)
        vel = w[t]*vel + aa
        # check vel
        vel = (vel > Vmax)*Vmax + (vel <= Vmax)*vel
        vel = (vel < Vmin)*Vmin + (vel >= Vmin)*vel
        # update X position
        X = X + vel
        # check X
        X = ((X >= LB)&(X <= UB))*X + ((X < LB)*(LB + 0.25*(UB-LB)*np.random.rand(N, dim)))+((X > UB)*(UB - 0.25*(UB-LB)*np.random.rand(N, dim)))
        # evluate X 
        for i in range(0, N): # python 左闭右开 0 -（N-1）
            e[i] = real.real(X[i, :], func_num)
        
        tmp = (pbestval < e)
        temp = np.tile(tmp, (dim, 1))
        temp = temp.T
        # update pbest
        pbest = temp*pbest + (1-temp)*X
        pbestval = tmp*pbestval + (1-tmp)*e
        # update gbest
        gbestval = np.min(pbestval)
        gbest = pbest[np.where(pbestval==gbestval)]
        gbestrep = np.tile(gbest[0], (N, 1))
        
        allgbestval[t] = gbestval
        
    return gbestval, allgbestval, gbest
        
        
        
    
    
    
    
    
        
    
            
            
      
