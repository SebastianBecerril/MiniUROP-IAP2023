importDir = "C:\Users\sebas\Documents\miniUROPVideos"; %where the function imports the video from
tag = 'DRONEV1_0125_04_old_params'; %descriptive name so you can keep track of runs
expID = 'droneV1'; %defined by you, tells the function what parameters to use
skipChecks = true; %set to false to help with debugging
stackData = false;
autoLocate = false; %set to true to automatically find locations to apply the algorithm
workingDir = "C:\Users\sebas\Documents\miniUROPData"; %where the function saves the data

[uOCM,vOCM,uVar,vVar,tOCM,xOCM,yOCM,infoOCM] = run_vdOCM_newfilter(tag,workingDir,importDir,expID,skipChecks,stackData,autoLocate);

U = mean(uOCM,3); %this is the cross-shore (perpendicular to the shore velocity measured by the PIV algorithm)

V = mean(vOCM,3); %this is the alongshore (parallel to the shore velocity measured by the PIV algorithm)

X = xOCM; %this is the local x-coordinate of the flow velocity

Y = yOCM; %this is the local y-coordinate of the flow velocity

meanU = mean(uOCM,3);

hold on
pcolor(oceanX,oceanY,oceanSum)
shading flat
colormap('gray')


quiver(X,Y,U,V, 1.5, 'filled', "r");
xlabel("Local x coordinate of the flow velocity")
ylabel("Local y coordinate of the flow velocity")
title("Flow Velocities Over Coastal Area")
export_fig fig_DRONEV1_0125_04_old_params.png

%uOCM is cross-shore velocity
%vOCM is the alongshore velocity
%uVar is the variance of the timestack in the cross-shore
%vVar is the variance of the timestack in the alongshore direction
%tOCM is a vector of the analysis times
%xOCM is the locations of the estimates in the cross-shore
%yOCM is the locations of the estimates in the alongshoreu
%infoOCM saves the analysis parameters (resolution, pixel bar length, etc)

