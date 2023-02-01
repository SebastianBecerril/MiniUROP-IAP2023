% Loading optimized parameter data with autoLocate off
load C:\Users\sebas\Documents\miniUROPData\results_OCM_DRONEV1_0125_03_new_params.mat
load C:\Users\sebas\Documents\miniUROPData\timex_OCM_DRONEV1_0125_03_new_params_DJI_0441.mat

U_optimized = uOCM; %this is the cross-shore (perpendicular to the shore velocity measured by the PIV algorithm)
V_optimized = vOCM; %this is the alongshore (parallel to the shore velocity measured by the PIV algorithm)
X_optimized = xOCM; %this is the local x-coordinate of the flow velocity
Y_optimized = yOCM; %this is the local y-coordinate of the flow velocity
time_optimized = tOCM;

%Load original parameters
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

i1=13;%y=616.2
j1=4; %x=106.4
i2=12;%y=613
j2=4;%x=106.4
i3=13;%y=616.2
j3=3;%x=103.2
i4=12;%y=613
j4=3;%x=103.2
uOCM50_opt = squeeze(mean(cat(1,U_optimized(i1,j1,:),U_optimized(i2,j2,:),U_optimized(i3,j3,:),U_optimized(i4,j4,:)),1,'omitnan'));
vOCM50_opt = squeeze(mean(cat(1,V_optimized(i1,j1,:),V_optimized(i2,j2,:),V_optimized(i3,j3,:),V_optimized(i4,j4,:)),1,'omitnan'));

uOCM50_or = squeeze(mean(cat(1,U_original(i1,j1,:),U_original(i2,j2,:),U_original(i3,j3,:),U_original(i4,j4,:)),1,'omitnan'));
vOCM50_or = squeeze(mean(cat(1,V_original(i1,j1,:),V_original(i2,j2,:),V_original(i3,j3,:),V_original(i4,j4,:)),1,'omitnan'));

uOCM50_cam = squeeze(mean(cat(1,U_camera(i1,j1,:),U_camera(i2,j2,:),U_camera(i3,j3,:),U_camera(i4,j4,:)),1,'omitnan'));
vOCM50_cam = squeeze(mean(cat(1,V_camera(i1,j1,:),V_camera(i2,j2,:),V_camera(i3,j3,:),V_camera(i4,j4,:)),1,'omitnan'));


i1=13;%y=616.2
j1=9; %x=122.4
i2=12;%y=613
j2=9;%x=122.4
i3=13;%y=616.2
j3=10;%x=125.6
i4=12;%y=613
j4=10;%x=125.6
uOCM60_opt = squeeze(mean(cat(1,U_optimized(i1,j1,:),U_optimized(i2,j2,:),U_optimized(i3,j3,:),U_optimized(i4,j4,:)),1,'omitnan'));
vOCM60_opt = squeeze(mean(cat(1,V_optimized(i1,j1,:),V_optimized(i2,j2,:),V_optimized(i3,j3,:),V_optimized(i4,j4,:)),1,'omitnan'));

uOCM60_or = squeeze(mean(cat(1,U_original(i1,j1,:),U_original(i2,j2,:),U_original(i3,j3,:),U_original(i4,j4,:)),1,'omitnan'));
vOCM60_or = squeeze(mean(cat(1,V_original(i1,j1,:),V_original(i2,j2,:),V_original(i3,j3,:),V_original(i4,j4,:)),1,'omitnan'));

uOCM60_cam = squeeze(mean(cat(1,U_camera(i1,j1,:),U_camera(i2,j2,:),U_camera(i3,j3,:),U_camera(i4,j4,:)),1,'omitnan'));
vOCM60_cam = squeeze(mean(cat(1,V_camera(i1,j1,:),V_camera(i2,j2,:),V_camera(i3,j3,:),V_camera(i4,j4,:)),1,'omitnan'));

i1=13;%y=616.2
j1=12; %x=132
i2=12;%y=613
j2=12;%x=132
i3=13;%y=616.2
j3=13;%x=135.2
i4=12;%y=613
j4=13;%x=135.2
uOCM70_opt = squeeze(mean(cat(1,U_optimized(i1,j1,:),U_optimized(i2,j2,:),U_optimized(i3,j3,:),U_optimized(i4,j4,:)),1,'omitnan'));
vOCM70_opt = squeeze(mean(cat(1,V_optimized(i1,j1,:),V_optimized(i2,j2,:),V_optimized(i3,j3,:),V_optimized(i4,j4,:)),1,'omitnan'));

