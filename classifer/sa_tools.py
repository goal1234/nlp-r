# -*- coding: utf-8 -*-
"""
Created on Fri Mar 30 08:38:47 2018

@author: gogoing

@ 功能：保存标签
        加载标签
        输出训练好的数据

"""


def store_label(name, obj, path = r'E:\job\正负分类\sa\model\labels'):
    if type(name) != str:
        return "Please enter a str!"
    
    import pickle
    import os
    p = os.getcwd()
    os.chdir(path)
    names = name+".pkl"
    with open(names, 'wb') as f:
        pickle.dump(obj, f)    
    f.close()
    os.chdir(p)
    
    
    
def load_label(name,path = r'E:\job\正负分类\sa\model\labels'):
    import pickle
    import os
    p = os.getcwd()
    os.chdir(path)
    names = name+".pkl"
    if names not in os.listdir(path):
        return print("No such a file in here !! ->>>", path) 
    with open(names, 'rb') as f:
        res = pickle.load(f)    
    f.close()
    os.chdir(p)
    return res


def pred_store_csv(name, obj, path = r'E:\job\正负分类\sa\predict'):
    import os
    import pandas as pd
    p = os.getcwd()
    os.chdir(path)
    name2 = name + ".csv"
    pd.DataFrame(obj).to_csv(name2, encoding = 'utf-8-sig', index = False)
    os.chdir(p)
    

def pred_store_xlsx(name, obj, path = r'E:\job\正负分类\sa\predict'):
    import os
    import pandas as pd
    p = os.getcwd()
    os.chdir(path)
    name2 = name + ".xlsx"
    pd.DataFrame(obj).to_excel(name2, index = False)
    os.chdir(p)
    