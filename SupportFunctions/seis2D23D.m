function Data_3D = seis2D23D(Data_2D, TimeRes, NTrace, NInline)
% SEIS2D23D Convert the 2D seismic data to 3D seismic data along the direction 
% of inline. Because when reading 3D seismic datasets by ReadSegy, 3D 
% seismic datasets will be stored in the form of 2D. As such a result, we'll
% need the conversion from 2D to the original 3D format. Here the converted
% 3D data is formed based on seismic slices.
%    Data_3D = Seis2D23D(Data_2D, TimeRes, NTrace, NInline), "TIMERES" is
%    the resolution of datasets on time, "NTRACE" is the number of traces,
%    which is equal to the range of crossline, "NInline" is the number of
%    seismic slices, which equals to the range of inline.
Data_3D =  zeros(TimeRes, NTrace, NInline);
for i =1:NInline
    Data_3D(:,:,i) = Data_2D(:,NTrace*(i-1)+1:NTrace*i);
end