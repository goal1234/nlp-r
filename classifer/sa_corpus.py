# -*- coding: utf-8 -*-
"""
Created on Thu Mar 29 13:29:55 2018

@author: gogoing

@功能： 读入路径下的语料,

    -path_read() 返回一个字典，其中keys是目录名称，values是每一个txt读入进去的
    
"""

#%% 数据读入
''' 样本量比较平衡'''
import os

# ---读取目录的所有txt文件
def __read_txt(path):
    '''
    输入文件夹下路径
    编码错误直接跳过
    '''
    import glob
    import os
    
    path = path
    os.chdir(path)
    
    files = glob.glob("*.txt")
    
    if len(files) == 0:
        return "no txt"
        
    res = []
    for file in files:
        try:
            f = open(file, "r+")
            res.append(f.readlines())
            f.close()
        except:
            continue
    print("有评论", len(res), "条")
    return res
        

# 在一个目录下读取父文件夹，将下面的txt读入，返回一个字典对象
def path_read(path):
    '''
        输入文要进行分类的文件夹
    '''
    wd = os.getcwd()
    path = path
    name = os.listdir(path)
    res = {}
    for i in name:
        path1 = os.path.join(path, i)
        os.chdir(path1)
        a = __read_txt(path1)
        name1 = str(i)
        res[name1] = a
        
    os.chdir(wd)
    return res
    

#%%%

