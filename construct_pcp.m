clear all;
clc;

N=64;   %Allowed NxN: 4x4, 8x8, 16x16, 64x64 
n=round(log2(N));
a=[0:1:N-1];
b=[0:1:N-1];

Dh=zeros(N,N);
Dv=zeros(N,N);

% To go from quaternion D to Dh and Dv
for r=a
    for c=b
        core=(1i).^floor(4*r*c/(2^n));    % From the perfect quaternion paper [2]
        argm=4*((r*c)^2)/(2^n);           % From the perfect quaternion paper [2]
        pol=floor(argm);
        pol=mod(pol,4);
        switch (pol)
            case 0
                Dh(r+1,c+1)=core;
                Dv(r+1,c+1)=0;
            case 1
                Dh(r+1,c+1)=0;
                Dv(r+1,c+1)=core;
            case 2
                Dh(r+1,c+1)=-core;
                Dv(r+1,c+1)=0;
            case 3
                Dh(r+1,c+1)=0;
                Dv(r+1,c+1)=-core;
        end
    end
end

Dhtild=Dh-Dv;
Dvtild=Dh+Dv;

figure()
subplot(1,2,1)
[xx,yy]=meshgrid([1:N],[1:N]);
surf(abs(fft2(Dhtild)).^2)
view([0,90])
xlim([1,N])
ylim([1,N])
colormap(flipud(hot))
grid off
colorbar
xlab=xlabel('Columns','Interpreter','Latex')
set(xlab,'FontSize',14);
ylab=ylabel('Rows','Interpreter','Latex');
set(ylab,'FontSize',14);
set(gca,'fontsize',14);

subplot(1,2,2)
[xx,yy]=meshgrid([1:N],[1:N]);
surf(abs(fft2(Dvtild)).^2)
view([0,90])
xlim([1,N])
ylim([1,N])
colormap(flipud(hot))
grid off
colorbar
xlab=xlabel('Columns','Interpreter','Latex')
set(xlab,'FontSize',14);
ylab=ylabel('Rows','Interpreter','Latex');
set(ylab,'FontSize',14);
set(gca,'fontsize',14);
