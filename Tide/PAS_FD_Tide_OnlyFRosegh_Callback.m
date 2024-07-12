% --------------------------------------------------------------------
%  PAS_FD_Tide_OnlyFRosegh_Callback(hObject, eventdata, handles)
%  绘制潮汐因子玫瑰图
% --------------------------------------------------------------------
function PAS_FD_Tide_OnlyFRosegh_Callback(hObject, eventdata, handles)
% hObject    handle to PAS_FD_Tide_FRosegh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
depNew=struct('date1','NaN','date2','NaN','JG','1');
prompt={'玫瑰图绘制起始时间(NaN为不限定)','玫瑰图绘制终止时间(NaN为不限定)','绘制间隔（原计算间隔倍数）'};
titleinput='基本参数'; lines=1; option.resize='on';option.windowstyle='normal';
hi=inputdlg(prompt,titleinput,lines,struct2cell(depNew),option);
if isempty(hi)
    return;
end
fields={'date1','date2','JG'};
if size(hi,1)>0 depNew=cell2struct(hi,fields,1); end

%读文件名
[Fname,Pname]=uigetfile({'*Rose.mat','mat文件(*Rose.mat)'},'请挑选潮汐玫瑰图结果文件','MultiSelect','on');
%完整文件路径
if iscell(Fname)
    NFZ=length(Fname);
elseif Fname==0  %如果没有打开文件，则跳出程序
    return;
else
    NFZ=1;
    Fname={Fname};
end
canshu=handles.canshu.canshu43;%读入配置文件参数
tmp=canshu{1};
tjlx=[];
for it=1:1:length(tmp)
    tjlx=[tjlx,str2num(tmp(it))];
end
depNew.tjlx=tjlx;
lent=8;%结果的时间位数
for iiNFZ=1:1:NFZ
    dbfile=[Pname,Fname{iiNFZ}];
    load(dbfile);
    if isempty(depNew.date1)||isnan(str2num(depNew.date1))
        tm1=timej(1);
    else
        ss=length(depNew.date1);%参数位数
        tmp=str2num(depNew.date1);
        if ss>=lent
            tmp1=floor(tmp/10^(ss-lent));
            tmp1=find(timej>=tmp1,1,'first');
            if isempty(tmp1)
                tm1=timej(1);
            else
                tm1=timej(tmp1);
            end
        else
            tmp1=find(timej>=tmp*10^(lent-ss),1,'first');
            if isempty(tmp1)
                tm1=timej(1);
            else
                tm1=timej(tmp1);
            end
        end
    end
    if isempty(depNew.date2)||isnan(str2num(depNew.date2))
        tm2=timej(end);
    else
        ee=length(depNew.date2);%参数位数
        tmp=str2num(depNew.date2);
        if ee>=lent
            tmp1=floor(tmp/10^(ee-lent));
            tmp1=find(timetj<=tmp1,1,'last');
            if isempty(tmp1)
                tm2=timej(end);
            else
                tm2=timej(tmp1);
            end
        else
            tmp1=find(timej<(tmp+1)*10^(lent-ee),1,'last');
            if isempty(tmp1)
                tm2=timej(end);
            else
                tm2=timej(tmp1);
            end
        end
    end
    RoseGraph(FactorZ,timej,fa0,tname,Pname,FF,tm1,tm2,str2num(depNew.JG),depNew);
end
end