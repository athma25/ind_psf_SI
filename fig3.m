clear all
close all


fig1=figure(1);
ax=gca;
x=-1.3:0.01:2.2;

g1=@(y) 1*(1-y.^2);
g2=@(y) 1-(y-0.75).^2;

plot(x,g1(x),'-','LineWidth',2);
ax=gca;
hold 'on';
plot(x,g2(x),'-','LineWidth',2);
plot(x,0*x,'--k');
set(ax,'ColorOrderIndex',1);
plot([0 0.75],[g1(0) g1(0.75)],'.','MarkerSize',50)
text(0.1,1.05*g1(0),'\gamma_{11}','FontSize',15);
text(0.85,g1(0.75),'\gamma_{12}','FontSize',15);
plot([0 0.75],[g2(0) g2(0.75)],'.','MarkerSize',50)
text(0.1,g2(0),'\gamma_{21}','FontSize',15);
text(0.8,1.05*g2(0.75),'\gamma_{22}','FontSize',15);
hold 'off';
xticks([0 0.75]);
xticklabels({'\epsilon_1','\epsilon_2'});
ax.FontSize=20;
myTxtFmt(xlabel('Soil condition'),25,0);
myTxtFmt(ylabel('Intrinsic growth rate'),25,0);
%myTxtFmt(title('(+ +)'),25,0);
%annotation('doublearrow',[0.54 0.78],[0.38 0.38]);
xlim([-1.3 2.2])
ylim([-0.5 1.1])
%text(0.45,-0.2,'\omega','FontSize',25);
print(fig1,'fig3b','-dpng');

fig2=figure(2);
ax=gca;
x=-1.3:0.01:3.2;

g1=@(y) 1*(1-y.^2);
g2=@(y) -1.2*(1-(y-1.2).^2);

plot(x,g1(x),'-','LineWidth',2);
ax=gca;
hold 'on';
plot(x,g2(x),'-','LineWidth',2);
plot(x,0*x,'--k');
set(ax,'ColorOrderIndex',1);
plot([0 1.2],[g1(0) g1(1.2)],'.','MarkerSize',50)
text(0.01,0.9*g1(0),'\gamma_{11}','FontSize',15);
text(0.8,g1(1.2),'\gamma_{12}','FontSize',15);
plot([0 1.2],[g2(0) g2(1.2)],'.','MarkerSize',50)
text(0.1,g2(0),'\gamma_{21}','FontSize',15);
text(0.85,1.05*g2(0.75),'\gamma_{22}','FontSize',15);
hold 'off';
xticks([0 0.75]);
xticklabels({'\epsilon_1','\epsilon_2'});
ax.FontSize=20;
myTxtFmt(xlabel('Soil condition'),25,0);
myTxtFmt(ylabel('Intrinsic growth rate'),25,0);
%myTxtFmt(title('(+ +)'),25,0);
%annotation('doublearrow',[0.54 0.78],[0.38 0.38]);
xlim([-1.3 3.2])
ylim([-1.3 1])
%text(0.45,-0.2,'\omega','FontSize',25);
print(fig2,'fig3c','-dpng');

fig3d=figure(3);
ax=gca;
x=-1.3:0.01:3.2;

g1=@(y) 0.25*(1-y.^2);
g2=@(y) 0.25*(1-(y-2).^2);

plot(x,g1(x),'-','LineWidth',2);
ax=gca;
hold 'on';
plot(x,g2(x),'-','LineWidth',2);
plot(x,0*x,'--k');
set(ax,'ColorOrderIndex',1);
plot([0 2],[g1(0) g1(2)],'.','MarkerSize',50)
text(0.1,0.75*g1(0),'\gamma_{11}','FontSize',15);
text(0.1,g1(2),'\gamma_{12}','FontSize',15);
plot([0 2],[g2(0) g2(2)],'.','MarkerSize',50)
text(2.15,g2(0),'\gamma_{21}','FontSize',15);
text(2.1,0.75*g2(2),'\gamma_{22}','FontSize',15);
hold 'off';
xticks([0 2]);
ax.FontSize=20;
myTxtFmt(xlabel('Soil condition'),25,0);
myTxtFmt(ylabel('Intrinsic growth rate'),25,0);
%myTxtFmt(title('(+ +)'),25,0);
%annotation('doublearrow',[0.54 0.78],[0.38 0.38]);
xlim([-1.3 3.2])
ylim([-1 1.1])
%text(0.45,-0.2,'\omega','FontSize',25);
print(fig3d,'fig3d','-dpng');
