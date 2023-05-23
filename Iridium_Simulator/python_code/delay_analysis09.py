# -*- coding:utf-8 -*-
"""
作者：huzhiwei
日期：2022年08月12日
读取覆盖性能
"""

import pandas as pd
import matplotlib.pyplot as plt

path = ['GlobalStar.csv','Iridium.csv','TeleSat.csv','Kuiper.csv','StarLink.csv','OneWeb.csv']
color = ['p-.','k*','y-|','g-','b-.','r-.']

def read_path(path):
    data = pd.read_csv(path)
    xlabel = data['Latitude (deg)']
    ylabel = data['Percent Time Covered']
    return xlabel,ylabel

def main():
    for i in range(len(path)):
        xlabel,ylabel = read_path(path[i])
        plt.plot(xlabel,ylabel,color[i],label= path[i].rstrip('.csv'))
        plt.legend()


if __name__ == '__main__':
    main()
    plt.xlabel('Latitude (deg)')
    plt.ylabel('Percent Time Covered(%)')
    plt.xlim(-90,90)
    plt.ylim(0,165)
    plt.grid()
    plt.show()