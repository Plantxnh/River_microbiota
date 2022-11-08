import joblib
import numpy as np
import pandas as pd
import sklearn
from sklearn import metrics
import joblib
import matplotlib.pyplot as plt
import matplotlib as mpl

path = "预测模型/抗生素_function_待预测.xlsx"
data = pd.read_excel(path)  # 数据读入
name = list(data.columns.values)
Data = np.array(data)
Data_new = Data
model = "预测模型/function.pkl"
forest = joblib.load(filename=model)
predict = forest.predict(Data)
#print(Data_new.shape)
#print(predict.shape)
Data_new = np.c_[Data_new, predict]
print(Data_new)
new_Data = pd.DataFrame(Data_new)
new_Data.to_excel('预测模型/抗生素_function_待预测结果.xlsx', index=False, header=False)
# data=np.concatenate([Data,predict],axis=1)
# print(data.shape)
'''
def data(path1,feature_num):
    data1 = pd.read_excel(path1)
    Data1 = np.array(data1)
    val1 = Data1[:, :feature_num]
    y_test1 = Data1[:, feature_num:]

def draw(y_test,y_pred,score):
    plt.figure()
    # plt.title('Validation ROC')
    y_test = list(y_test)

    # 添加文字
    plt.text(0.5, 0.54, 'MSE:{}\nR^2:{}'.format(round(metrics.mean_squared_error(y_test, y_pred), 6), round(score, 2)), family='Times New Roman', fontsize=15)
    plt.scatter(y_test, y_pred)
    plt.ylabel('Prediction', family='Times New Roman', weight='normal', fontsize=15)
    plt.xlabel('Observation', family='Times New Roman', weight='normal', fontsize=15)
    # 画对角线
    line = plt.plot((1, 0), (1, 0), transform=plt.gca().transAxes, ls='--', c='k', label="1:1 line")
    line = plt.plot((1, 0), (1.25, 0.25), transform=plt.gca().transAxes, ls='--', c='k', label="1:1 line")
    line = plt.plot((1.25, 0.25), (1, 0), transform=plt.gca().transAxes, ls='--', c='k', label="1:1 line")
    # plt.savefig('AUC.png',dpi=600)
    plt.show()

if __name__=="__main__":
    path = "海洋数据填充后机器学习求平均.xlsx"
    x,y=data(path,19)
    model = joblib.load("best_forest_rundata3.pkl")
    y_pred=model.predict(x)
    score=sklearn.metrics.r2_score(y, y_pred)
    draw(y,y_pred,score)

'''
