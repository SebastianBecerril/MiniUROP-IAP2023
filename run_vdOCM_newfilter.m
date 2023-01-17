function [uOCM,vOCM,uVar,vVar,tOCM,xOCM,yOCM,infoOCM] = run_vdOCM_newfilter(tag,workingDir,importDir,expID,skipChecks,stackData,autoLocate)
%% SETUP ANALYSIS
clc;    %clear command window
diary(strcat(workingDir,'/diary_OCM_',tag));  %start recording to text file
tic;    %start timer

[infoOCM] = getOCMparams(expID);  %get analysis parameters
infoOCM.tag = tag;
infoOCM.workingDir = workingDir;
infoOCM.importDir = importDir;
infoOCM.expID = expID;

disp('Parameter setup complete!'); toc

if skipChecks == false
    disp('Press any key to continue...');
    pause
end

%% PREPARE IMAGES
imp_source = dir(strcat(infoOCM.importDir, '/*.', infoOCM.imp_format)); %find all videos in source folder

%check for bad files
dot = 1;
while dot < length(imp_source)
    if strcmp(imp_source(dot).name(1:2),'._')
        imp_source(dot) = [];
    end
    dot = dot+1;
end

imp_name = {imp_source.name}';  %cell array of video names
imp_read = strcat({imp_source.folder},'/',{imp_source.name})';  %string of each video location

vd = VideoReader(imp_read{1});

oceanRaw = double(rgb2gray(read(vd,1)));

%start incorporated code
height = size(oceanRaw, 1);
width = size(oceanRaw, 2);

y_pixel = -(1:(height));
x_pixel = 1:(width);
[X_pixel,Y_pixel] = meshgrid(x_pixel,y_pixel);

ang2 = 278.5;
X_rot = X_pixel*cosd(ang2)-Y_pixel*sind(ang2);
Y_rot = X_pixel*sind(ang2)+Y_pixel*cosd(ang2);

offset_x = 2832.21-87.3912 +(95.19/0.018); %+ (104.446/0.002647)
offset_y = 4133.8-16.7108+(575.803/0.018);%610.861/0.002647
X_ro = X_rot + offset_x;
Y_ro = Y_rot + offset_y;

scale_factor = 0.018; %0.002647
X_raw = X_ro*scale_factor;
Y_raw = Y_ro*scale_factor;
%end incorporated code

if skipChecks == false
    %show proposed crop
    figure
    ax = axes;
    hold on
    %plot ocean image
    view = pcolor(X_raw,Y_raw,oceanRaw);
    set(view,'EdgeColor','none');
    colormap('gray')
    set(ax,'DataAspectRatio', [1 1 1]);
    %plot crop box
    plot([infoOCM.X_max infoOCM.X_max infoOCM.X_min infoOCM.X_min infoOCM.X_max],[infoOCM.Y_min infoOCM.Y_max infoOCM.Y_max infoOCM.Y_min infoOCM.Y_min],'r-');
    
    disp('Press any key to continue...');
    pause
end

%start incorporated code
ocean_interp = scatteredInterpolant(X_raw(:),Y_raw(:),oceanRaw(:),'linear','none');
[oceanX, oceanY] = meshgrid(infoOCM.X_min:infoOCM.X_res:infoOCM.X_max,infoOCM.Y_min:infoOCM.Y_res:infoOCM.Y_max);   %define image grid
oceanGrid = ocean_interp(oceanX, oceanY);
%end incorporated code

disp('Image preparation complete!')
toc     %display elapsed time

if skipChecks == false
    disp('Press any key to continue...');
    pause
end

%% PREP LOCATIONS
Cs_barPixel = infoOCM.Cs_bar/infoOCM.X_res;
Al_barPixel = infoOCM.Al_bar/infoOCM.Y_res;

sc = 0;  %start counter
if autoLocate == true
    start_X = (infoOCM.X_min:infoOCM.X_gap:(infoOCM.X_max-infoOCM.Cs_bar/2));
    start_Y = (infoOCM.Y_min:infoOCM.Y_gap:(infoOCM.Y_max-infoOCM.Al_bar/2));
    [xOCM,yOCM] = meshgrid(start_X,start_Y);
    
    stack_Xstart = round((((start_X)-infoOCM.X_min)/infoOCM.X_res)+1);
    stack_Ystart = round((((start_Y)-infoOCM.Y_min)/infoOCM.Y_res)+1);
elseif autoLocate == false
    %do something else
end

%fix indexing outside array issues
stack_Xstart = stack_Xstart(stack_Xstart > Cs_barPixel/2+1 & stack_Xstart < size(oceanGrid,2)-Cs_barPixel/2);
stack_Ystart = stack_Ystart(stack_Ystart > Al_barPixel/2+1 & stack_Ystart < size(oceanGrid,1)-Al_barPixel/2);

