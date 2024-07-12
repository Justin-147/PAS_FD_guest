function [nss,eww,nee,e1,e2,sq,emax,thfz]=StrainCbF(obs,fa)
%利用分量观测求解应变参数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fa=fa*pi/180;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bx=zeros(length(fa),3);
bx(:,1)=1/2;
bx(:,2)=1/2*cos(2*fa);
bx(:,3)=-2/2*sin(2*fa);
zf=bx'*bx;
bl=bx'*obs;
x=zf\bl;
x=x';
nss=(x(:,1)+x(:,2))/2;%ns1
eww=x(:,1)-nss;%ew1
nee=x(:,3);%sor1

a1=2*nee;
a2=-nss+eww;
aa=atan(a1./a2);
a=aa/2;
b=a+pi/2;
p1=(eww-nss).*cos(2*a)+2*nee.*sin(2*a);
th=b;
iinn=find(p1<0);
th(iinn)=a(iinn);
e1=(nss+eww)/2+sqrt(((nss-eww)/2).^2+nee.^2);%ee1
e2=(nss+eww)/2-sqrt(((nss-eww)/2).^2+nee.^2);%ee2
sq=e1+e2;%sq
emax=(e1-e2)/2;%emax
thf=th*180/pi-90;%以N顺时针为正
iinn=find(thf<0);
thf(iinn)=thf(iinn)+180;
%%%%%%%%%%%%%%%%%%%%%%%%%
%方位连续化
xq=[1:1:length(thf)]';
dinan=isnan(thf);%NaN
xt=xq(~dinan);
vthf=thf(~dinan);
tthf=interp1(xt,vthf,xq,'nearest');%两头无法插值
dthf=diff(tthf);%主方位差分
xg1=dthf>150;
dthf(xg1)=dthf(xg1)-180;
xg2=dthf<-150;
dthf(xg2)=dthf(xg2)+180;
thfz=[NaN(xt(1)-1,1);vthf(1);vthf(1)+cumsum(dthf(xt(1):end))];
thfz(dinan)=NaN;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end