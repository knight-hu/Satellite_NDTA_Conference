function [conid] = Create_scenario()
% ��������
stkInit;
remMachine = stkDefaultHost;
conid = stkOpen(remMachine);

% �жϵ�ǰ����
scen_open = stkValidScen;
if scen_open == 1
    rst = questdlg('Close the current scenario?');
    if ~strcmp(rst,'Yes')
        stkClose(conid);
    else
        stkUnload('/*');
    end
end

% ��������
stkNewObj('/','Scenario','telesat_scenario');
end