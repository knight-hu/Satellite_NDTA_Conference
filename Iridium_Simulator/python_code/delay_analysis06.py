# -*- coding:utf-8 -*-
"""
作者：huzhiwei
日期：2022年08月09日
针对每一个星座分析两种场景
"""

import scipy.io as scio
import numpy as np
import networkx as nx
import matplotlib.pyplot as plt

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
            dl = []
            element = []
            node_colors = []
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
                        dl.append(nx.shortest_path(G, source=i, target=j))
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
    print(dl)

    # 绘制末端星座网格图
    nx.draw_networkx(G, node_color=node_colors)
    plt.title(constellation_name[num] + ' Constellation Delay Grid Chart')
    plt.show()