uOCM70_or = squeeze(mean(cat(1,U_original(i1,j1,:),U_original(i2,j2,:),U_original(i3,j3,:),U_original(i4,j4,:)),1,'omitnan'));
vOCM70_or = squeeze(mean(cat(1,V_original(i1,j1,:),V_original(i2,j2,:),V_original(i3,j3,:),V_original(i4,j4,:)),1,'omitnan'));

uOCM70_cam = squeeze(mean(cat(1,U_camera(i1,j1,:),U_camera(i2,j2,:),U_camera(i3,j3,:),U_camera(i4,j4,:)),1,'omitnan'));
vOCM70_cam = squeeze(mean(cat(1,V_camera(i1,j1,:),V_camera(i2,j2,:),V_camera(i3,j3,:),V_camera(i4,j4,:)),1,'omitnan'));

x50 = 105; 
y50 = 615;

x60 = 123; 
y60 = 615;

x70 = 135; 
y70 = 615;

figure
tl = tiledlayout('flow');
nexttile
hold on
plot(time_original, uOCM50_or,'r')
plot(time_optimized, uOCM50_opt,'g')
plot(time_camera, uOCM50_cam,'b')
plot(t_adv, u50,'m')
hold off
title('In Situ Sensor 50 Timeseries - Cross Shore')
xlabel("Time (Hours:Mins)")
ylabel("Flow Velocity (m/s)")
nexttile
hold on 
plot(time_original, vOCM50_or,'r')
plot(time_optimized, vOCM50_opt,'g')
plot(time_camera, vOCM50_cam,'b')
plot(t_adv, v50,'m')
hold off
title('In Situ Sensor 50 Timeseries - Along Shore')
xlabel("Time (Hours:Mins)")
ylabel("Flow Velocity (m/s)")

leg = legend('Original', 'Optimized', 'Camera', 'In Situ', 'Orientation', 'Horizontal');
leg.Layout.Tile = 'north';
export_fig fig_timeserierss50.png


figure
tl = tiledlayout('flow');
nexttile
hold on
plot(time_original, uOCM60_or,'r')
plot(time_optimized, uOCM60_opt,'g')
plot(time_camera, uOCM60_cam,'b')
plot(t_adv, u60,'m')
hold off
title('In Situ Sensor 60 Timeseries - Cross Shore')
xlabel("Time (Hours:Mins)")
ylabel("Flow Velocity (m/s)")
nexttile
hold on 
plot(time_original, vOCM60_or,'r')
plot(time_optimized, vOCM60_opt,'g')
plot(time_camera, vOCM60_cam,'b')
plot(t_adv, v60,'m')
hold off
title('In Situ Sensor 60 Timeseries - Along Shore')
xlabel("Time (Hours:Mins)")
ylabel("Flow Velocity (m/s)")

leg = legend('Original', 'Optimized', 'Camera', 'In Situ', 'Orientation', 'Horizontal');
leg.Layout.Tile = 'north';
export_fig fig_timeserierss60.png

figure
tl = tiledlayout('flow');
nexttile
hold on
plot(time_original, uOCM70_or,'r')
plot(time_optimized, uOCM70_opt,'g')
plot(time_camera, uOCM70_cam,'b')
plot(t_adv, u70,'m')
hold off
title('In Situ Sensor 70 Timeseries - Cross Shore')
xlabel("Time (Hours:Mins)")
ylabel("Flow Velocity (m/s)")
nexttile
hold on 
plot(time_original, vOCM70_or,'r')
plot(time_optimized, vOCM70_opt,'g')
plot(time_camera, vOCM70_cam,'b')
plot(t_adv, v70,'m')
hold off
title('In Situ Sensor 70 Timeseries - Along Shore')
xlabel("Time (Hours:Mins)")
ylabel("Flow Velocity (m/s)")

leg = legend('Original', 'Optimized', 'Camera', 'In Situ', 'Orientation', 'Horizontal');
leg.Layout.Tile = 'north';
export_fig fig_timeserierss70.png




