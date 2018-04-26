# -*- coding: utf-8 -*-
"""
Created on Thu Mar 29 16:41:09 2018

@author: gogoing
"""



import pandas as pd
import sa_fc
import sa_transform
import sa_model
import sa_tools


# --- 数据预处理
a = r"C:\Users\gogoing\Documents\Tongda\20180116HWWETL1.xlsx"
b = pd.read_excel(a)
context = b['内容']
c = sa_fc.remove_stop(context)


# --- 加载转化器，分类器
model_path = r'E:\job\正负分类\sa\model'
trans_vc = sa_model.model_load(model_path, '正负情感trans_vc')
trans_tfidf = sa_model.model_load(model_path, '正负情感trans_tfidf')
clf = sa_model.model_load(model_path, '正负情感gbdt')

# --- 加载标签
name = sa_tools.load_label("正负情感")


# --- 进行相关的转化
aa = trans_vc.fit_transform(c)
trans = trans_tfidf.transform(aa)


# --- 模型预测
pred = clf.predict(trans)


# --- 标签进行还原
pred_res = sa_transform.name_label(pred, name)
b['predict'] = pred_res


# ---保存
sa_tools.pred_store_xlsx("正负情感新闻", b)

