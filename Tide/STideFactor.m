%-------------------------------------------------------------------------
%  STideFactor(fa0,FactorZ,MsfZ,timej,hfa,PPn,FFn,tname,tjlx)
%  ����ĳһ�Ƕȵĳ�ϫ����
%-------------------------------------------------------------------------
function STideFactor(fa0,FactorZ,MsfZ,timej,hfa,PPn,FFn,tname,tjlx)
FS=12;%�𼶱�ʾ�ֺ�
FN='Times New Roman';%�𼶱�ʾ����
FNNL='����_GB2312';
LW=0.5;%�߿�
MS=8;%markersize
color_error=0.7;%errorbar�ĻҶ�
cc='r';%��ɫ
mc='k';%makercolor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index=find(fa0==hfa);
if ~isempty(index)
    titleT=[deblank(tname),'-[Ŀ��\ʵ��]��λ��Ϊ','[',num2str(hfa),'\',num2str(hfa),']��'];
else
    [~,index]=min(abs(fa0-hfa));
    titleT=[deblank(tname),'-[Ŀ��\ʵ��]��λ��Ϊ','[',num2str(hfa),'\',num2str(fa0(index)),']��'];
end
Factor=FactorZ(:,index);
Msf=MsfZ(:,index);
x=datenum(num2str(timej),'yyyymmdd');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=figure; hold on;
set(hp,'Position',[360 280 460 245]);
set(hp,'PaperPositionMode','auto');
errorbar(x,Factor,Msf,'color',color_error*ones(1,3),'LineStyle','none');
plot(x,Factor,cc,'LineWidth',LW,'Markersize',MS,'Marker','.','MarkerEdgecolor',mc);
hold off;
datetick('x','yyyymmdd');
set(gca,'Position',[0.1350 0.23 0.7750 0.65]);
set(gca,'tickdir','out','FontName',FN,'FontSize',FS);
xlabel('����','FontName',FNNL,'FontSize',FS);
ylabel('M2����ϫ����','FontName',FNNL,'FontSize',FS);
title(titleT,'FontName',FNNL,'FontSize',FS);
Figname=strcat(PPn,FFn(1:7),'_Tide',num2str(fa0(index)));
if ismember(1,tjlx)
    saveas(hp,Figname,'tif');
end
if ismember(2,tjlx)
    saveas(hp,Figname,'fig');
end
if ismember(3,tjlx)
    saveas(hp,Figname,'pdf');
end
close(hp);
end