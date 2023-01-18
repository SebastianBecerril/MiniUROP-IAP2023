importDir = "C:\Users\sebas\Documents\miniUROPVideos"; %where the function imports the video from
tag = 'DRONEV1_0117_2300'; %descriptive name so you can keep track of runs
expID = 'droneV1'; %defined by you, tells the function what parameters to use
skipChecks = true; %set to false to help with debugging
stackData = false;
autoLocate = true; %set to true to automatically find locations to apply the algorithm
workingDir = "C:\Users\sebas\Documents\miniUROPData"; %where the function saves the data

[uOCM,vOCM,uVar,vVar,tOCM,xOCM,yOCM,infoOCM] = run_vdOCM_newfilter(tag,workingDir,importDir,expID,skipChecks,stackData,autoLocate);

%uOCM is cross-shore velocity
%vOCM is the alongshore velocity
%uVar is the variance of the timestack in the cross-shore
%vVar is the variance of the timestack in the alongshore direction
%tOCM is a vector of the analysis times
%xOCM is the locations of the estimates in the cross-shore
%yOCM is the locations of the estimates in the alongshoreu
%infoOCM saves the analysis parameters (resolution, pixel bar length, etc)

