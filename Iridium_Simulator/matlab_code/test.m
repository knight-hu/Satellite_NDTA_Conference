clear;
clc;

% �������� -- ����/ŦԼ/�ɶ�
Lat = [39.93 40.72 30.67];
Long = [116.33 -74.00 104.07];

% Lat = [35.68 37 30.67];
% Long = [139.73 -76.77 104.07];

% ���ÿջ������λ����Ϣ
index = 1;
position = cell(3,1);
position_cbf = cell(3,1);

% ��ȡ����λ����Ϣ
for i = 1:3
    llapos = zeros(3,1);
    llapos(1,:) = llapos(1,:) + Lat(i);
    llapos(2,:) = llapos(2,:) + Long(i);
    position{index} = llapos;
    position_cbf{index} = Convert_coordinate(position{index,1});
    index = index + 1;
end

% ����ֱ�߾���
% ����-ŦԼ9675km
distance(1,1) = sqrt(((position_cbf{1,1}(1,1) - position_cbf{2,1}(1,1)))^2 + (position_cbf{1,1}(2,1) - position_cbf{2,1}(2,1))^2 + (position_cbf{1,1}(3,1) - position_cbf{2,1}(3,1))^2);
% ����-�ɶ�1509km
distance(1,2) = sqrt(((position_cbf{1,1}(1,1) - position_cbf{3,1}(1,1)))^2 + (position_cbf{1,1}(2,1) - position_cbf{3,1}(2,1))^2 + (position_cbf{1,1}(3,1) - position_cbf{3,1}(3,1))^2);


