# -*- coding:utf-8 -*-
"""
作者：huzhiwei
日期：2022年08月08日
对北京到纽约与成都的延时数据可视化
"""

import csv
import matplotlib.pyplot as plt
import numpy as np

# 星座数据信息
period = 6028
times = []
delays = []

# 可视化数据结果
# 横坐标信息
for time in range(1,period + 1 ):
    if time % 60 == 1:
        times.append(time)
# 纵坐标信息
with open('city_delay_info.csv')as f:
    reader = csv.reader(f)
    for row in reader:
        delays.append(row)
delays1 = delays[0]
delays2 = delays[1]
delays1 = [float(i) for i in delays1[0].split()]
delays1_ave = np.mean(delays1)
print(f'Beijing->NewYork:{delays1_ave:.3f}ms')
delays2 = [float(i) for i in delays2[0].split()]
delays2_ave = np.mean(delays2)
print(f'Beijing->Chengdu:{delays2_ave:.3f}ms')

# 绘制数据图形
plt.title('Iridium Constellation Delay information')
plt.plot(times,delays1,'r--',label = 'Beijing->NewYork')
plt.legend()
plt.plot(times,delays2,'b-.',label = 'Beijing->Chengdu')
plt.legend()
plt.xlabel('Period/s')
plt.ylabel('Delay/ms')
plt.ylim(0,80)
plt.show()

