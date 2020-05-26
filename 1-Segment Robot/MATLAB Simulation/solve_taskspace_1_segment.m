% Generate: 
% 1. Task space of a 1-Segment robot
% 2. Mapping from tendon forces to end effector position

m =0.1; %Pole Mass (kg)
l=0.045; %Pole Length (m)
r = 0.03; %Radius of disc 1 (m)
r2 = 0.045; %Radius of disc 2 (m)
g=9.81*0; %Gravity (m/s^2)
k = 1; %Spring constant (Nm/theta)
lambda = 1; %Damping constant (Nm/Omega)

temp_x = [];
temp_y = [];
temp_f2 = [];
f1 = 0;
f2 = 0;
x_actual = 1;

while (x_actual > 0.01)
    f2 = f2+0.5;
    temp_f2 = [temp_f2 f2];
    params = [f1 f2];

    fun = @(x) taskspace_1segment(params,x);
    x0 = zeros(16,1);
    x = fsolve(fun,x0);
    u = x;
    x_actual = -l*(2*sin(u(1))+2*sin(u(1)+u(3))+2*sin(u(1)+u(3)+u(5))+2*sin(u(1)+u(3)+u(5)+u(7))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13))+sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13)+u(15)));       
    y_actual = l*(1+2*cos(u(1))+2*cos(u(1)+u(3))+2*cos(u(1)+u(3)+u(5))+2*cos(u(1)+u(3)+u(5)+u(7))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13))+cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13)+u(15))); 
    temp_x(end+1) = x_actual;
    temp_y(end+1) = y_actual;
    if f2 == 5
        saved_u = u;
    end
end
figure(1);
plot_robot_straight(saved_u,1)
plot(temp_x,temp_y,'.');
hold on;
plot(-temp_x,temp_y,'.');
hold off;


ttemp_x = [-fliplr(temp_x) temp_x];
ttemp_y = [fliplr(temp_y) temp_y];

temp_r = (temp_x.^2 + temp_y.^2).^0.5;
temp_theta = atan(temp_y./temp_x);

figure(3);
plot(temp_f2,-temp_theta+pi/2);
xlabel('$f_{l,1}$ $(N)$','Interpreter','latex');
ylabel('$\theta_{EE}$ $(rad)$','Interpreter','latex');


figure(2);
plot(ttemp_x,ttemp_y,'*');
hold on;
