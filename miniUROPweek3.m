% Loading optimized parameter data with autoLocate off
load('/Users/ciara/Dropbox (MIT)/MIT-WHOI/mini UROP/Data/results_OCM_DRONEV1_0125_03_new_params.mat')
load('/Users/ciara/Dropbox (MIT)/MIT-WHOI/mini UROP/Data/timex_OCM_DRONEV1_0125_03_new_params_DJI_0441.mat')

U_optimized = uOCM; %this is the cross-shore (perpendicular to the shore velocity measured by the PIV algorithm)
V_optimized = vOCM; %this is the alongshore (parallel to the shore velocity measured by the PIV algorithm)
X_optimized = xOCM; %this is the local x-coordinate of the flow velocity
Y_optimized = yOCM; %this is the local y-coordinate of the flow velocity
time_optimized = tOCM;

% Loading initial parameter data with autoLocate off
load('/Users/ciara/Dropbox (MIT)/MIT-WHOI/mini UROP/Data/results_OCM_DRONEV1_0125_04_old_params.mat')
load('/Users/ciara/Dropbox (MIT)/MIT-WHOI/mini UROP/Data/timex_OCM_DRONEV1_0125_04_old_params_DJI_0441.mat')

U_original = uOCM; %this is the cross-shore (perpendicular to the shore velocity measured by the PIV algorithm)
V_original = vOCM; %this is the alongshore (parallel to the shore velocity measured by the PIV algorithm)
X_original = xOCM; %this is the local x-coordinate of the flow velocity
Y_original = yOCM; %this is the local y-coordinate of the flow velocity
time_original = tOCM;

% Loading fixed camera data
load('/Users/ciara/Dropbox (MIT)/MIT-WHOI/mini UROP/Data/results_OCM_fixedcameras_0910_0916thru0921.mat')

U_camera = uOCM; %this is the cross-shore (perpendicular to the shore velocity measured by the PIV algorithm)
V_camera = vOCM; %this is the alongshore (parallel to the shore velocity measured by the PIV algorithm)
X_camera = xOCM; %this is the local x-coordinate of the flow velocity
Y_camera = yOCM; %this is the local y-coordinate of the flow velocity
time_camera = tOCM;

% Loading in situ sensor data
load('/Users/ciara/Dropbox (MIT)/MIT-WHOI/mini UROP/Data/insitu_swash_0910_0916thru0921.mat')
u50(u50 == 0 ) = NaN;
v50(v50 == 0 ) = NaN;
u60(u60 == 0 ) = NaN;
v60(v60 == 0 ) = NaN;
u70(u70 == 0 ) = NaN;
v70(v70 == 0 ) = NaN;


x50 = 105; 
y50 = 615;
x60 = 123; 
y60 = 615;
x70 = 135; 
y70 = 615;

% Average in time and spatially smooth resulting data from all three runs.
uOCMm_or = mean(U_original,3,'omitnan');
vOCMm_or = mean(V_original,3,'omitnan');
smth_win = 3;
smth = ones(smth_win,smth_win)/(smth_win)^2;
u_or = conv2(uOCMm_or,smth,'same');
v_or = conv2(vOCMm_or,smth,'same');

uOCMm_cam = mean(U_camera,3,'omitnan');
vOCMm_cam = mean(V_camera,3,'omitnan');
u_cam = conv2(uOCMm_cam,smth,'same');
v_cam = conv2(vOCMm_cam,smth,'same');

uOCMm_opt = mean(U_optimized,3,'omitnan');
vOCMm_opt = mean(V_optimized,3,'omitnan');
u_opt = conv2(uOCMm_opt,smth,'same');
v_opt = conv2(vOCMm_opt,smth,'same');


xs = [x50; x60; x70];
ys = [y50; y60; y70];
us = [mean(u50,'omitnan'); mean(u60,'omitnan'); mean(u70,'omitnan')];
vs = [mean(v50,'omitnan'); mean(v60,'omitnan'); mean(v70,'omitnan')];
sf = 10;

%recommended plot #1
figure
hold on 
pcolor(oceanX,oceanY,oceanSum)
shading flat
colormap('gray')
ax = gca;
quiver(X_camera, Y_camera, u_cam*sf, v_cam*sf,'off','Color','blue')
quiver(X_original, Y_original, u_or*sf, v_or*sf,'off','Color','red')
quiver(xs,ys,us*sf,vs*sf,'off','Color','magenta','MaxHeadSize',0.07)
daspect([1 1 1]);
xlabel("Cross-shore coordinate (m)")
ylabel("Alongshore coordinate (m)")
title('5-min Mean Remotely Sensed and In Situ Flows in the Swash Zone')
legend('','Fixed camera','Drone camera','In situ sensor')
%export_fig fig_smoothed_data_comparison.png

%recommended plot #2
figure
hold on 
pcolor(oceanX,oceanY,oceanSum)
shading flat
colormap('gray')
quiver(X_optimized, Y_optimized, uOCMm_opt*sf, vOCMm_opt*sf,'off','Color', 'green')
quiver(X_original, Y_original, u_or*sf, v_or*sf,'off','Color','red')
quiver(xs,ys,us*sf,vs*sf,'off','Color','magenta','MaxHeadSize',0.07)
daspect([1 1 1]);
xlabel("Cross-shore coordinate (m)")
ylabel("Alongshore coordinate (m)")
title('Comparison of Varied Algorithm Parameters in the Swash Zone')
legend('','High resolution parameters','Low resolution parameters','In situ sensor')
%export_fig fig_unsmoothed_data_comparison.png
