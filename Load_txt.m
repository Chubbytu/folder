%% ----------------Set Up---------------- %%
clc;
clear all;
close all;
%% ----------------Select Data---------------- %%
[file,path] = uigetfile('*','MultiSelect','on');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(sprintf('User selected %s\n',string(fullfile(path,file))));
end
%% ----------------Load Data---------------- %%
cnt = 1;
for i=1:length(file)
    FileFID = fopen(string(file(i)));
    disp(sprintf('Loading Input File %s ...',string(file(i))));
    while ~ feof(FileFID)
        Filetmp = (strsplit(fgetl(FileFID),' '));
        if size(Filetmp,2) == 14
            sat = str2double(Filetmp);
            sat_Matrix(cnt,1) = sat(3);
            sat_Matrix(cnt,2) = sat(5);
            sat_Matrix(cnt,3) = sat(10);
            sat_Matrix(cnt,4) = sat(11);
            sat_Matrix(cnt,5) = sat(12);
        end
        cnt = cnt+1;
    end
end
for selected_sat=1:32
    f = figure;
    hold on
    subplot(3,1,1),scatter(sat_Matrix(find(sat_Matrix(:,1) == selected_sat),2)-54965,sat_Matrix(find(sat_Matrix(:,1) == selected_sat),3),'red','.')
    xlabel('Time(Day)'),ylabel('residual-X(m)'),title(sprintf('DOY 134-143,2009  Satellite NO.%d X-Direction Residual',selected_sat))
    subplot(3,1,2),scatter(sat_Matrix(find(sat_Matrix(:,1) == selected_sat),2)-54965,sat_Matrix(find(sat_Matrix(:,1) == selected_sat),4),'blue','.')
    xlabel('Time(Day)'),ylabel('residual-Y(m)'),title(sprintf('DOY 134-143,2009  Satellite NO.%d Y-Direction Residual',selected_sat))
    subplot(3,1,3),scatter(sat_Matrix(find(sat_Matrix(:,1) == selected_sat),2)-54965,sat_Matrix(find(sat_Matrix(:,1) == selected_sat),5),'green','.')
    xlabel('Time(Day)'),ylabel('residual-Z(m)'),title(sprintf('DOY 134-143,2009  Satellite NO.%d Z-Direction Residual',selected_sat))
    saveas(gcf,sprintf('Satellite NO.%d Residual.jpg',selected_sat));
    disp(sprintf('Saved Satellite NO.%d Residual.jpg',selected_sat))
    close(f)
end
fclose(FileFID);
disp('Complete Saving Image ...');