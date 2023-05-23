function [position,position_cbf] = Create_position()
% ȫ�ֱ���
global No_leo No_fac No_snap tStart tStop dt Lat Long constellation

% �������ݱ���
load('Num_leo.mat');
load('Num_fac.mat');

% ���ÿջ������λ����Ϣ
index = 1;
position = cell(No_leo + No_fac,1);
position_cbf = cell(No_leo + No_fac,1);

% ����λ����Ϣ
% ��ȡ����LLA��Ϣ
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
    % ��������������LLA��Ϣ
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

% ��ȡ����λ����Ϣ
for i = 1:No_fac
    llapos = zeros(3,No_snap);
    llapos(1,:) = llapos(1,:) + Lat(i);
    llapos(2,:) = llapos(2,:) + Long(i);
    position{index} = llapos;
    position_cbf{index} = Convert_coordinate(position{index,1});
    index = index + 1;
end

% ����λ����Ϣ
filename = [constellation '\position.mat'];
save(filename,'position','position_cbf');
end