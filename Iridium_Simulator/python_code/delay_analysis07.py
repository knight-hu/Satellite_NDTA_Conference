# -*- coding:utf-8 -*-
"""
作者：huzhiwei
日期：2022年08月09日
绘制两种场景下每个星座的延时情况
"""

import csv
import matplotlib.pyplot as plt
import numpy as np

# 星座参数写入
period = [6846,6028,6327,6566,5839,6929,6566]
constellation_name = ['GlobalStar','Iridium','TeleSat','OneWeb1','Kuiper','StarLink','OneWeb']
satellite_num = [48,66,351,720,1156,1584,1764]
constellation_num = len(constellation_name)


# 读取星座延时信息
def read_delay(path):
    delay = []
    with open(path)as f:
        reader = csv.reader(f)
        for row in reader:
            delay.append(row)
    delay0 = [float(i) for i in delay[0][0].split()]
    delay1 = [float(i) for i in delay[1][0].split()]
    return delay0,delay1

def main():
    for num in range(constellation_num):
        path = 'communication' + str(num) + '.csv'
        delay0,delay1 = read_delay(path)
        times = [i for i in range(1,len(delay0) + 1)]

        # 计算平均延时
        delay0_ave = np.mean(delay0)
        delay1_ave = np.mean(delay1)
        print(f'Beijing->NewYork:{delay0_ave:.3f}ms ; Beijing->Chengdu:{delay1_ave:.3f}ms')
        # 延时情况绘图
        plt.title(constellation_name[num] + ' Constellation Delay information')
        plt.plot(times, delay0, 'r--', label='Beijing->NewYork')
        plt.legend()
        plt.plot(times, delay1, 'b-.', label='Beijing->Chengdu')
        plt.legend()
        plt.xlabel('Period/s')
        plt.ylabel('Delay/ms')
        plt.ylim(0, 80)
        plt.show()


if __name__ == '__main__':
    main()


