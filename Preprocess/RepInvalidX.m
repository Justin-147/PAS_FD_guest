%-------------------------------------------------------------------------
%  dataz=RepInvalidX(dataz,QS,lx)
%  ���ڽ�ֵ�򵥽���ȱ����ֵ
%  ���ߣ����� ��λ���й�����ֵ���Ԥ���о��� ����޸�ʱ��2018-10-27 14:06
%-------------------------------------------------------------------------
function [dataz,index2]=RepInvalidX(dataz,QS,lx)
xx=(1:1:length(dataz))';
index2=union(find(dataz==QS),find(isnan(dataz)));
if isempty(index2)%ȫ����ȱ��������
    return;
end
if length(index2)==length(dataz)%ȫ��Ϊȱ��������
    return;
end
index=setdiff(xx,index2);
dataz=interp1(index,dataz(index),xx,'nearest');%matlab��ֵ����Ҫ���ֵ��Χ���ܳ����������ݷ�Χ
dataz(index2(index2<index(1)))=dataz(index(1));
dataz(index2(index2>index(end)))=dataz(index(end));
end