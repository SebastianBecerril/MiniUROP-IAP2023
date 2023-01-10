function [paramsOCM] = getOCMparams(ID)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if strcmp(ID, 'v00')
    %RSEX2017, RSEX2018
    %import
    imp_format = 'tif';
    imp_imgFreq = 2.5;  %[Hz]
    imp_intvl = 600; %[s]
    
    %grid
    freq = 2.5;     %[Hz]
    X_res = 0.25;   %[m]
    Y_res = 0.25;   %[m]
    X_min = 75;     %[m]
    X_max = 250;    %[m]
    Y_min = 500;
    Y_max = 850;
    
    %stack
    Al_bar = 10;    %[m]
    Cs_bar = 10;    %[m]
    X_gap = 3;      %[m]
    Y_gap = 3;      %[m]
    
    % OCM
    vel_bnd = [-2 2];   %[m/s]
    wndw = 20;    %[s]
    stp = 10;   %[s]
    
elseif strcmp(ID, 'rod13')
    %RODSEX2013
    %import
    paramsOCM.imp_format = 'mp4';
    
    %grid
    paramsOCM.ocm_freq = 2.5;     %[Hz]
    paramsOCM.X_res = 0.2;   %[m]
    paramsOCM.Y_res = 0.2;   %[m]
    paramsOCM.X_min = 75;     %[m]
    paramsOCM.X_max = 250;    %[m]
    paramsOCM.Y_min = 590;
    paramsOCM.Y_max = 1000;
    
    %stack
    paramsOCM.Al_bar = 10;    %[m]
    paramsOCM.Cs_bar = 10;    %[m]
    paramsOCM.X_gap = [];      %[m]
    paramsOCM.Y_gap = [];      %[m]
    
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
    
elseif strcmp(ID,'bot21')
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
%     paramsOCM.Y_min = 430;
%     paramsOCM.Y_max = 850;
    paramsOCM.X_min = 55;     %[m]
    paramsOCM.X_max = 310;    %[m]
    paramsOCM.Y_min = 500;
    paramsOCM.Y_max = 850;
    
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
    
elseif strcmp(ID,'top18')
    %import
    paramsOCM.imp_format = 'tif';
    paramsOCM.imp_freq = 2.5;  %[Hz]
    paramsOCM.imp_intvl = 600; %[s]
    
    %grid
    paramsOCM.ocm_freq = 2.5;     %[Hz]
    paramsOCM.X_res = 0.25;   %[m]
    paramsOCM.Y_res = 0.25;   %[m]
    paramsOCM.X_min = 75;     %[m]
    paramsOCM.X_max = 250;    %[m]
    paramsOCM.Y_min = 500;
    paramsOCM.Y_max = 1000; %FOR TIMEX ONLY, SHOULD BE 850
    
    %stack
    paramsOCM.Al_bar = 10;    %[m]
    paramsOCM.Cs_bar = 10;    %[m]
    paramsOCM.X_gap = 3;      %[m]
    paramsOCM.Y_gap = 3;      %[m]
    
    % OCM
    paramsOCM.vel_bnd = [-2 2];   %[m/s]
    paramsOCM.wndw = 20;    %[s]
    paramsOCM.stp = 10;   %[s]
elseif strcmp(ID,'bot18')
    %import
    paramsOCM.imp_format = 'tif';
    paramsOCM.imp_freq = 2.5;  %[Hz]
    paramsOCM.imp_intvl = 600; %[s]
    
    %grid
    paramsOCM.ocm_freq = 2.5;     %[Hz]
    paramsOCM.X_res = 0.25;   %[m]
    paramsOCM.Y_res = 0.25;   %[m]
    paramsOCM.X_min = 75;     %[m]
    paramsOCM.X_max = 250;    %[m]
    paramsOCM.Y_min = 500;
    paramsOCM.Y_max = 1000; %FOR TIMEX ONLY, SHOULD BE 850
    
    %stack
    paramsOCM.Al_bar = 10;    %[m]
    paramsOCM.Cs_bar = 10;    %[m]
    paramsOCM.X_gap = 3;      %[m]
    paramsOCM.Y_gap = 3;      %[m]
    
    % OCM
    paramsOCM.vel_bnd = [-2 2];   %[m/s]
    paramsOCM.wndw = 20;    %[s]
    paramsOCM.stp = 10;   %[s]
else
    disp('Configuration not found...')
end

end

