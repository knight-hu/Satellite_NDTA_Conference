%% 建立铱星星座
clear all;clc;

%% 全局参数
global tStart tStop dt constellation plane_nums sats_plane No_leo No_fac No_snap Lat Long;
tStart = 0;
dt = 1;
No_snap = 5839;% 运行周期

%% 新建场景
[conid] = Create_scenario();

%% 创建卫星
[parameter] = Create_satellites('Kuiper.xlsx');

%% 创建城市
Create_facilities(conid);

%% 保存数据
[position,position_cbf] = Create_position();

%% 计算延时
inc = str2num(parameter{4,1});
% 间隔1分钟记录一张快照
for t = 1:60:No_snap
    [delay] = Create_delay(position_cbf,t, inc);
end

%% 开启动画
stkExec(conid,'Animate Scenario/kuiper_scenario Reset');
stkExec(conid,'Animate Scenario/kuiper_scenario Start');

%% 关闭连接
stkClose(conid);
stkClose