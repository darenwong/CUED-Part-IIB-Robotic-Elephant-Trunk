% Generate taskspace for 2-Segment robot

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
k = 1; %Spring constant (Nm/theta)
lambda = 1; %Damping constant (Nm/Omega)

f1 = 0;
f2 = 0;
ff1 = 0;
ff2 = 0;
n2 = 25;
n1 = 25;
d1 = 1;
d2 = 1;
threshold = 17;

color=['r' 'g' 'b' 'c' 'm' 'y' 'k'];
cmap_size = length(1:d1:n2);
cmap = autumn(cmap_size);

temp_r = [];
temp_t = [];
temp_f1 = [];
temp_ff2 = [];


legend_gap = 1;
legend_counter = 1;
legend_list = zeros(length(1:d2:n1)+length(1:d1:n2),1);




cmap_size = length(1:d1:n1);
cmap = autumn(cmap_size);
temp_r_all = [];
temp_t_all = [];

for ff2 = 1:d1:n2
    for f1 = 1:d2:n1
        params = [f1 f2 ff1 ff2];

        fun = @(x) force_to_ee_pos_eqn(params,x);
        x0 = zeros(16,1);
        x = fsolve(fun,x0);
        u = x;

        x_actual = -l*(2*sin(u(1))+2*sin(u(1)+u(3))+2*sin(u(1)+u(3)+u(5))+2*sin(u(1)+u(3)+u(5)+u(7))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13))+sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13)+u(15)));       
        y_actual = l*(1+2*cos(u(1))+2*cos(u(1)+u(3))+2*cos(u(1)+u(3)+u(5))+2*cos(u(1)+u(3)+u(5)+u(7))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13))+cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13)+u(15))); 

        if check_valid_shape(x) == 1

            
            if (ff2 <= threshold || (ff2 > threshold && x_actual > 0)) && x_actual < 0 && y_actual > -0.2
                temp_f1(end+1) = f1;
                temp_ff2(end+1) = ff2;

                
                temp_r(end+1) = (x_actual^2 + y_actual^2)^(0.5);
                temp_r_all(end+1) = (x_actual^2 + y_actual^2)^(0.5);
                if y_actual < 0
                    if x_actual < 0
                        t = 180 + atan(-x_actual/y_actual)*180/pi;
                    elseif x_actual > 0
                        t = -180 + atan(-x_actual/y_actual)*180/pi;
                    else
                        error('singularity');
                    end
                else
                    t = atan(-x_actual/y_actual)*180/pi;
                end
                if t < -150 
                    temp_t(end+1) = t +360;
                    temp_t_all(end+1) = t+360;
                else
                    temp_t(end+1) = t;
                    temp_t_all(end+1) = t;
                end
            end
        end

    end
    
    figure(20);
    hold on
    if isempty(temp_r)==0 || isempty(temp_t)==0
        legend_list(legend_counter) = plot(temp_r, temp_t, 'color', cmap(color_count_cont,:),'DisplayName',"ff2 = "+ string(ff2));
        xlabel('r');
        ylabel('theta');
        legend(legend_list(1:legend_gap:legend_counter));
        legend_counter = legend_counter + 1;
        
                
        hold on
        plot(temp_r(1),temp_t(1), 'r*','MarkerSize',10);
    end
    

    %%
    temp_r = [];
    temp_t = [];
end
        
%%
cmap_size = length(1:d1:n1);
cmap = winter(cmap_size);
color_count_cont = 1;

for f1 = 1:d1:n1
    for ff2 = 1:d2:n2
        params = [f1 f2 ff1 ff2];

        fun = @(x) force_to_ee_pos_eqn(params,x);
        x0 = zeros(16,1);
        x = fsolve(fun,x0);
        u = x;

        x_actual = -l*(2*sin(u(1))+2*sin(u(1)+u(3))+2*sin(u(1)+u(3)+u(5))+2*sin(u(1)+u(3)+u(5)+u(7))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11))+2*sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13))+sin(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13)+u(15)));       
        y_actual = l*(1+2*cos(u(1))+2*cos(u(1)+u(3))+2*cos(u(1)+u(3)+u(5))+2*cos(u(1)+u(3)+u(5)+u(7))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11))+2*cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13))+cos(u(1)+u(3)+u(5)+u(7)+u(9)+u(11)+u(13)+u(15))); 

        if check_valid_shape(x) == 1


            if (ff2 <= threshold || (ff2 > threshold && x_actual > 0)) && x_actual < 0 && y_actual > -0.2

                temp_f1(end+1) = f1;
                temp_ff2(end+1) = ff2;

                temp_r(end+1) = (x_actual^2 + y_actual^2)^(0.5);
                temp_r_all(end+1) = (x_actual^2 + y_actual^2)^(0.5);
                if y_actual < 0
                    if x_actual < 0
                        t = 180 + atan(-x_actual/y_actual)*180/pi;
                    elseif x_actual > 0
                        t = -180 + atan(-x_actual/y_actual)*180/pi;
                    else
                        t = atan(-x_actual/y_actual)*180/pi;
                    end
                else
                    t = atan(-x_actual/y_actual)*180/pi;
                end
                temp_t(end+1) = t;
                temp_t_all(end+1) = t;
            end
        end
    end
    figure(20);
    hold on
    if isempty(temp_r)==0 || isempty(temp_t)==0
        legend_list(legend_counter) = plot(temp_r, temp_t, 'color', cmap(color_count_cont,:),'DisplayName',"f1 = "+ string(f1));
        xlabel('r');
        ylabel('theta');
        legend(legend_list(1:legend_gap:legend_counter));
        legend_counter = legend_counter + 1;
        
        hold on
        plot(temp_r(1),temp_t(1), 'b*','MarkerSize',10) 
    end
    

    
    %%
    temp_r = [];
    temp_t = [];
end