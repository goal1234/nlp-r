# -*- coding: utf-8 -*-
"""
Created on Thu Mar 29 13:08:17 2018

@author: gogoing
"""

import os
path_main = os.getcwd()


path = r'E:\job\正负分类\sa\corpus\ch\neg_pos'

import sa_corpus

a = sa_corpus.path_read(path)


import sa_fc
b = sa_fc.gather(a)

# 训练的标签
labels = sa_fc.label(a)
label_name = list(a.keys())


# 分隔训练，测试。同时进行转化
import sa_transform
train_data, train_target, test_data, test_target = sa_transform.split_train_test(b, labels)
train_tfidf, test_tfidf, trans_vc, trans_tfidf = sa_transform.tfidf_trans(train_data, test_data, nfeatures=3000)


# 训练模型
import sa_model
clf_nb, res_nb = sa_model.clf_nb(train_tfidf,train_target, test_tfidf, test_target)
clf_knn, res_knn = sa_model.clf_knn(train_tfidf, train_target, test_tfidf, test_target, 9)
clf_gbdt, res_gbdt = sa_model.clf_gbdt(train_tfidf, train_target, test_tfidf, test_target)


# 保存模型结果
import sa_evalute
sa_evalute.write_evalute(res_nb, 'nb')
sa_evalute.write_evalute(res_nb, 'knn')
sa_evalute.write_evalute(res_gbdt, 'gbdt')



# --模型标签进行保存
import sa_tools
pathmodel = r'E:\job\正负分类\sa\model'
# --保存转化器
sa_model.model_save(trans_vc, pathmodel, "正负情感trans_vc")
sa_model.model_save(trans_tfidf, pathmodel, "正负情感trans_tfidf")

# --保存模型
sa_model.model_save(clf_nb, pathmodel, '正负情感navieb')
sa_model.model_save(clf_gbdt, pathmodel, "正负情感gbdt")

# ---保存标签
sa_tools.store_label("正负情感", label_name)




