# -*- coding:utf-8 -*-
"""
作者：huzhiwei
日期：2022年08月08日
分析铱星星座的延时性能
获得北京到纽约与成都的延时网格图
获得北京到纽约与成都的周期内延时结果
"""

import scipy.io as scio
import numpy as np
import networkx as nx
import matplotlib.pyplot as plt

# 星座参数设置
satellite_num = 66
city_num = 3
bound = 10
period = 6028

# 设置空环境变量
dt = [[0 for i in range(1,period + 1) if i % 60 == 1] for _ in range(2)]

# 导入延时信息
for time in range(1,period + 1):
    if time % 60 == 1:
        # 设置空环境变量
        dl = []
        element = []
        node_colors = []
        G = nx.Graph()
        G.add_nodes_from(range(satellite_num + city_num))
        # 读取延时变量
        path = 'P:\\PRJ-SOLAR2022\\trunk\\01. 成员工作区\\胡智伟\\04Conference_paper' \
               '\\Iridium_Simulator\\\matlab_code\\Iridium\\delay\\' + str(time) + '.mat'
        data = scio.loadmat(path)
        delay = data['delay']
        for i in range(satellite_num):
            # 读取星间延时信息
            for j in range(i+1,satellite_num):
                if delay[i][j] > 0:
                    element.append((i,j,delay[i][j]))
            # 读取星地延时信息
            for j in range(satellite_num,satellite_num + city_num):
                if delay[i][j] < bound:
                    element.append((i,j,delay[i][j]))
        # 添加网格图权值
        G.add_weighted_edges_from(element)
        # 分析城市间延时路径与延时
        count = 0
        for i in range(satellite_num,satellite_num + city_num -2):
            for j in range(i+1,satellite_num + city_num):
                if nx.has_path(G,source = i,target = j):
                    dt[count][time//60] = nx.dijkstra_path_length(G,source = i,target =j)
                    dl.append(nx.shortest_path(G,source = i,target =j))
                else:
                    print('error')
                count += 1
        # 卫星节点上色
        for node in G.nodes():
            if node in dl[0] and node in dl[1]:
                node_colors.append('red')
            elif node in dl[1] and node not in dl[0]:
                node_colors.append('yellow')
            elif node in dl[0] and node not in dl[1]:
                node_colors.append('green')
            else:
                node_colors.append('lightblue')
        # 绘制星座网格图
        nx.draw_networkx(G,node_color = node_colors)
        plt.title('Iridium Constellation Delay Grid Chart')
        plt.show()

# 保存所有对应延时信息
np.savetxt('all_delay_info.csv',element,fmt = '%f')
np.savetxt('city_delay_info.csv',dt,fmt = '%f')

