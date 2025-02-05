function [seiscolor] = getSeisColorMap(colorname, flipped)
% Return the common color map used for seismic data visualization
% [seiscolor] = getSeisColorMap(colorname, flipped)
% Input:
%       colorname: name of the color map, include,
%                  'Red_White_Blue',
%                  'Whilte_Gray_Black'
%                  'Black_Red', 'Black_Green', 'Black_Blue'
%                  'White_Black_Red', 'White_Black_Green', 'White_Black_Blue'
%                  'White_Red_Black', 'White_Green_Black', 'White_Blue_Black'
%       flipped: option for flipping the color map
% Output:
%       seiscolor: customed color map for data visualization (2001x3 matrix)

if nargin < 1
    colorname = 'Red_White_Blue';
end
if nargin < 2
    flipped = 0;
end

% Red_White_Blue
col = [ones(1, 1001), linspace(0.999, 0.0, 1000)];
Red_White_Blue = col';
col = [linspace(0.0, 0.999, 1000), 1.0, linspace(0.999, 0.0, 1000)];
Red_White_Blue = [Red_White_Blue, col'];
col = [linspace(0.0, 0.999, 1000), ones(1, 1001)];
Red_White_Blue = [Red_White_Blue, col'];

% White_Gray_Black
col = linspace(0.0, 1.0, 2001);
White_Gray_Black = [col', col', col'];

% Black_Red/Green/Blue
col = linspace(0.0, 1.0, 2001);
Black_Red = [col', zeros(2001, 1), zeros(2001,1)];
Black_Green = [zeros(2001, 1), col', zeros(2001,1)];
Black_Blue = [zeros(2001, 1), zeros(2001,1), col'];

% White_Black_Red/Green/Blue
col = [linspace(1.0, 0.001, 1000), 0.0, linspace(0.001, 1.0, 1000)];
White_Black_Red = col';
White_Black_Green = col';
White_Black_Blue = col';
col = [linspace(1.0, 0.0, 1001), zeros(1, 1000)];
White_Black_Red = [White_Black_Red, col', col'];
White_Black_Green = [col', White_Black_Green, col'];
White_Black_Blue = [col', col', White_Black_Blue];

% White_Red/Green/Blue_Black
col = [zeros(1, 1001), linspace(0.999, 0.0, 1000)];
White_Red_Black = col';
White_Green_Black = col';
White_Blue_Black = col';
col = [linspace(1.0, 0.0, 1001), zeros(1, 1000)];
White_Red_Black = [White_Red_Black, col', col'];
White_Green_Black = [col', White_Green_Black, col'];
White_Blue_Black = [col', col', White_Blue_Black];

switch colorname
    case 'Red_White_Blue'
        seiscolor = Red_White_Blue;
    case 'White_Gray_Black'
        seiscolor = White_Gray_Black;
    case 'Black_Red'
        seiscolor = Black_Red;
    case 'Black_Green'
        seiscolor = Black_Green;
    case 'Black_Blue'
        seiscolor = Black_Blue;
    case 'White_Black_Red'
        seiscolor = White_Black_Red;
    case 'White_Black_Green'
        seiscolor = White_Black_Green;
    case 'White_Black_Blue'
        seiscolor = White_Black_Blue;
    case 'White_Red_Black'
        seiscolor = White_Red_Black;
    case 'White_Green_Black'
        seiscolor = White_Green_Black;
    case 'White_Blue_Black'
        seiscolor = White_Blue_Black;
    otherwise
        seiscolor = zeros(2001, 3);
end

if flipped > 0
    seiscolor = flipud(seiscolor);
end