%filter locations to exclude areas with NaNs
for w = stack_Xstart
    for p = stack_Ystart
        %define pixel bars
        stackBarAl = oceanGrid((p-(Al_barPixel/2)):(p+(Al_barPixel/2)),w);
        stackBarCs = oceanGrid(p,(w-(Cs_barPixel/2)):(w+(Cs_barPixel/2)));
        %check to see if it has NaNs
        if sum(isnan(stackBarAl)) == 0 && sum(isnan(stackBarCs)) == 0
            sc = sc+1;
            %set pixel location
            sX(sc,1) = w;
            sY(sc,1) = p;
            %set FRF coordinate location
            xy_OCM(sc,1) = oceanX(p,w);
            xy_OCM(sc,2) = oceanY(p,w);
        end
    end
end

%% IMPORT AND ANALYZE
uOCM = [];
vOCM = [];

uVar = [];
vVar = [];
tOCM = [];
%load and grid images into ocean array
for j = 1:length(imp_read)
    if stackData == false && isfile(strcat(infoOCM.workingDir,'/rawData_OCM_',infoOCM.tag,'_',imp_name{j}(1:end-4),'.mat'))
        %still needs work, doesn't need to load in data if analysis is already
        %completed... need to take up a level to link with analyze_OCM
        disp('Loading previously saved data...')
        load(strcat(infoOCM.workingDir,'/rawData_OCM_',infoOCM.tag,'_',imp_name{j}(1:end-4),'.mat'),'ocean','oceanSum','oceanX','oceanY');
    else
        vd = VideoReader(imp_read{j});
        vdHz = vd.FrameRate;
        vdDr = vd.Duration;
        
        fprintf('Frame rate is %0.2f and sample rate is %0.2f \n',vdHz,infoOCM.ocm_freq);
        if skipChecks == false
            disp('Press any key to continue...');
            pause
        end
        
        samp = round(vdHz/infoOCM.ocm_freq);
        frms = 1:samp:vd.NumFrames;
        M = length(frms);

        %load in each image and interpolate to grid
        ocean = NaN(size(oceanGrid,1),size(oceanGrid,2),M); %preallocate ocean array
        for ii = 1:M %loop through image set
            oceanRaw = double(rgb2gray(read(vd,frms(ii))));    %read in image
            %start incorporated code
            ocean_interp.Values = oceanRaw;
            ocean(:,:,ii) = ocean_interp(oceanX, oceanY);
            %end incorporated code
        end
        %sum images into composite
        oceanSum = sum(ocean,3);
        
        %save results
        save(strcat(infoOCM.workingDir,'/timex_OCM_',infoOCM.tag,'_',imp_name{j}(1:end-4),'.mat'),'oceanSum','oceanX','oceanY')
    end
    
    disp(strcat('Image stack complete! (',imp_name{j}(1:end-4),')'))
    toc     %display elapsed time
    
    %create image stacks
    stkCs_cell = cell(sc,1);
    stkAl_cell = cell(sc,1);
    for h = 1:sc
        stkCs_cell{h} = squeeze(ocean(sY(h),(sX(h)-(Cs_barPixel/2)):(sX(h)+(Cs_barPixel/2)),:))';
        stkAl_cell{h} = squeeze(ocean((sY(h)-(Al_barPixel/2)):(sY(h)+(Al_barPixel/2)),sX(h),:))';
    end
    
    %% DEFINE ANALYSIS PARAMETERS
    %window/step sizes
    Twin = infoOCM.wndw*infoOCM.ocm_freq;
    Tstep = infoOCM.stp*infoOCM.ocm_freq;
    
    N_Al = size(stkAl_cell{1},2);
    N_Cs = size(stkCs_cell{1},2);
    
    L_Al = infoOCM.Y_res*N_Al;
    L_Cs = infoOCM.X_res*N_Cs;
    
    taper_Al = bartlett(Twin)*bartlett(N_Al)';
    taper_Cs = bartlett(Twin)*bartlett(N_Cs)';
    
    dv = 0.05;
    v = min(infoOCM.vel_bnd):dv:max(infoOCM.vel_bnd);
    
    % make k vector
    %Alongshore
    if rem(N_Al,2) == 0
        k_Al = [((-N_Al/2)):((N_Al/2)-1)]/L_Al;
    else
        k_Al = [(-(N_Al-1)/2):((N_Al-1)/2)]/L_Al;
    end
    gk_Al = find((k_Al>0)&(k_Al<1/(2*infoOCM.Y_res))); %find + k's
    k_Al = k_Al(gk_Al);
    %Cross-shore
    if rem(N_Cs,2) == 0
        k_Cs = [((-N_Cs/2)):((N_Cs/2)-1)]/L_Cs;
    else
        k_Cs = [(-(N_Cs-1)/2):((N_Cs-1)/2)]/L_Cs;
    end
    gk_Cs = find((k_Cs>0)&(k_Cs<1/(2*infoOCM.X_res))); %find + k's
    k_Cs = k_Cs(gk_Cs);
    
    % make f vector
    if rem(Twin,2) == 0
        f = [((Twin/2)):-1:(-(Twin/2-1))]'/infoOCM.wndw;
    else
        f = [((Twin-1)/2):-1:(-(Twin-1)/2)]'/infoOCM.wndw;
    end
    gf = find((abs(f)~=0)&(abs(f)<1/(2/infoOCM.ocm_freq))); %find +/- f's
    f = f(gf);
    
    freq_bnd = [inf 0 min(k_Al)*2 2];
    
    K_Al = repmat(k_Al,length(f),1);
    F_Al = repmat(f,1,length(k_Al));
    FKind_Al = find(abs(F_Al)<freq_bnd(1) &  abs(F_Al)>freq_bnd(2) & abs(K_Al)>freq_bnd(3) & abs(K_Al)<freq_bnd(4));
    Smask_Al = nan*ones(size(K_Al));
    Smask_Al(FKind_Al) = 1;
    
    K_Cs = repmat(k_Cs,length(f),1);
    F_Cs = repmat(f,1,length(k_Cs));
    FKind_Cs = find(abs(F_Cs)<freq_bnd(1) &  abs(F_Cs)>freq_bnd(2) & abs(K_Cs)>freq_bnd(3) & abs(K_Cs)<freq_bnd(4));
    Smask_Cs = nan*ones(size(K_Cs));
    Smask_Cs(FKind_Cs) = 1;
    
    Nb = floor((size(stkCs_cell{1},1)-(Twin-Tstep))/Tstep); %blocks
    
    %finalize time    
    tOCM_i = seconds((infoOCM.stp:infoOCM.stp:(infoOCM.stp*Nb)));
    
    
    %% GENERATE RESULTS
    minvar = infoOCM.minvar;
    maxskew = infoOCM.maxskew;
    minent = infoOCM.minent;
    
    v_OCM_i = NaN(sc,Nb);
    u_OCM_i = NaN(sc,Nb);
    
    var_v_i = NaN(sc,Nb);
    var_u_i = NaN(sc,Nb);
    parfor i = 1:sc
        [v_OCM_i(i,:), var_v_i(i,:)] = calc_OCM_newfilter(stkAl_cell{i},Tstep,Twin,Nb,taper_Al,Smask_Al,v,k_Al,f,gf,gk_Al,maxskew,minent);
        [u_OCM_i(i,:), var_u_i(i,:)] = calc_OCM_newfilter(stkCs_cell{i},Tstep,Twin,Nb,taper_Cs,Smask_Cs,v,k_Cs,f,gf,gk_Cs,maxskew,minent);

    end
    
    %% COMBINE RESULTS
    uOCM_i = NaN(length(pivY),length(pivX),Nb);
    vOCM_i = NaN(length(pivY),length(pivX),Nb);
    
    vVar_i = NaN(length(pivY),length(pivX),Nb);
    uVar_i = NaN(length(pivY),length(pivX),Nb);
    for i = 1:length(pivY)
        for h = 1:length(pivX)
            for k = 1:size(xy_OCM,1)
                if abs(xOCM(i,h)-xy_OCM(k,1)) < 0.1 && abs(yOCM(i,h)-xy_OCM(k,2)) < 0.1
                    uOCM_i(i,h,:) = u_OCM_i(k,:);
                    vOCM_i(i,h,:) = v_OCM_i(k,:);
                    vVar_i(i,h,:) = var_v_i(k,:);
                    uVar_i(i,h,:) = var_u_i(k,:);
                end
            end
        end
    end
    
    uOCM = cat(3,uOCM,uOCM_i);
    vOCM = cat(3,vOCM,vOCM_i);
    
    uVar = cat(3,uVar,uVar_i);
    vVar = cat(3,vVar,vVar_i);

    tOCM = cat(2,tOCM,tOCM_i);
    
    disp(strcat('OCM analysis complete! (',imp_name{j}(1:end-4),')'))
    toc     %display elapsed time
       
end

save(strcat(workingDir,'/results_OCM_',infoOCM.tag,'.mat'),...
    'uOCM','vOCM','tOCM','xOCM','yOCM','infoOCM',...
    'uVar','vVar');


diary off   %end recording to text file
end