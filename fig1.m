clear all
close all


fig=figure(1);
ax=gca;
x=-1.5:0.01:1.5;

g1=@(y) 1*(1-y.^2);

plot(x,g1(x),'-','LineWidth',2);
hold 'on';
plot(x,0*x,'--k');
hold 'off';
xticks([0]);
yticks([0]);
xticklabels({"Critical soil"});
ax.FontSize=20;
myTxtFmt(xlabel('Soil condition'),27,0);
myTxtFmt(ylabel('Intrinsic growth rate'),27,0);
%myTxtFmt(title('(+ +)'),25,0);
ann=annotation('doublearrow',[0.26 0.77],[0.4 0.4]);
text(-0.77,-0.15,'Fundamental niche','FontSize',20);
xlim([-1.5 1.5])
ylim([-0.5 1.1])
print(fig,'fig1','-dpng');
