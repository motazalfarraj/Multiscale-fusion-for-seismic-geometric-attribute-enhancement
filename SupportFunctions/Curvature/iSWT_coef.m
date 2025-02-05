function [img] = iSWT_coef(C,scales)
%this function returns the inverse stationary wavelet for the input
%coefficients (C). C should be a cell of size 4*scales 
% INPUTS: ================================================
% Img: input image 
% Scales: Number of decomposition scales 

% OUTPUT: ================================================
% C{j}{1}: Approximation coefficients at scale j 
% C{j}{2}: Horizontal coefficients at scale j
% C{j}{3}: Vertical coefficients at scale j
% C{j}{4}: Diagonal coefficients at scale j

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daubechies: 'db1' or 'haar', 'db2', ... ,'db45'
%   Coiflets  : 'coif1', ... ,  'coif5'
%	Fejer-Korovkin: 'fk4', 'fk6', 'fk8', 'fk14', 'fk18', 'fk22'
%   Symlets   : 'sym2' , ... ,  'sym8', ... ,'sym45'
%   Discrete Meyer wavelet: 'dmey'
%   Biorthogonal:
%       'bior1.1', 'bior1.3' , 'bior1.5'
%       'bior2.2', 'bior2.4' , 'bior2.6', 'bior2.8'
%       'bior3.1', 'bior3.3' , 'bior3.5', 'bior3.7'
%       'bior3.9', 'bior4.4' , 'bior5.5', 'bior6.8'.
%   Reverse Biorthogonal: 
%       'rbio1.1', 'rbio1.3' , 'rbio1.5'
%       'rbio2.2', 'rbio2.4' , 'rbio2.6', 'rbio2.8'
%       'rbio3.1', 'rbio3.3' , 'rbio3.5', 'rbio3.7'
%       'rbio3.9', 'rbio4.4' , 'rbio5.5', 'rbio6.8'.
%       
% ===================================

%% 
ImgDim = size(C{1}{1}); 
scales = size(C,2);

if log2(ImgDim(1))~=ceil(log2(ImgDim(1)))  
    for i=1:scales
        for j=1:4 
        C{i}{j} = wextend('ar','sym',C{i}{j},2^(ceil(log2(ImgDim(1))))-ImgDim(1),'d');
        end 
    end 
end 

if log2(ImgDim(2))~=ceil(log2(ImgDim(2)))  
    for i=1:scales
        for j=1:4 
        C{i}{j} = wextend('ac','sym',C{i}{j},2^(ceil(log2(ImgDim(2))))-ImgDim(2),'r');
        end 
    end 
end 

MaxPossibleScale = ceil(log2(min(ImgDim))); 
if scales > MaxPossibleScale
    error('Maximum possible number of scales is %d\n',MaxPossibleScale);
end 

wname = 'haar'; 

temp = []; 
for j=2:4
    for i = 1:size(C,2) 
        temp(:,:,end+1) = C{i}{j}; 
    end 
end 
temp(:,:,end+1) = C{scales}{1}; 
temp(:,:,1) = []; 
img = iswt2(temp,'haar');
img = img(1:ImgDim(1),1:ImgDim(2)); 
end