%-------------------------------------------------------------------------
%  PlotCurveComp(datam,dataz,timet,QS,wzFtimeCO,wzFtimeAM,FF,Range)
%  ����ʱ������������ģ�����ͼ��,������ʱ��2018-11-16
%-------------------------------------------------------------------------
function PlotCurveComp(datam,dataz,timet,QS,wzFtimeCO,wzFtimeAM,FF,Range,flag)
datam(datam==QS)=NaN;
dataz(dataz==QS)=NaN;
stimet=num2str(timet);
[~,len2]=size(stimet);
if len2==14%��ֵ����
    strfor='yyyymmddHHMMSS';
elseif len2==12%����ֵ����
    strfor='yyyymmddHHMM';
elseif len2==10%����ֵ����
    strfor='yyyymmddHH';
elseif len2==8%��ֵ����
    strfor='yyyymmdd';
else
    return;
end
tnum=datenum(stimet,strfor);
LW1=2;
LW2=1;
wwidth=length(datam);
figure;
subplot(1,2,1)
hold on;
subplot(1,2,2)
hold on;
subplot(1,2,1)
plot(tnum,dataz,'k','Linewidth',LW1);
for ii=1:1:length(wzFtimeCO)
    tdata=dataz(wzFtimeCO(ii):wzFtimeCO(ii)+wwidth-1);
    mt1=nanmax(tdata);
    mt2=nanmin(tdata);
    mt3=nanmean(tdata);
    xk=[wzFtimeCO(ii),wzFtimeCO(ii)+wwidth-1,wzFtimeCO(ii)+wwidth-1,wzFtimeCO(ii),wzFtimeCO(ii)];
    yk=[mt1,mt1,mt2,mt2,mt1];
    xk=tnum(xk);
    subplot(1,2,1)
    plot(xk,yk,'b','Linewidth',LW1);
    subplot(1,2,2)
    plot(tdata-mt3,'b','Linewidth',LW2);
end
for ii=1:1:length(wzFtimeAM)
    tdata=dataz(wzFtimeAM(ii):wzFtimeAM(ii)+wwidth-1);
    mt1=nanmax(tdata);
    mt2=nanmin(tdata);
    mt3=nanmean(tdata);
    xk=[wzFtimeAM(ii),wzFtimeAM(ii)+wwidth-1,wzFtimeAM(ii)+wwidth-1,wzFtimeAM(ii),wzFtimeAM(ii)];
    yk=[mt1,mt1,mt2,mt2,mt1];
    xk=tnum(xk);
    subplot(1,2,1)
    plot(xk,yk,'r','Linewidth',LW1);
    subplot(1,2,2)
    plot(tdata-mt3,'r','Linewidth',LW2);
end
if flag==1%��ͼ��ʶģ��λ��
    mt=find(timet==Range(1));
    xk=[mt,mt+wwidth-1,mt+wwidth-1,mt,mt];
    mt1=nanmax(datam);
    mt2=nanmin(datam);    
    yk=[mt1,mt1,mt2,mt2,mt1];
    xk=tnum(xk);
    subplot(1,2,1)
    plot(xk,yk,'g','Linewidth',LW1);
end
mt3=nanmean(datam);
subplot(1,2,1)
ylabel('Amplitude');
title('The Time Postion Of Every Similar Curve');
axis(findobj(gcf,'Type','axes'),'tight');
tlabel(gca,'keepl','FixHigh',8);
xlabel('Time');
hold off;
subplot(1,2,2)
plot(datam-mt3,'g','Linewidth',LW1);
ylabel('Amplitude');
xlabel('Time Serie No.');
title('The Similar Curves');
hold off;
set(gcf,'outerposition',get(0,'screensize'));
set(gcf,'Name',FF);
end