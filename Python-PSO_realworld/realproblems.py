#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 20 15:36:52 2019

@author: waveluozu
benchmark function:
real world problems
problem 1: design of a gear train
problem 2: parameter estimation for frequencymodulated (FM) sound waves
"""
import numpy as np

def real(x,switch):
    X = np.array(x)
    dim = np.size(X)
    if switch == 0:
        Mat = np.zeros(dim)
        Mat = X
        Taget = 1/6.931
        objval = np.square(Taget - (Mat[0]*Mat[1])/(Mat[2]*Mat[3]))
        return objval
    if switch == 1:
        t = np.arange(0,2*3.1415, 2*3.1415/100)
        a1 = np.ones(np.size(t))*X[0]
        w1 = np.ones(np.size(t))*X[1]
        a2 = np.ones(np.size(t))*X[2]
        w2 = np.ones(np.size(t))*X[3]
        a3 = np.ones(np.size(t))*X[4]
        w3 = np.ones(np.size(t))*X[5]
        
        y = a1*np.sin(w1*t + a2*np.sin(w2*t + a3*np.sin(w3*t)))
        yo = np.sin(5*t - 1.5*np.sin(4.8*t+2*np.sin(4.9*t)))
        
        objval = np.sum(np.square(y-yo))
        
        return objval