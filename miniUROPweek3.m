% Loading optimized parameter data with autoLocate off
load C:\Users\sebas\Documents\miniUROPData\results_OCM_DRONEV1_0125_03_new_params.mat
load C:\Users\sebas\Documents\miniUROPData\timex_OCM_DRONEV1_0125_03_new_params_DJI_0441.mat

U_optimized = uOCM; %this is the cross-shore (perpendicular to the shore velocity measured by the PIV algorithm)
V_optimized = vOCM; %this is the alongshore (parallel to the shore velocity measured by the PIV algorithm)
X_optimized = xOCM; %this is the local x-coordinate of the flow velocity
Y_optimized = yOCM; %this is the local y-coordinate of the flow velocity
time_optimized = tOCM;

% Loading initial parameter data with autoLocate off
load C:\Users\sebas\Documents\miniUROPData\results_OCM_DRONEV1_0125_04_old_params.mat
load C:\Users\sebas\Documents\miniUROPData\timex_OCM_DRONEV1_0125_04_old_params_DJI_0441.mat

U_original = uOCM; %this is the cross-shore (perpendicular to the shore velocity measured by the PIV algorithm)
V_original = vOCM; %this is the alongshore (parallel to the shore velocity measured by the PIV algorithm)
X_original = xOCM; %this is the local x-coordinate of the flow velocity
Y_original = yOCM; %this is the local y-coordinate of the flow velocity
time_original = tOCM;

% Loading fixed camera data
load C:\Users\sebas\Downloads\results_OCM_fixedcameras_0910_0916thru0921.mat

U_camera = uOCM; %this is the cross-shore (perpendicular to the shore velocity measured by the PIV algorithm)
V_camera = vOCM; %this is the alongshore (parallel to the shore velocity measured by the PIV algorithm)
X_camera = xOCM; %this is the local x-coordinate of the flow velocity
Y_camera = yOCM; %this is the local y-coordinate of the flow velocity
time_camera = tOCM;

% Loading in situ sensor data
load C:\Users\sebas\Downloads\insitu_swash_0910_0916thru0921.mat
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


%PLotting smoothed data
figure
hold on 
pcolor(oceanX,oceanY,oceanSum)
shading flat
colormap('gray')
quiver(X_original, Y_original, u_or, v_or, 'off','filled', 'r')
quiver(X_camera, Y_camera, u_cam, v_cam, 'off','filled', 'b')
quiver(X_optimized, Y_optimized, u_opt, v_opt, 'off','filled', 'g')
quiver(x50,y50,100,100,'off','filled', 'm')
quiver(x50,y50,mean(u50,'omitnan'),mean(v50,'omitnan'),'off','filled', 'm')
quiver(x60,y60,mean(u60,'omitnan'),mean(v60,'omitnan'),'off','filled', 'm')
quiver(x70,y70,mean(u70,'omitnan'),mean(v70,'omitnan'),'off','filled', 'm')
daspect([1 1 1]);
xlabel("Local x coordinate of the flow velocity")
ylabel("Local y coordinate of the flow velocity")
title('Comparison of smoothed current velocity data from different mediums')
legend('','Original','Camera', 'Optimized', 'Sensor')
export_fig fig_smoothed_data_comparison.png

%PLotting unsmoothed data
figure
hold on 
pcolor(oceanX,oceanY,oceanSum)
shading flat
colormap('gray')
quiver(X_original, Y_original, uOCMm_or, vOCMm_or, 1.5,'filled', 'r')
quiver(X_camera, Y_camera, uOCMm_cam, vOCMm_cam, 1.5,'filled', 'b')
quiver(X_optimized, Y_optimized, uOCMm_opt, vOCMm_opt,1.5, 'filled', 'g')
quiver(x50,y50,mean(u50,'omitnan'),mean(v50,'omitnan'),'off','filled', 'm')
quiver(x60,y60,mean(u60,'omitnan'),mean(v60,'omitnan'),1.5,'filled', 'm')
quiver(x70,y70,mean(u70,'omitnan'),mean(v70,'omitnan'),1.5,'filled', 'm')
daspect([1 1 1]);
xlabel("Local x coordinate of the flow velocity")
ylabel("Local y coordinate of the flow velocity")
title('Comparison of unsmoothed current velocity data from different mediums')
legend('','Original','Camera', 'Optimized', 'Sensor')
export_fig fig_unsmoothed_data_comparison.png
