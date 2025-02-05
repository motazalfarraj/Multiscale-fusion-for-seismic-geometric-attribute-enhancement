clc; 
clear all; 
close all; 

addpath(genpath('../../'))
load('SampleVolume')

%% 
close all
CrossInd = 924; 
CrossLine = data{2,1}; 
CrossLine = CrossLine(100:150,100:300); 
CrossLine = (CrossLine-min(CrossLine(:)))/(max(CrossLine(:))-min(CrossLine(:)))-0.5; 
%% 
scales = 4; 
temp  = curvature(CrossLine); 
Curvature = (temp-min(temp(:)))/(max(temp(:))-min(temp(:)))-0.5; 
for i=0:scales-1
   % temp = imresize(CrossLine,size(CrossLine).*[(7/8)^i (1/2)^i]);
    temp = imresize(CrossLine,size(CrossLine).*[1 (1/2)^i]);
    temp2 = curvature(temp); 
    MSCurvatureScale(:,:,i+1) = imresize(temp2,size(CrossLine)); 
    MSCurvatureScaleWieghted(:,:,i+1) = 2^(scales-i+1)*imresize(temp2,size(CrossLine)); 
end 
%%
temp = mean(MSCurvatureScale,3); 
MSCurvature=(temp-min(temp(:)))/(max(temp(:))-min(temp(:)))-0.5; 

% Mean pooling 
temp =  mean(MSCurvatureScaleWieghted,3);


% Median pooling 
%temp =  median(MSCurvatureScaleWieghted,3);


% Signed maximum pooling 
% [temp ind] =  max(abs(MSCurvatureScaleWieghted),[],3);
% 
% for i=1:size(ind,1)
%     for j=1:size(ind,2)
%     temp(i,j) =  temp(i,j).*sign(MSCurvatureScaleWieghted(i,j,ind(i,j)));    
%     end 
% end 


MSCurvatureWieghted=(temp-min(temp(:)))/(max(temp(:))-min(temp(:)))-0.5; 
% Figures 
close all
figure('units','normalized','outerposition',[0 0 1 1])
subplot(221) 
pcolor(CrossLine); 
colormap(redblue(256))
title(['Crossline ',num2str(CrossInd)]);
shading interp
pbaspect([4 1 1])
colorbar

subplot(222) 
pcolor(Curvature); 
colormap(redblue(256))
title(['Signed maximum curvature of crossline ',num2str(CrossInd)]);
shading interp
pbaspect([4 1 1])
colorbar

subplot(223) 
pcolor(MSCurvature); 
colormap(redblue(256))
title(['Multiresolution Signed maximum curvature of crossline ',num2str(CrossInd)]); 
%axis image 
shading interp
pbaspect([4 1 1])
colorbar

subplot(224)
pcolor(MSCurvatureWieghted); 
colormap(redblue(256))
title(['Weighted Multiresolution Signed maximum curvature of crossline ',num2str(CrossInd)]); 
shading interp
pbaspect([4 1 1])
colorbar

% %% Difference 
% figure 
% pcolor(MSCurvature-Curvature); 
% colormap(redblue(256))
% title(['Difference between curvature of crossline ',num2str(CrossInd)]); 
% shading interp
% pbaspect([4 1 1])
% colorbar
% %% 
% figure 
% for i=1:scales-1
% subplot(4,2,i)
% pcolor(MSCurvatureScale(:,:,i+1)); 
% colormap(redblue(256))
% title(['Signed maximum curvature of crossline ',num2str(CrossInd),' (Scale ,',num2str(i+1),')']); 
% shading interp
% pbaspect([4 1 1])
% colorbar
% end 

