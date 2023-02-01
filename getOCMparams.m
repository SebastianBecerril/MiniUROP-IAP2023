function [paramsOCM] = getOCMparams(ID)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if strcmp(ID, 'droneV1')
    %RODSEX2013
    %import
    paramsOCM.imp_format = 'mp4';
    
    %grid
    paramsOCM.ocm_freq = 2;     %[Hz]
    paramsOCM.X_res = 0.2;   %[m]
    paramsOCM.Y_res = 0.2;   %[m]
    paramsOCM.X_min = 96;     %CHANGE
    paramsOCM.X_max = 145;    %CHANGE
    paramsOCM.Y_min = 576; %CHANGE
    paramsOCM.Y_max = 650; %CHANGE
    
    %stack
    paramsOCM.Al_bar =10;    %[m]
    paramsOCM.Cs_bar =10;    %[m]
    paramsOCM.X_gap = 3;      %[m]
    paramsOCM.Y_gap = 3;      %[m]
    
    % OCM
    paramsOCM.vel_bnd = [-2 2];   %[m/s]
    paramsOCM.wndw = 20;    %[s]
    paramsOCM.stp = 10;   %[s]
    
    paramsOCM.minvar = 100;
    paramsOCM.maxskew = 2;
    paramsOCM.minent = 6;
    
elseif strcmp(ID,'top21')
    %import
    paramsOCM.imp_format = 'tif';
    paramsOCM.imp_freq = 2;  %[Hz]
    paramsOCM.imp_intvl = 600; %[s]
    
    %grid
    paramsOCM.ocm_freq = 2;     %[Hz]
    paramsOCM.X_res = 0.2;   %[m]
    paramsOCM.Y_res = 0.2;   %[m]
%     paramsOCM.X_min = 55;     %[m]
%     paramsOCM.X_max = 310;    %[m]
%     paramsOCM.Y_min = 590;
%     paramsOCM.Y_max = 1110;
    paramsOCM.X_min = 55;     %[m]
    paramsOCM.X_max = 310;    %[m]
    paramsOCM.Y_min = 590;
    paramsOCM.Y_max = 950;
    
    %stack
    paramsOCM.Al_bar = 10;    %[m]
    paramsOCM.Cs_bar = 10;    %[m]
    paramsOCM.X_gap = 3.2;      %[m]
    paramsOCM.Y_gap = 3.2;      %[m]
    
    % OCM
    paramsOCM.vel_bnd = [-2 2];   %[m/s]
    paramsOCM.wndw = 20;    %[s]
    paramsOCM.stp = 10;   %[s]
    
    paramsOCM.minvar = 0.5e7;
    paramsOCM.maxskew = 2;
    paramsOCM.minent = 6;
else
    disp('Configuration not found...')
end

end

