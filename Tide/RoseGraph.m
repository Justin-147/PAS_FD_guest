%-------------------------------------------------------------------------
%  RoseGraph(FactorZ,timej,fa0,tname,Pname,FF,date1,date2,jg,dep)
%  »æÖÆ³±Ï«Òò×ÓÃµ¹åÍ¼
%-------------------------------------------------------------------------
function RoseGraph(FactorZ,timej,fa0,tname,Pname,FF,date1,date2,jg,dep)
FN='Times-Roman';
FNNL='¿¬Ìå_GB2312';
FS=15;
tname=deblank(tname);
inn1=find(timej>=date1,1,'first');
inn2=find(timej<=date2,1,'last');
if isempty(inn1)||isempty(inn2)
    return;
end
FactorZ=FactorZ(inn1:jg:inn2,:);
timej=timej(inn1:jg:inn2,:);
ind=isnan(FactorZ(:,1));
FactorZ(ind,:)=[];
timej(ind)=[];
[ron,~]=size(FactorZ);
jd=ones(ron,1)*fa0*pi/180;
hp=figure;
set(hp,'Position',[712 191 693 554]);
set(hp,'PaperPositionMode','auto');
%set(gcf,'outerposition',get(0,'screensize'));
hh=polarlq(jd',FactorZ');
nh=length(hh);
cc=colormap(jet(nh));
for ii=1:1:nh
    set(hh(ii),'color',cc(ii,:));
end
set(gca,'position',[0.02 0.07 0.755 0.815]);
hl=legend('location','bestoutside',num2str(timej));
set(hl,'fontsize',5,'fontname',FN);
set(hl,'position',[0.8 0.01 0.13 0.98]);
%ht=title(tname,'FontName',FN,'FontSize',FS,'clipping','off');
ht=text(1,1,tname,'HorizontalAlignment','center','VerticalAlignment','middle','units','normalized','fontsize',FS,'fontname',FNNL);
set(ht,'Position',[0.5 1.0983 0]);
Figname=strcat(Pname,FF(1:7),'_RoseGraph');
tjlx=dep.tjlx;
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