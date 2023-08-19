clc
clear
script_dir = pwd;
PhotoFilePatten=('^(IMG|VID)_(?<YMD>\d{8})_(?<HMS>\d{6})');

input_dir = uigetdir('.', 'Pick Photo Directory');
% output_dir = uigetdir('.', 'Pick Output Directory');
output_dir='..\按时间整理';
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
            if ~exist(fullfile(output_dir,PhotoInfo.YMD(1:4),PhotoInfo.YMD,[name ext]),'file')
                movefile(fullfile(input_dir,[name ext]),fullfile(output_dir,PhotoInfo.YMD(1:4),PhotoInfo.YMD));
            else
                warning('Same Name File Exist! %s',fullfile(output_dir,PhotoInfo.YMD(1:4),PhotoInfo.YMD,[name ext]));
            end

            continue;
        end
    end
end
cd(script_dir);



