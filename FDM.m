% Joshua Ferrigno - MAE 3314-001
% Design 1 Project
clear all
close all
clc


kc = 150;
kb = 5;
ks = 27;

kbc = (2 * kb * kc)/(kb + kc);     
kbs = (2 * kb * ks)/(kb + ks);     
kcs = (2 * kc * ks)/(kc + ks);      

delta = 3e-3; 
qdot = 2.5e7;
qdotNode = qdot*delta^2;
h = 500;             
Tinf = 40;
% + 273.15;
Conv = Tinf*h*delta;

rows = 6;
cols = 5;

A(1,:) = [h*delta + 2*kb -kb 0 0 0 -kb 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; 
A(2,:) = [-kb h*delta + 3*kb -kb 0 0 0 -kb 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
A(3,:) = [0 -kb h*delta + 3*kb -kb 0 0 0 -kb 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
A(4,:) = [0 0 -kb h*delta + 3*kb -kb 0 0 0 -kb 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
A(5,:) = [0 0 0 -kb h*delta + 2*kb 0 0 0 0 -kb 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
A(6,:) = [-kb 0 0 0 0 4*kb -2*kb 0 0 0 -kb 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
A(7,:) = [0 -kb 0 0 0 -kb 4*kb -kb 0 0 0 -kb 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
A(8,:) = [0 0 -kb 0 0 0 -kb 4*kb -kb 0 0 0 -kb 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
A(9,:) = [0 0 0 -kb 0 0 0 -kb kbc + 3*kb -kb 0 0 0 -kbc 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; 
A(10,:) = [0 0 0 0 -kb 0 0 0 -2*kb kbc + 3*kb 0 0 0 0 -kbc 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

A(11,:) = [0 0 0 0 0 -kb 0 0 0 0 kbs + 3*kb -2*kb 0 0 0 -kbs 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
A(12,:) = [0 0 0 0 0 0 -kb 0 0 0 -kb kbs + 3*kb -kb 0 0 0 -kbs 0 0 0 0 0 0 0 0 0 0 0 0 0];
A(13,:) = [0 0 0 0 0 0 0 -kb 0 0 0 -kb kbs + kbc + 2*kb -kbc 0 0 0 -kbs 0 0 0 0 0 0 0 0 0 0 0 0];
A(14,:) = [0 0 0 0 0 0 0 0 -kbc 0 0 0 -kbc kcs + kc + 2*kbc -kc 0 0 0 -kcs 0 0 0 0 0 0 0 0 0 0 0];
A(15,:) = [0 0 0 0 0 0 0 0 0 -kbc 0 0 0 -2*kc kcs + kbc + 2*kc 0 0 0 0 -kcs 0 0 0 0 0 0 0 0 0 0];

A(16,:) = [0 0 0 0 0 0 0 0 0 0 -kbs 0 0 0 0 kbs + 3*ks -2*ks 0 0 0 -ks 0 0 0 0 0 0 0 0 0];
A(17,:) = [0 0 0 0 0 0 0 0 0 0 0 -kbs 0 0 0 -ks kbs + 3*ks -ks 0 0 0 -ks 0 0 0 0 0 0 0 0];
A(18,:) = [0 0 0 0 0 0 0 0 0 0 0 0 -kbs 0 0 0 -ks kbs + 3*ks -ks 0 0 0 -ks 0 0 0 0 0 0 0];
A(19,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 -kcs 0 0 0 -ks kcs + 3*ks -ks 0 0 0 -ks 0 0 0 0 0 0];
A(20,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 -kcs 0 0 0 -2*ks kcs + 3*ks 0 0 0 0 -ks 0 0 0 0 0];

A(21,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -ks 0 0 0 0 4*ks -2*ks 0 0 0 -ks 0 0 0 0];
A(22,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -ks 0 0 0 -ks 4*ks -ks 0 0 0 -ks 0 0 0];
A(23,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -ks 0 0 0 -ks 4*ks -ks 0 0 0 -ks 0 0];
A(24,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -ks 0 0 0 -ks 4*ks -ks 0 0 0 -ks 0];
A(25,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -ks 0 0 0 -2*ks 4*ks 0 0 0 0 -ks];

A(26,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -ks 0 0 0 0 h*delta + 2*ks -ks 0 0 0];
A(27,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -ks 0 0 0 -ks h*delta + 3*ks -ks 0 0];
A(28,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -ks 0 0 0 -ks h*delta + 3*ks -ks 0];
A(29,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -ks 0 0 0 -ks h*delta + 3*ks -ks];
A(30,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -ks 0 0 0 -ks h*delta + 2*ks];

C = zeros(30,1);
C(1:5) = Conv;
C(25:30) = Conv;
C(14:15) = qdotNode;


T = A\C;

X = [3 6 9 12 15 18 21 24 27] - 1.5;
Y = [3 6 9 12 15 18] - 1.5;
Y = flip(Y,2);

for i = 1 : 6
    for j = 1 : 5
        Tplot(i,j) = T((i-1)*5 + j);
    end
end
Tplotflip = Tplot;
Tplotflip(:,5) = [];
Tplot = [Tplot flip(Tplotflip,2)];
% Tplot = Tplot - 273.15;
Tplot = flip(Tplot,1);
fprintf('The Tmax = %f2.1\n',Tplot(4,5));

map = heatmap(X,Y,Tplot,'Colormap',jet);
map.Title = 'Chip Tempurature Distribution [C]';
map.XLabel = 'X Distance [mm]';
map.YLabel = 'Y Distance [mm]';
colormap jet

% figure()
% map = pcolor(X,Y,Tplot);
% colorbar
% shading interp
% colormap cool
% title('Design Project 1');
% set(gca,'Yticklabel',[]) 
% set(gca,'Xticklabel',[])


% figure()
% map = heatmap(X,Y,Tplot,'Colormap',jet);
% map.Title = 'Chip Tempurature Distribution [C]';
% map.XLabel = 'X Distance [mm]';
% map.YLabel = 'Y Distance [mm]';
% colormap cool

% figure()
% plot(X,Tplot(1,:),'-');
% hold on
% plot(X,Tplot(2,:),'-');
% plot(X,Tplot(3,:),'-');
% plot(X,Tplot(4,:),'-');
% plot(X,Tplot(5,:),'-');
% plot(X,Tplot(6,:),'-');
% 
% legend('Row 1','Row 2','Row 3','Row 4','Row 5','Row 6');
% title('Temperature By Row and Node');
% xlabel('Distance [mm]');
% ylabel('Temperature [C]');
