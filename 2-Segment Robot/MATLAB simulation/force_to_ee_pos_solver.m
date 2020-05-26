function u = force_to_ee_pos_solver(f,fig_num)
% Take tendon forces as input and output the corresponding steady state end effector position
    global m;
    global l;
    global r;
    global r2;
    global g;
    global k;
    global lambda;

    m =0.1; %Pole Mass (kg)
    l=0.045; %Pole Length (m)
    r = 0.03; %Radius of disc (m)
    r2 = 0.045;
    g=9.81*0; %Gravity (m/s^2)
    k = 10; %Spring constant (Nm/theta)
    lambda = 10; %Damping constant (Nm/Omega)


    f1 = f(1);
    f2 = f(2);
    ff1 = f(3);
    ff2 = f(4);

    params = f;

    fun = @(x) force_to_ee_pos_eqn(params,x);
    x0 = zeros(16,1);

    x = fsolve(fun,x0);
    u = x;
    x_actual = -l*(2*sin(u(1))+2*sin(u(1)+u(3))+2*sin(u(1)+u(3)+u(5))+2*sin(u(1)+u(3)+u(5)+u(7))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13))+sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13)+u(15)));       
    y_actual = l*(1+2*cos(u(1))+2*cos(u(1)+u(3))+2*cos(u(1)+u(3)+u(5))+2*cos(u(1)+u(3)+u(5)+u(7))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13))+cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13)+u(15))); 

    if (abs(f(1)-f(3))*abs(f(2)-f(4)) > 0.1) %bm
        if abs(f(1)) > abs(f(2))
            plot_robot_conf('b',u,fig_num);
        else
            plot_robot_conf('m',u,fig_num);
        end
    else
        if abs(f(1)) > abs(f(2))
            plot_robot_conf('g',u,fig_num);
        else
            plot_robot_conf('y',u,fig_num);    
        end
    end
    n1 = 100;
    d = 10;
end
