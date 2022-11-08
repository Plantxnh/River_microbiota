import joblib
import numpy as np
import pandas as pd
import sklearn
from sklearn import metrics
import joblib
import matplotlib.pyplot as plt
import matplotlib as mpl
import math
def data(path,feature_num):
    data = pd.read_excel(path)
    Data = np.array(data)
    x = Data[:, :feature_num]
    y = Data[:, feature_num:]
    return x,y

def Max(y_test,y_pred):
    y_test_max = np.max(y_test)
    y_pred_max = np.max(y_pred)
    if y_test_max>y_pred_max:
        return (y_test_max+y_test_max*0.01)
    else:
        return (y_pred_max+y_pred_max*0.01)

def Min(y_test,y_pred):
    y_test_min=np.min(y_test)
    y_pred_min = np.min(y_pred)
    if y_pred_min<y_test_min:
        return (y_pred_min-y_pred_min*0.01)
    else:
        return (y_test_min-y_test_min*0.01)


def draw(y_test,y_pred,score,title,colors):
    '''

        :param y_test: 实际值
        :param y_pred: 预测值
        :param score: R^2值
        :param title: 图画的标题，保存的图画文件名也为title.png
        :param colors:点的颜色
        :return:
        '''
    plt.figure()
    plt.title(title,family='Arial', fontsize=20)
    # 添加文字，（10,170）为添加文字在图像中的坐标，可以修改
    plt.text(0.05, 0.2, 'RMSE:{}\nR^2:{}'.format(round(math.sqrt(metrics.mean_squared_error(y_test, y_pred)), 2), round(score, 2)), family='Times New Roman', fontsize=15)
    #添加点，alpha为点的透明度
    plt.scatter(y_test, y_pred,c=colors,alpha=0.5)
    #x轴和y轴的坐标参数定义
    plt.ylabel('Prediction', family='Arial', weight='normal', fontsize=15)
    plt.xlabel('Observation', family='Arial', weight='normal', fontsize=15)
    plt.xticks( family='Arial', weight='normal', fontsize=13)
    plt.yticks(family='Arial', weight='normal', fontsize=13)
    #图中固定x，y的坐标值
    y_max=Max(y_test,y_pred)
    y_min=Min(y_test,y_pred)
    plt.xlim(y_min,y_max)
    plt.ylim(y_min,y_max)
    # 画对角线，修改c=为修改颜色,修改（1,0）（1,0）为对角线的参数
    plt.plot((1, 0), (1, 0), transform=plt.gca().transAxes, ls='-', c='#DC143C', label="1:1 line")
    plt.plot((1, 0), (1.1, 0.1), transform=plt.gca().transAxes, ls='--', c='#DC143C', label="1:1 line")
    plt.plot((1.1, 0.1), (1, 0), transform=plt.gca().transAxes, ls='--', c='#DC143C', label="1:1 line")
    plt.savefig(title+'.pdf',dpi=600)
    plt.show()

if __name__=="__main__":
    # 前一个参数为输入的文件名，后一个参数为特征数量
    x,y=data("训练集function.xlsx",24)
    #加载模型，修改名称加载不同的模型
    model = joblib.load("function.pkl")
    #利用模型得到不同的预测值
    y_pred=model.predict(x)
    #得到R^2值
    score=sklearn.metrics.r2_score(y, y_pred)
    #画图，具体说明看函数
    draw(y,y_pred,score,'Functional potential','#00CED1')

