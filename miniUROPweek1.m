vidObj = VideoReader("C:\Users\sebas\Downloads\DJI_0441.MP4");
video_frame = read(vidObj,400); %400


gray_frame = rgb2gray(video_frame);
double_frame = double(gray_frame);

height = size(video_frame, 1);
width = size(video_frame, 2);

y_pixel = 1:(width);
x_pixel = 1:(height);
[Y,X] = meshgrid(y_pixel,x_pixel);


ang2 = 171.5;
Y = Y*cosd(ang2)-X*sind(ang2);
X = Y*sind(ang2)+X*cosd(ang2);

offset_x = 2832.21-87.3912 +(95.19/0.018); %+ (104.446/0.002647)
offset_y = 4133.8-16.7108+(575.803/0.018);%610.861/0.002647
X = X + offset_x;
Y = Y+ offset_y;

scale_factor = 0.018; %0.002647
X = X*scale_factor;
Y = Y*scale_factor;

X_old = X;
Y_old = Y;

X = Y_old;
Y = X_old;

pcolor_frame = pcolor(Y, X, double_frame);
set(pcolor_frame, 'EdgeColor', 'none');
daspect([1 1 1]);

min_x = min(X(:));
min_y = min(Y(:));
max_x = max(X(:));
max_y = max(Y(:));
resolution = 0.018;

x_frf = min_x:resolution:max_x;
y_frf = min_y:resolution:min_y;
[X_grid, Y_grid] = meshgrid(x_frf,y_frf);

F = scatteredInterpolant(Y,X,double_frame);
video_frame_grid = F(X_grid,Y_grid);

pcolor(X_grid,Y_grid,video_frame_grid)
set(pcolor_frame, 'EdgeColor', 'none');
daspect([1 1 1]);


 %while hasFrame(vidObj)
   %frame = readFrame(vidObj);
   %imshow(frame)
   %pause(1/vidObj.FrameRate);
%end