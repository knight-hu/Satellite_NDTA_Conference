function [delay] = Create_delay(position_cbf,time, inc)
% 全局变量
global No_fac  No_leo constellation plane_nums sats_plane;

% 导入数据变量
load('Num_leo.mat')
load('Num_fac.mat');

% 设置空环境用于存放距离与延时
distance = zeros(No_fac+No_leo,No_fac+No_leo);
delay = zeros(No_fac+No_leo,No_fac+No_leo);

% 计算卫星距离与延时
for i=1:plane_nums
    for j=1:sats_plane
        cur_leo = (i-1)*sats_plane + j;
        % 计算轨道内延时
        if j ~= sats_plane
            up_leo = (i-1) * sats_plane + j + 1;
        else
             up_leo = (i-1) * sats_plane + 1;
        end
        distance(cur_leo,up_leo) = sqrt((position_cbf{cur_leo,1}(1,time) - position_cbf{up_leo,1}(1,time))^2 + (position_cbf{cur_leo,1}(2,time) - position_cbf{up_leo,1}(2,time))^2 + (position_cbf{cur_leo,1}(3,time) - position_cbf{up_leo,1}(3,time))^2);
        distance(up_leo,cur_leo) = distance(cur_leo,up_leo);
        delay(cur_leo,up_leo) = distance(cur_leo,up_leo) / (3 * 10^5);
        delay(up_leo,cur_leo) = delay(cur_leo,up_leo);
        % 计算轨道间延时
        if i ~= plane_nums
            right_leo = i * sats_plane + j;
        else
            if inc > 80 && inc < 100
                continue;
            else
                right_leo = j;
            end
        end
        distance(cur_leo,right_leo) = sqrt((position_cbf{cur_leo,1}(1,time) - position_cbf{right_leo,1}(1,time))^2 + (position_cbf{cur_leo,1}(2,time) - position_cbf{right_leo,1}(2,time))^2 + (position_cbf{cur_leo,1}(3,time) - position_cbf{right_leo,1}(3,time))^2);
        distance(right_leo,cur_leo) = distance(cur_leo,right_leo);
        delay(cur_leo,right_leo) = distance(cur_leo,right_leo) / (3 * 10^5);
        delay(right_leo,cur_leo) = delay(cur_leo,right_leo);
    end
end

% 计算卫星与4个地面城市距离与延时
for i = 1:No_leo  
    for j = No_leo + 1:No_fac+No_leo
        distance(i,j) = sqrt((position_cbf{i,1}(1,time) - position_cbf{j,1}(1,time))^2 + (position_cbf{i,1}(2,time) - position_cbf{j,1}(2,time))^2 + (position_cbf{i,1}(3,time) - position_cbf{j,1}(3,time))^2);
        distance(j,i) = distance(i,j);
        delay(i,j) = distance(i,j) / (3 * 10^5);
        delay(j,i) = delay(i,j);
    end
end

% 保存延时信息
filename = [constellation '\delay\'];
filename = strcat(filename,num2str(time));
filename = strcat(filename,'.mat');
save(filename,'delay') 
end
