load C:\Users\sebas\Documents\miniUROPData\results_OCM_DRONEV1_0119_09.mat
load C:\Users\sebas\Documents\miniUROPData\timex_OCM_DRONEV1_0119_09_DJI_0441.mat
range = 1:1:199;
v = VideoWriter("C:\Users\sebas\Documents\miniUROPVideos\vectorVideo.avi");
vidObj = VideoReader("C:\Users\sebas\Documents\miniUROPVideos\DJI_0441.MP4");
open(v);
i=0;

for i = 1:length(range) %iterate through the number of estimates in time (3rd dimension of the estimate matrix)
    hold on
    video_frame = read(vidObj,i*2);
    im(i)=image(video_frame);
    pcolor(oceanX,oceanY,oceanSum)

    shading flat
    colormap('gray')

    quiver(xOCM,yOCM,uOCM(:,:,i),vOCM(:,:,i), 1.5, "r") %plot the vectors for each estimate
    i = i+1;
    frame = getframe(gcf);
    clf();
    writeVideo(v, frame);
end

close(v)

 