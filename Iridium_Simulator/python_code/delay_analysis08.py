# -*- coding:utf-8 -*-
"""
作者：huzhiwei
日期：2022年08月10日
绘制不同星座数目与延时情况图
"""

import matplotlib.pyplot as plt

satellite_num = [48,66,351,720,1156,1584,1764]
international_delay = [62.734,45.769,46.688,44.520,46.208,45.245,44.298]
domestic_delay = [16.699,11.452,10.427,10.024,6.927,6.525,9.865]

plt.title('Relation curve between number of satellites and communication delay')
plt.plot(satellite_num,international_delay,'b-*',label = 'international_delay')
plt.plot(satellite_num,domestic_delay,'g-o',label = 'domestic_delay')
plt.legend()
plt.xlabel('satellite_nums/Stars')
plt.ylabel('comunication_delay/ms')
plt.show()
