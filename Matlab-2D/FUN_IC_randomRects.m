function w0=FUN_IC_randomRects(n,numrects,bgu,bgv,valup)
% if valup(1(or 2))==0, rectangles have u(or v) value lower than backgroundu(or v)
% if valup(1(or 2))==1, rectangles have u(or v) value higher than backgroundu(or v)

x=linspace(0,1,n); y=linspace(0,1,n);
[xx,yy]=meshgrid(x,y);
 
u0=zeros(n,n); u0=u0(:);
v0=zeros(n,n); v0=v0(:);

if valup(1)==0 && valup(2)==0
    for i=1:numrects
        % make random rectangles 
        a=rand; b=rand;
        rect=((yy<a+0.1*rand).*(yy>a-0.1*rand).*(xx<b+0.1*rand).*(xx>b-0.1*rand));
        % assign random u and v values
        u0=u0+((bgu-0)*rand+0  )*rect(:);
        v0=v0+((bgv-0)*rand+0  )*rect(:);
    end
elseif valup(1)==0 && valup(2)==1
        for i=1:numrects
        % make random rectangles 
        a=rand; b=rand;
        rect=((yy<a+0.1*rand).*(yy>a-0.1*rand).*(xx<b+0.1*rand).*(xx>b-0.1*rand));
        % assign random u and v values
        u0=u0+((bgu-0)*rand+0  )*rect(:);
        v0=v0+((1-bgv)*rand+bgv)*rect(:);
        end
elseif valup(1)==1 && valup(2)==0
        for i=1:numrects
        % make random rectangles 
        a=rand; b=rand;
        rect=((yy<a+0.1*rand).*(yy>a-0.1*rand).*(xx<b+0.1*rand).*(xx>b-0.1*rand));
        % assign random u and v values
        u0=u0+((1-bgu)*rand+bgu)*rect(:);
        v0=v0+((bgv-0)*rand+0  )*rect(:);
        end
elseif valup(1)==1 && valup(1)==1
        for i=1:numrects
        % make random rectangles 
        a=rand; b=rand;
        rect=((yy<a+0.1*rand).*(yy>a-0.1*rand).*(xx<b+0.1*rand).*(xx>b-0.1*rand));
        % assign random u and v values
        u0=u0+((1-bgu)*rand+bgu)*rect(:);
        v0=v0+((1-bgv)*rand+bgv)*rect(:);
        end
end
 
u0(u0>1)=1; v0(v0>1)=1; 

% change background
u0(u0==0)=bgu; v0(v0==0)=bgv;

w0=[u0;v0];

end