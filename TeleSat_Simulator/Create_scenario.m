function [conid] = Create_scenario()
% 建立连接
stkInit;
remMachine = stkDefaultHost;
conid = stkOpen(remMachine);

% 判断当前场景
scen_open = stkValidScen;
if scen_open == 1
    rst = questdlg('Close the current scenario?');
    if ~strcmp(rst,'Yes')
        stkClose(conid);
    else
        stkUnload('/*');
    end
end

% 创建场景
stkNewObj('/','Scenario','telesat_scenario');
end