function [parameter] = Create_satellites(path)
% 全局参数
global tStart tStop dt constellation plane_nums sats_plane No_leo;

% 读取文件信息
parameter = readtable(path);
parameter = parameter.Value;
constellation = parameter{1,1};
altitude = str2num(parameter{2,1});
period = str2num(parameter{3,1});
inclination = str2num(parameter{4,1});
phase_shift = str2num(parameter{5,1});
plane_nums = str2num(parameter{6,1});
sats_plane = str2num(parameter{7,1});
No_leo = plane_nums * sats_plane;
tStop = period;

% 卫星轨道信息
% 轨道大小形状
a = 6371 * 10^3 + altitude * 10^3;
e = 0;
% 轨道位置信息
inc = inclination * pi / 180;
w = 0;
% 判断轨道类型
if (inclination>80 && inclination<100) %极轨道类型
    Raan = [0:180/plane_nums:180-180/plane_nums];
else %倾斜类型
    Raan = [0:360/plane_nums:360-360/plane_nums];
end
raan = Raan.*(pi/180);
% 卫星位置信息
mean = [0:360/sats_plane:360-360/sats_plane];

% 创建卫星星座
for i = 1:plane_nums
    for j = 1:sats_plane
        % 导入参数
        ra = raan(i);
        me = (mod(mean(j) + 360 * phase_shift / No_leo * (i-1),360 ))* (pi/180);
        num = j + sats_plane * (i-1);
        % 卫星命名
        if num < 10
            sat_no = strcat('Sat00',num2str(num));
        elseif num < 100
            sat_no = strcat('Sat0',num2str(num));
        else
            sat_no = strcat('Sat',num2str(num));
        end
        stkNewObj('*/','Satellite',sat_no);
        sat_no = strcat('*/Satellite/',sat_no);
        stkSetPropClassical(sat_no,'J4Perturbation','J2000',tStart,tStop,dt,0,a,e,inc,w,ra,me);
        num_leo(num) = num;    
    end   
end

% 存储数据变量
save('Num_leo.mat','num_leo');
mkdir(strcat(constellation,'\\delay'));
end
