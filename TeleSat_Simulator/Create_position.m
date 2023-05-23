function [position,position_cbf] = Create_position()
% 全局变量
global No_leo No_fac No_snap tStart tStop dt Lat Long constellation

% 导入数据变量
load('Num_leo.mat');
load('Num_fac.mat');

% 设置空环境存放位置信息
index = 1;
position = cell(No_leo + No_fac,1);
position_cbf = cell(No_leo + No_fac,1);

% 保存位置信息
% 读取卫星LLA信息
for i = 1:No_leo
    if i < 10
        leo_info = strcat('*/Satellite/Sat00',num2str(i));
    elseif i < 100
        leo_info = strcat('*/Satellite/Sat0',num2str(i));
    else
        leo_info = strcat('*/Satellite/Sat',num2str(i));
    end
    [secData,secName] = stkReport(leo_info,'LLA Position',tStart,tStop,dt);
    lat = stkFindData(secData{1},'Lat');
    long = stkFindData(secData{1},'Lon');
    alt = stkFindData(secData{1},'Alt');    
    % 保存周期内卫星LLA信息
    llapos = zeros(3,No_snap);
    for j = 1:No_snap
        llapos(1,j) = llapos(1,j) + lat(j) * 180 / pi;
        llapos(2,j) = llapos(2,j) + long(j) * 180 / pi;
        llapos(3,j) = llapos(3,j) + alt(j);
    end
    position{index} = llapos;
    position_cbf{index} = Convert_coordinate(position{index,1});
    index = index + 1;
end

% 读取城市位置信息
for i = 1:No_fac
    llapos = zeros(3,No_snap);
    llapos(1,:) = llapos(1,:) + Lat(i);
    llapos(2,:) = llapos(2,:) + Long(i);
    position{index} = llapos;
    position_cbf{index} = Convert_coordinate(position{index,1});
    index = index + 1;
end

% 保存位置信息
filename = [constellation '\position.mat'];
save(filename,'position','position_cbf');
end