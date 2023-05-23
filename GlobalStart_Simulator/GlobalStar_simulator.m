%% ����ҿ������
clear all;clc;

%% ȫ�ֲ���
global tStart tStop dt constellation plane_nums sats_plane No_leo No_fac No_snap Lat Long;
tStart = 0;
dt = 1;
No_snap = 6846;% ��������

%% �½�����
[conid] = Create_scenario();

%% ��������
[parameter] = Create_satellites('GlobalStar.xlsx');

%% ��������
Create_facilities(conid);

%% ��������
[position,position_cbf] = Create_position();

%% ������ʱ
inc = str2num(parameter{4,1});
% ���1���Ӽ�¼һ�ſ���
for t = 1:60:No_snap
    [delay] = Create_delay(position_cbf,t, inc);
end

%% ��������
stkExec(conid,'Animate Scenario/globalstar_scenario Reset');
stkExec(conid,'Animate Scenario/globalstar_scenario Start');

%% �ر�����
stkClose(conid);
stkClose