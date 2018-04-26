    # -*- coding: utf-8 -*-
"""
Created on Thu Mar 29 14:13:21 2018

@author: gogoing

@ 功能：
    主要是各种分类器的模型
        输入: 转化后的数据，对应的标签
        输出：模型,还有模型评价的结果
    模型保存：sklearn的对象保存在path中
    模型加载:


@ 分类器
    - clf_nb:: 贝叶斯
    - clf_svm:: 支持向量机
    - clf_sgd:: 随机梯度
    - clf_dt:: 决策数
    - clf_gdbt:: 极限梯度
    - clf_knn:: k临近，将k设定为和分类数量一样的
"""
from sa_evalute import evalute



def clf_nb(train, train_target, test, test_target):
    '''
        贝叶斯分类器
        '''
    from sklearn.naive_bayes import MultinomialNB
    clf = MultinomialNB(alpha = 0.01)
    clf.fit(train, train_target)    
    pred = clf.predict(test)    
    res = evalute(test_target, pred, kind = 'MultinomialNB')
    
    return clf, res



def clf_svm(train, train_target, test, test_target):
    # ---支持向量机
    from sklearn import svm
    clf_svc = svm.SVC()
    clf_svc.fit(train, train_target)
    print("svm正在进行中......")
    pred = clf_svc.predict(test)
    rr_pred = evalute(test_target, pred, kind = 'svc')

    return clf_svc, rr_pred


def clf_sgd(train, train_target, test, test_target):
    ''' 
        通过sgd进行
        '''
    from sklearn.linear_model import SGDClassifier
    clf_sgd =SGDClassifier()
    clf_sgd.fit(train, train_target)
    print("sgd.fit is Working!")
    pred = clf_sgd.predict(test)
    sgd_pred = evalute(test_target, pred, kind = 'sgd')

    return clf_sgd, sgd_pred



def clf_dt(train, train_target, test, test_target): 
    '''
        决策树
        '''
    from sklean import tree
    clf_tree = tree.DecisionTreeClassifier()
    clf_tree.fit(train, train_target)
    pred = clf_tree.predict(test)
    tree_pred = evalute(test_target, pred, kind = 'DT')
    
    return clf_tree, tree_pred


    
def clf_gbdt(train, train_target, test, test_target):    
    from sklearn.ensemble import GradientBoostingClassifier    
    clf_gbdt = GradientBoostingClassifier(n_estimators = 100, max_depth = 3)    
    clf_gbdt.fit(train, train_target)
    print("gdbt is working......")
    pred = clf_gbdt.predict(test)
    rr_gbdt = evalute(test_target, pred, kind = 'gbdt')

    return clf_gbdt, rr_gbdt



def clf_knn(train, train_target, test, test_target, k): 
    from sklearn.neighbors import KNeighborsClassifier  
    clf_knn = KNeighborsClassifier(n_neighbors = k)#default with k=5  
    clf_knn.fit(train, train_target)
    pred = clf_knn.predict(test)
    rr_knn = evalute(test_target, pred, kind = 'knn_vc')

    return clf_knn, rr_knn




def model_save(model, path, name):
    # -- 模型保存
    import os
    now1 = os.getcwd()
    if type(name) != str:
        return "name must be str!!"
    from sklearn.externals import joblib   
    os.chdir(path)
    joblib.dump(model, name)
    os.chdir(now1)
    


def model_load(path, name):
    import os
    now1 = os.getcwd()
    from sklearn.externals import joblib   
    os.chdir(path)
    res = joblib.load(name)
    os.chdir(now1)
    return res
