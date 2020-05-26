% Plot data logged from Vex brain SD card

filename = 'temp.txt';
f = fopen(filename);
data = textscan(f,'%s%s%s%s%s%s%s%s%s');
fclose(f);

radius = str2double(data{1}(1:end));
theta = str2double(data{2}(1:end));
t = str2double(data{3}(1:end));
t = 1e-6.*t;
r_target = str2double(data{4}(1:end));
t_target = str2double(data{5}(1:end));
f1 = str2double(data{6}(1:end))./0.01;
f2 = str2double(data{7}(1:end))./0.01;
ff1 = str2double(data{8}(1:end))./0.01;
ff2 = str2double(data{9}(1:end))./0.01;

filter = 5001;
linewidth = 2;

figure(1);
subplot(2,1,1);
plot(t,smooth(-theta,filter),'LineWidth',linewidth);
xlabel('$Time$ $(s)$','Interpreter','latex', 'FontSize', 12);
ylabel('$\theta_{EE}$ $(^{\circ})$','Interpreter','latex', 'FontSize', 12);
hold on;
line = plot(t,smooth(-t_target,filter),'Color', 'r','LineWidth',linewidth);
line.Color(4) = 1;
hold off;
grid on;
legend('$Actual$ $\theta_{EE}$','$Desired$ $\theta_{EE}$','Interpreter','latex', 'FontSize', 12);

subplot(2,1,2);
plot(t,smooth(radius,filter),'LineWidth',linewidth);
xlabel('$Time$ $(s)$','Interpreter','latex', 'FontSize', 12);
ylabel('$r_{EE}$ $(mm)$','Interpreter','latex', 'FontSize', 12);
hold on;
line = plot(t,smooth(r_target,filter),'Color', 'r','LineWidth',linewidth);
line.Color(4) = 1;
hold off;
grid on;
legend('$Actual$ $r_{EE}$','$Desired$ $r_{EE}$','Interpreter','latex', 'FontSize', 12);

%%
t = t(1:end-1);


figure(3);
subplot(4,1,1);
plot(t,smooth(f1,5001),'LineWidth',linewidth);
xlabel('$Time$ $(s)$','Interpreter','latex', 'FontSize', 12);
ylabel('$f_{l,1}$ $(N)$','Interpreter','latex', 'FontSize', 12);
grid on;

% t = t(1:end-1);
subplot(4,1,2);
plot(t,smooth(f2,5001),'LineWidth',linewidth);
xlabel('$Time$ $(s)$','Interpreter','latex', 'FontSize', 12);
ylabel('$f_{l,2}$ $(N)$','Interpreter','latex', 'FontSize', 12);
grid on;

subplot(4,1,3);
plot(t,smooth(ff1,5001),'LineWidth',linewidth);
xlabel('$Time$ $(s)$','Interpreter','latex', 'FontSize', 12);
ylabel('$f_{s,1}$ $(N)$','Interpreter','latex', 'FontSize', 12);
grid on;

subplot(4,1,4);
plot(t,smooth(ff2,5001),'LineWidth',linewidth);
xlabel('$Time$ $(s)$','Interpreter','latex', 'FontSize', 12);
ylabel('$f_{s,2}$ $(N)$','Interpreter','latex', 'FontSize', 12);
grid on;