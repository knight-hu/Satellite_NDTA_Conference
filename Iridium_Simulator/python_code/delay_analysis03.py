# -*- coding:utf-8 -*-
"""
作者：huzhiwei
日期：2022年08月08日
分析国际间与国内间针对不同星座下的延时情况
"""

import scipy.io as scio
import networkx as nx
import matplotlib.pyplot as plt
import numpy as np

# 星座参数写入
period = [6846,6028,6327,6566,5839,6929,6566]
constellation_name = ['GlobalStar','Iridium','TeleSat','OneWeb1','Kuiper','StarLink','OneWeb']
satellite_num = [48,66,351,720,1156,1584,1764]
constellation_num = len(constellation_name)
city_num = 3
bound = 10


for num in range(constellation_num):
    # 设置空环境变量
    dt = [[0 for i in range(1, period[num] + 1) if i % 60 == 1] for i in range(2)]
    for time in range(1,period[num] + 1):
        if time % 60 == 1:
            # 设置空环境变量
            element = []
            G = nx.Graph()
            G.add_nodes_from(range(satellite_num[num] + city_num))
            # 读取延时信息
            path = 'P:\\PRJ-SOLAR2022\\trunk\\01. 成员工作区\\胡智伟\\04Conference_paper\\' \
                   + constellation_name[num] + '_Simulator\\matlab_code\\' + constellation_name[num] + '\\delay\\' + str(time) + '.mat'
            data = scio.loadmat(path)
            delay = data['delay']
            for i in range(satellite_num[num]):
                # 计算星间延时情况
                for j in range(i + 1,satellite_num[num]):
                    if delay[i][j] > 0:
                        element.append((i,j,delay[i][j]))
                for j in range(satellite_num[num],satellite_num[num] + city_num):
                    if delay[i][j] < bound:
                        element.append((i,j,delay[i][j]))
            G.add_weighted_edges_from(element)

            # 存储国际间延时信息 北京-纽约
            count = 0
            for i in range(satellite_num[num],satellite_num[num] + city_num -2):
                for j in range(i + 1,satellite_num[num] + city_num):
                    if nx.has_path(G,source = i,target = j):
                        dt[count][time // 60] = nx.dijkstra_path_length(G,source = i,target = j)
                    else:
                        print('error')
                    count += 1
    nx.draw_networkx(G)
    plt.show()
    np.savetxt('communication' + str(num) + '.csv',dt,fmt = '%f')





