clc; 
clear all; 
close all; 

%% 
load('SampleVolume')
addpath(genpath('../Common Codes')); 
InterpolationRatio = [4 1]*2; 
TimeRes = 462;
NTrace = 951;
NInline = 601;
%Data1 = Data(:, 1:951*601); % Since seismic sections after Inline 601 are not incomplete
Data2 = seis2D23D(Data, TimeRes, NTrace, NInline);

%% 
close all
TimeInterval = [0.95 1.15];
CrossInd = 625;
InInd = 150:450; 
TimeInd = floor(TimeInterval(1)*1000/4+1):ceil(TimeInterval(2)*1000/4+1);
TimeInterval = linspace(TimeInterval(1),TimeInterval(2),length(TimeInd)); 
CrossLine = squeeze(Data2(TimeInd,CrossInd-300+1,InInd-100+1));
CrossLine = (CrossLine-min(CrossLine(:)))/(max(CrossLine(:))-min(CrossLine(:)))-0.5; 
scales = 3; 
C = SWT_coef(CrossLine,scales); 

SWT_Curvature = C; 
for i=1:scales 
    for j=1:2
    temp = CurveDi(C{i}{j}); 
    SWT_Curvature{i}{j} = temp;%(temp-min(temp(:)))/(max(temp(:))-min(temp(:)))-0.5;
    clear temp; 
    end 
end 

temp = CurveDi(CrossLine); 
Curvature = (temp-min(temp(:)))/(max(temp(:))-min(temp(:)))-0.5; 
temp; 

CrossLine_Interpolated = imresize(CrossLine,InterpolationRatio.*size(CrossLine));
Curvature_Interpolated = imresize(Curvature,InterpolationRatio.*size(CrossLine));

titles = [{'Approimation'},{'Horizontal'},{'Vertical'},{'Diagonal'}]; 


%% SWT-Based curvarure 
clear temp; 
scales = 3; 
temp = iSWT_coef(SWT_Curvature);
SWT_Curve = (temp-min(temp(:)))/(max(temp(:))-min(temp(:)))-0.5; 

SWT_Curve =SWT_Curve.*(abs(SWT_Curve)>=abs(Curvature)) + Curvature.*(abs(SWT_Curve)<abs(Curvature));
SWT_Curve_Interpolated = imresize(SWT_Curve,InterpolationRatio.*size(SWT_Curve));

%% Figures 

%% Original and curvature 
figure
imagesc(CrossLine_Interpolated); 
colormap(redblue(256))
axis image 
title(['Interpolated Crossline ',num2str(CrossInd)]); 
figure
imagesc(Curvature_Interpolated); 
colormap(redblue(256))
title(['Signed maximum curvature of crossline ',num2str(CrossInd)]); 
axis image 

%% SWT-based curvature 
figure 
imagesc(SWT_Curve_Interpolated); 
colormap(redblue(256))
title(['SWT-based Signed maximum curvature of crossline ',num2str(CrossInd)]); 
axis image 

%% Difference 
figure 
imagesc(SWT_Curve_Interpolated+Curvature_Interpolated); 
colormap(redblue(256))
title(['Difference of the two curvatures crossline ',num2str(CrossInd)]); 
axis image 


%% SWT
% close all; 
% for i=1:scales
% figure
% for j=1:4
% subplot(2,2,j) 
% %temp = C{i}{j};
% temp = imresize(C{i}{j},InterpolationRatio.*size(C{i}{j}));
% imagesc(temp); 
% colormap(redblue(256))
% axis image 
% title(titles{j})
% end 
% suptitle(['SWT at Scale ',num2str(i)]); 
% end 

%% SWT curvature 
% close all; 
% for i=1:scales
% figure
% for j=1:4
% subplot(2,2,j)
% temp = SWT_Curvature{i}{j}; 
% temp = imresize(temp,InterpolationRatio.*size(C{i}{j}));
% imagesc(temp); 
% colormap(redblue(256))
% axis image 
% title(titles{j})
% end 
% suptitle(['Curvature at Scale ',num2str(i)]); 
% end 

