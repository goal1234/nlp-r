# -*- coding: utf-8 -*-
"""
Created on Thu Mar 29 14:01:03 2018

@author: gogoing

@ 功能: 进行停词去除，分词，汇总每一个文件夹下的分词

    -remove_stop() 去除分词
    -gather()是进行汇总,输入一个字段有sa_corpus中获取 返回一个list
    -label()是为list打上标签 输入list
    -lebel_name() 得到目录下的标签
    
    
"""

def __every_jieba(filelist):
    import jieba
    '''单篇文章的分词处理'''
    res = []
    len1 = len(filelist)
    
    num = int(1)
    for i in filelist:
        print(round(num*100/len1,2), "%进行")
        temp = " ".join(jieba.cut(i))
        res.append(temp)
        num +=1
    return res

# 去除停词
def __stopwordslist(filepath):
    stopwords = [line.strip() for line in open(filepath, 'r').readlines()]
    return stopwords

def remove_stop(test):
    
    '''
    是一篇文章,经过了分词处理之后的
    每段都套了一个list
    '''
    stop_path = r'E:\job\Sentiment\Sentiment\data\stopwords.txt'
    stopwordlist = __stopwordslist(stop_path)
    
    print("fc")
    a = __every_jieba(test)
    print("*"*30,"\n\n分词结束")
    
    len1 = len(a)
    res = []
    num = int(1)
    for i in a:
        print("字符串替换进行了--->>>", round(num*100/len1, 2), "%")
        temp = ""
        for j in i:
            if j not in stopwordlist:
                temp+=j
        temp = temp.replace('\u3000', "").replace("", "")
        temp = temp.replace("\n", "")
        res.append(temp)
        num += 1
    return res


# test这个应该能够进行是一个文章而不是多个文章
def __flat(test):
    ''' 私有方法'''
    remove = remove_stop(test)
    res = ""
    for i in remove:
        res += i
    return res


# flatone
def __flat_list(ll):
    res = []
    for i in ll:
        temp = __flat(i)
        res.append(temp)
    return res



def label(res):
    
    '''
        为每个读入的字典进行打标签
    '''
    name = list(res.keys())
    rep_len = []
    for i in range(len(name)):
        length = len(res[name[i]])
        rep_len.append(length)


    this = []
    t = 1
    for i in name:
        this.append(t)
        t+= 1
    
    labeltime = []
    for val in this:
        for i in range(rep_len[val-1]):
                labeltime.append(val)
            
    return labeltime        
    
      
## 把name所有进行flat_list然后加起来
def gather(res):
    name = list(res.keys())
    gat = []
    for i in range(len(name)):
        print(i, "---->>>>>", name[i])
        a = __flat_list(res[name[i]])
        gat.extend(a)
        print('已经完成了第', i+1, "个")
    return gat


def label_name(res):
    '''
        得到目录下的标签
        '''
    name = list(res.keys())
    return name

