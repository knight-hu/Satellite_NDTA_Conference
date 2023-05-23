function Create_facilities(conid)
% 全局变量
global No_fac Lat Long;

% 1--城市坐标 -- 北京/纽约/成都
Lat = [39.93 40.72 30.67];
Long = [116.33 -74.00 104.07];

No_fac = length(Long);

% 2--导入城市信息 
for i=1:No_fac
    info_facility = strcat('Fac',num2str(i));
    stkNewObj('*/','Facility',info_facility);
    long = Long(i);
    lat = Lat(i);
    info_facility = strcat('Scenario/kuiper_scenario/Facility/',info_facility);
    stkSetFacPosLLA(info_facility,[lat*pi/180;long*pi/180;0]);
    stkConnect(conid,'SetConstraint',info_facility,'ElevationAngle Min 20');
    num_fac(i) = i;
end

% 3--保存数据变量
save('Num_fac.mat','num_fac');
end
