clc
clear

PhotoFilePatten=('^(IMG|VID)_(?<YMD>\d{8})_(?<HMS>\d{6})');

input_dir = uigetdir('.', 'Pick Photo Directory');
% input_dir ='C:\Users\wangy\Pictures\PS';
output_dir = uigetdir('.', 'Pick Output Directory');
% output_dir ='Z:\3 所有照片\照片按时间放入文件夹';
cd(input_dir);
AllObject=dir();
AllFile=AllObject([AllObject.isdir]==0);
for iFile=1:length(AllFile)
    [filepath,name,ext] = fileparts(AllFile(iFile).name);
    if startsWith(name,'IMG_') || startsWith(name,'VID_')
        PhotoInfo = regexp(name, PhotoFilePatten, 'names');
        if ~isempty(PhotoInfo)
            if ~exist(fullfile(output_dir,PhotoInfo.YMD(1:4)),'dir')
                mkdir(fullfile(output_dir,PhotoInfo.YMD(1:4)));
            end
            if ~exist(fullfile(output_dir,PhotoInfo.YMD(1:4),PhotoInfo.YMD),'dir')
                mkdir(fullfile(output_dir,PhotoInfo.YMD(1:4),PhotoInfo.YMD));
            end
            movefile(fullfile(input_dir,[name ext]),fullfile(output_dir,PhotoInfo.YMD(1:4),PhotoInfo.YMD));
        else
            continue;
        end
    end
end
cd('C:\Users\wangy\Documents\MATLAB\MoveJpgToDateFolder');



