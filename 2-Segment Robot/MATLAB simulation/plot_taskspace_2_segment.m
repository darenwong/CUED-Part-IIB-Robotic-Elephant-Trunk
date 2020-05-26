% Plot the generated taskspace by solve_taskspace_2_segment in polar coordinates

close all;

max_index = length(temp_f1); 
max_color_f1 = max(temp_f1);
max_color_ff2 = max(temp_ff2);

%% f1 + ff2
figure(3)
hold on

                                          
cn = ceil(max_color_f1+max_color_ff2);                                        
cm = colormap(jet(cn));
plott = scatter3(temp_r_all, temp_t_all, temp_f1+temp_ff2, [], temp_f1+temp_ff2, 'filled')
alpha = 0.05;
set(plott, 'MarkerEdgeAlpha', alpha, 'MarkerFaceAlpha', alpha)
colorbar
grid on
hold on

xl = xlim
yl = ylim
[xi,yi] = meshgrid(xl(1):0.01:xl(2), yl(1):1:yl(2));
zi = griddata(temp_r_all,temp_t_all,temp_f1+temp_ff2,xi,yi);
[c,h] = contour(xi,yi,zi);
h.LineWidth = 3;
clabel(c,h,'FontSize', 15);
xlabel('$r_{EE}$ $(m)$','Interpreter','latex','FontSize', 15)
ylabel('$\theta_{EE}$ $(^{\circ})$','Interpreter','latex','FontSize', 15)
title('$f_{l,1} + f_{s,2}$ $(N)$','Interpreter','latex','FontSize', 15)

figure(8)
surf(xi,yi,zi);
xlabel('r')
ylabel('t')
zlabel('f1+ff2')
hold on


%% ff2 - f1
figure(5)
hold on
cn = ceil(max_color_f1-max_color_ff2);                                        
cm = colormap(jet(cn));
plott = scatter3(temp_r_all, temp_t_all, temp_f1-temp_ff2, [], temp_f1-temp_ff2, 'filled')
alpha = 0.05;
set(plott, 'MarkerEdgeAlpha', alpha, 'MarkerFaceAlpha', alpha)
colorbar
grid on

                                         

xl = xlim
yl = ylim
[xi,yi] = meshgrid(xl(1):0.01:xl(2), yl(1):1:yl(2));
zi = griddata(temp_r_all,temp_t_all,temp_f1-temp_ff2,xi,yi);
[c,h] = contour(xi,yi,zi);
h.LineWidth = 3;
clabel(c,h,'FontSize', 15);
xlabel('$r_{EE}$ $(m)$','Interpreter','latex','FontSize', 15)
ylabel('$\theta_{EE}$ $(^{\circ})$','Interpreter','latex','FontSize', 15)
title('$f_{l,1} - f_{s,2}$ $(N)$','Interpreter','latex','FontSize', 15)


figure(9)
surf(xi,yi,zi);
xlabel('r')
ylabel('t')
zlabel('f1-ff2')
hold on

