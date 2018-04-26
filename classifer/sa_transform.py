# -*- coding: utf-8 -*-
"""
Created on Thu Mar 29 14:11:03 2018

@author: gogoing

@ 功能： 分词之后，数据转化,分隔数据，预测数据变回原来的标签
        分词转化器这个需要留住用sa_model.model_save()进行
    
    - tfidf_trans:: tfidf转换
    - split_train_test::数据测试还有验证的分割
    - name_label::将变量变为原来的标签
    -
"""


from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer #TF-IDF向量转换类

def tfidf_trans(train_data, test_data, nfeatures):
    # 数据处理
    '''
        vc是词频量
        tfidf是一个信息量
        分词之后在文章出现的情况
        加入选择的特征数
    '''
    trans_vc =CountVectorizer(max_features = nfeatures)
    train_vc = trans_vc.fit_transform(train_data)
    
    trans_tfidf = TfidfTransformer() 
    train_tfidf = trans_tfidf.fit_transform(train_vc)  
    
    test_vc =trans_vc.transform(test_data)
    test_tfidf = trans_tfidf.transform(test_vc)
    
    return train_tfidf, test_tfidf, trans_vc, trans_tfidf



def split_train_test(feature_trans, label):
    import pandas as pd
    all_data = pd.DataFrame({"feature":feature_trans,
                             "target":label})
    
    from sklearn.utils import shuffle
    all_data = shuffle(all_data)
    
    length = int(all_data.shape[0]*0.8)
    train = all_data.iloc[0:length]
    test = all_data.iloc[length:]
    
    
    train_data = train['feature']
    train_target = train['target']
    
    test_data = test['feature']
    test_target = test['target']

    return train_data, train_target, test_data, test_target

# ---变成原来的标签
def name_label(pred, name):
    names = []
    for i in pred:
        names.append(name[i-1])
    return names

