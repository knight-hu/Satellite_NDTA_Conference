# -*- coding:utf-8 -*-
"""
作者：huzhiwei
日期：2022年08月09日
绘制国内间针对不同星座下的延时情况
"""

# -*- coding:utf-8 -*-
"""
作者：huzhiwei
日期：2022年08月09日
"""

import csv
import matplotlib.pyplot as plt

# 读取星座延时信息
def read_delay(path):
    delay = []
    with open(path)as f:
        reader = csv.reader(f)
        for row in reader:
            delay.append(row)
    delay = [float(i) for i in delay[1][0].split()]
    return delay

def main():
    # 坐标信息
    path0 = 'communication0.csv'
    delay0 = read_delay(path0)
    times0 = [i for i in range(1,len(delay0) + 1)]

    path1 = 'communication1.csv'
    delay1 = read_delay(path1)
    times1 = [i for i in range(1,len(delay1) + 1)]

    path2 = 'communication2.csv'
    delay2 = read_delay(path2)
    times2 = [i for i in range(1, len(delay2) + 1)]

    path3 = 'communication3.csv'
    delay3 = read_delay(path3)
    times3 = [i for i in range(1, len(delay3) + 1)]

    path4 = 'communication4.csv'
    delay4 = read_delay(path4)
    times4 = [i for i in range(1, len(delay4) + 1)]

    path5 = 'communication5.csv'
    delay5 = read_delay(path5)
    times5 = [i for i in range(1, len(delay5) + 1)]

    path6 = 'communication6.csv'
    delay6 = read_delay(path6)
    times6 = [i for i in range(1, len(delay6) + 1)]

    # 延时情况绘图
    # plt.title('Domestic delay under different constellations:Beijing->Chengdu')
    plt.plot(times0, delay0, 'p-', label = 'Inclined_GlobalStar_48')
    plt.plot(times1, delay1, 'k-.', label = 'Polar_Iridium_66')
    plt.plot(times2, delay2, 'm-.', label = 'Polar_TeleSat_351')
    plt.plot(times3, delay3, 'b-.', label = 'Polar_OneWeb1_720')
    plt.plot(times4, delay4, 'c-', label = 'Inclined_Kuiper_1156')
    plt.plot(times5, delay5, 'r-', label = 'Inclined_StarLink_1584')
    plt.plot(times6, delay6, 'g-.', label = 'Polar_OneWeb_1764')
    plt.legend()
    plt.xlabel('period/min')
    plt.ylabel('delay/ms')
    # plt.ylim(35,110)
    plt.show()

if __name__ == '__main__':
    main()




