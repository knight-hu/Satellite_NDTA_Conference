clear;
clc;

% 城市坐标 -- 北京/纽约/成都
Lat = [39.93 40.72 30.67];
Long = [116.33 -74.00 104.07];

% Lat = [35.68 37 30.67];
% Long = [139.73 -76.77 104.07];

% 设置空环境存放位置信息
index = 1;
position = cell(3,1);
position_cbf = cell(3,1);

% 读取城市位置信息
for i = 1:3
    llapos = zeros(3,1);
    llapos(1,:) = llapos(1,:) + Lat(i);
    llapos(2,:) = llapos(2,:) + Long(i);
    position{index} = llapos;
    position_cbf{index} = Convert_coordinate(position{index,1});
    index = index + 1;
end

% 计算直线距离
% 北京-纽约9675km
distance(1,1) = sqrt(((position_cbf{1,1}(1,1) - position_cbf{2,1}(1,1)))^2 + (position_cbf{1,1}(2,1) - position_cbf{2,1}(2,1))^2 + (position_cbf{1,1}(3,1) - position_cbf{2,1}(3,1))^2);
% 北京-成都1509km
distance(1,2) = sqrt(((position_cbf{1,1}(1,1) - position_cbf{3,1}(1,1)))^2 + (position_cbf{1,1}(2,1) - position_cbf{3,1}(2,1))^2 + (position_cbf{1,1}(3,1) - position_cbf{3,1}(3,1))^2);


