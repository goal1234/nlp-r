# -*- coding: utf-8 -*-
"""
Created on Thu Mar 29 14:10:02 2018

@author: gogoing

@ 功能: 模型好坏的评价指标， 返回一个pd.DataFrame对象
        模型写出
"""
from sklearn import metrics    
import pandas as pd
import numpy as np
import os

def evalute(real_data, predict_data, kind = 'default'):

    real_data = np.array(real_data)
    if len(set(real_data)) == 2:
        acc = metrics.accuracy_score(real_data, predict_data)
        recall = metrics.recall_score(real_data, predict_data,average='macro')
        precision = metrics.precision_score(real_data, predict_data,average='macro')
        f1 = metrics.f1_score(real_data, predict_data, average='macro')
        #roc = metrics.roc_auc_score(real_data, predict_data, average='micro')
        
        result = pd.DataFrame({"准确度":acc,
                               "召回率":recall,
                               "精准性":precision,
                               "f1":f1}, index = [kind])
    
        return result
    else:
        acc = metrics.accuracy_score(real_data, predict_data)
        recall = metrics.recall_score(real_data, predict_data,average='micro')
        precision = metrics.precision_score(real_data, predict_data,average='micro')
        f1 = metrics.f1_score(real_data, predict_data, average='micro')
        #roc = metrics.roc_auc_score(real_data, predict_data, average='micro')
        
        result = pd.DataFrame({"准确度":acc,
                               "召回率":recall,
                               "精准性":precision,
                               "f1":f1}, index = [kind])
    
        return result
        
        


def write_evalute(eva, modeltype, path = r'E:\job\正负分类\sa\evalute'):
    import datetime
    p = os.getcwd()
    path = path
    os.chdir(path)
    t = datetime.datetime.now().strftime('%Y-%m-%d__%H-%M-%S')
    name = t + str(modeltype) + ".csv"
    pd.DataFrame(eva).to_csv(name, encoding = 'utf-8-sig')
    os.chdir(p)
