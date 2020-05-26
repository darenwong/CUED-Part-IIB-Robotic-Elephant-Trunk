
function temp = ee_pos_to_force_solver(x1,y1,fig_num)
% Take end effector position as input and output the corresponding steady state tendon forces
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

    params = [x1 y1];
    fun = @(x) ee_pos_to_force_eqn(params,x);
    temp = [zeros(4,1) zeros(4,1)];
    sol_found = 0;
    counter = 0;
    while sol_found < 2
        x0 = (rand(20,1))*200;
        [x,fval,exitflag,output] = fsolve(fun,x0);
        f = x(17:20);
        u = x(1:16);
        exitflag;
        if exitflag > 0 && check_valid_shape(x) == 1
            if (norm(temp(:,1)-f) > 0.1)
                sol_found = sol_found +1;
                if sol_found == 1
                    temp(:,1) = f;
                else
                    temp(:,2) = f;

                end

               
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
            end
        end
        if counter > 1000
            break
        end
        counter = counter + 1;
    end
end