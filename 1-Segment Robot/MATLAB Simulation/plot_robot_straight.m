function plot_robot_straight(u0, f)
% Plot robot configuration given the states

    m =0.1; %Pole Mass (kg)
    l=0.045; %Pole Length (m)
    r = 0.03; %Radius of disc (m)
    r2 = 0.045;
    g=9.81*0; %Gravity (m/s^2)
    k = 10; %Spring constant (Nm/theta)
    lambda = 10; %Damping constant (Nm/Omega)
    

    figure(f)
    axis([-0.7 0.7 -0.4 1.0])
    xlabel('x-axis (m)')
    ylabel('y-axis (m)')
    box on
    grid on
    hold on
    daspect([1 1 1])

    u_rel = u0;

    u0(1) = -u_rel(1);
    u0(3) = -u_rel(1) - u_rel(3);
    u0(5) = -u_rel(1) - u_rel(3) -u_rel(5);
    u0(7) = -u_rel(1) - u_rel(3) -u_rel(5) - u_rel(7);
    u0(9) = -u_rel(1) - u_rel(3) -u_rel(5) - u_rel(7) - u_rel(9);
    u0(11) = -u_rel(1) - u_rel(3) -u_rel(5) - u_rel(7) - u_rel(9) - u_rel(11);
    u0(13) = -u_rel(1) - u_rel(3) -u_rel(5) - u_rel(7) - u_rel(9) - u_rel(11) - u_rel(13);
    u0(15) = -u_rel(1) - u_rel(3) -u_rel(5) - u_rel(7) - u_rel(9) - u_rel(11) - u_rel(13) - u_rel(15);


    x1=0;
    y1=l;
    x2=2*l*sin(u0(1));
    y2=2*l*cos(u0(1));
    x3=2*l*sin(u0(3));
    y3=2*l*cos(u0(3));
    x4=2*l*sin(u0(5));
    y4=2*l*cos(u0(5));
    x5=2*l*sin(u0(7));
    y5=2*l*cos(u0(7));
    x6=2*l*sin(u0(9));
    y6=2*l*cos(u0(9));
    x7=2*l*sin(u0(11));
    y7=2*l*cos(u0(11));
    x8=2*l*sin(u0(13));
    y8=2*l*cos(u0(13));
    x9=l*sin(u0(15));
    y9=l*cos(u0(15));

    dx1 = l*sin(u0(1)) - r*cos(u0(1));
    dy1 = l + l*cos(u0(1)) + r*sin(u0(1));
    dx2 =     2*l*sin(u0(1)) + l*sin(u0(3)) - r*cos(u0(3));
    dy2 = l + 2*l*cos(u0(1)) + l*cos(u0(3)) + r*sin(u0(3));
    dx3 =     2*l*sin(u0(1)) + 2*l*sin(u0(3)) + l*sin(u0(5)) - r*cos(u0(5));
    dy3 = l + 2*l*cos(u0(1)) + 2*l*cos(u0(3)) + l*cos(u0(5)) + r*sin(u0(5));
    dx4 =     2*l*sin(u0(1)) + 2*l*sin(u0(3)) + 2*l*sin(u0(5)) + l*sin(u0(7)) - r*cos(u0(7));
    dy4 = l + 2*l*cos(u0(1)) + 2*l*cos(u0(3)) + 2*l*cos(u0(5)) + l*cos(u0(7)) + r*sin(u0(7));
    dx5 =     2*l*sin(u0(1)) + 2*l*sin(u0(3)) + 2*l*sin(u0(5)) + 2*l*sin(u0(7)) + l*sin(u0(9)) - r*cos(u0(9));
    dy5 = l + 2*l*cos(u0(1)) + 2*l*cos(u0(3)) + 2*l*cos(u0(5)) + 2*l*cos(u0(7)) + l*cos(u0(9)) + r*sin(u0(9));
    dx6 =     2*l*sin(u0(1)) + 2*l*sin(u0(3)) + 2*l*sin(u0(5)) + 2*l*sin(u0(7)) + 2*l*sin(u0(9)) + l*sin(u0(11)) - r*cos(u0(11));
    dy6 = l + 2*l*cos(u0(1)) + 2*l*cos(u0(3)) + 2*l*cos(u0(5)) + 2*l*cos(u0(7)) + 2*l*cos(u0(9)) + l*cos(u0(11)) + r*sin(u0(11));
    dx7 =     2*l*sin(u0(1)) + 2*l*sin(u0(3)) + 2*l*sin(u0(5)) + 2*l*sin(u0(7)) + 2*l*sin(u0(9)) + 2*l*sin(u0(11)) + l*sin(u0(13)) - r*cos(u0(13));
    dy7 = l + 2*l*cos(u0(1)) + 2*l*cos(u0(3)) + 2*l*cos(u0(5)) + 2*l*cos(u0(7)) + 2*l*cos(u0(9)) + 2*l*cos(u0(11)) + l*cos(u0(13))  + r*sin(u0(13));
    dx8 =     2*l*sin(u0(1)) + 2*l*sin(u0(3)) + 2*l*sin(u0(5)) + 2*l*sin(u0(7)) + 2*l*sin(u0(9)) + 2*l*sin(u0(11)) + 2*l*sin(u0(13)) + l*sin(u0(15)) - r*cos(u0(15));
    dy8 = l + 2*l*cos(u0(1)) + 2*l*cos(u0(3)) + 2*l*cos(u0(5)) + 2*l*cos(u0(7)) + 2*l*cos(u0(9)) + 2*l*cos(u0(11)) + 2*l*cos(u0(13)) + l*cos(u0(15)) + r*sin(u0(15));


    base_h = plot([x1-r x1+r],[0 0],'k','LineWidth',2);
    base_v = plot([x1 x1],[0 y1],'k','LineWidth',2);
    pole1=plot([x1 x1+x2],[y1 y1+y2],'k','LineWidth',2);
    pole2=plot([x1+x2 x1+x2+x3],[y1+y2 y1+y2+y3],'k','LineWidth',2);
    pole3=plot([x1+x2+x3 x1+x2+x3+x4],[y1+y2+y3 y1+y2+y3+y4],'k','LineWidth',2);
    pole4=plot([x1+x2+x3+x4 x1+x2+x3+x4+x5],[y1+y2+y3+y4 y1+y2+y3+y4+y5],'k','LineWidth',2);
    pole5=plot([x1+x2+x3+x4+x5 x1+x2+x3+x4+x5+x6],[y1+y2+y3+y4+y5 y1+y2+y3+y4+y5+y6],'k','LineWidth',2);
    pole6=plot([x1+x2+x3+x4+x5+x6 x1+x2+x3+x4+x5+x6+x7],[y1+y2+y3+y4+y5+y6 y1+y2+y3+y4+y5+y6+y7],'k','LineWidth',2);
    pole7=plot([x1+x2+x3+x4+x5+x6+x7 x1+x2+x3+x4+x5+x6+x7+x8],[y1+y2+y3+y4+y5+y6+y7 y1+y2+y3+y4+y5+y6+y7+y8],'k','LineWidth',2);
    pole8=plot([x1+x2+x3+x4+x5+x6+x7+x8 x1+x2+x3+x4+x5+x6+x7+x8+x9],[y1+y2+y3+y4+y5+y6+y7+y8 y1+y2+y3+y4+y5+y6+y7+y8+y9],'k','LineWidth',2);

    mass1=scatter(x1+x2/2                       ,y1+y2/2                        ,15,'k','filled');
    mass2=scatter(x1+x2+x3/2                    ,y1+y2+y3/2                     ,15,'k','filled');
    mass3=scatter(x1+x2+x3+x4/2                 ,y1+y2+y3+y4/2                  ,15,'k','filled');
    mass4=scatter(x1+x2+x3+x4+x5/2              ,y1+y2+y3+y4+y5/2               ,15,'k','filled');
    mass5=scatter(x1+x2+x3+x4+x5+x6/2           ,y1+y2+y3+y4+y5+y6/2            ,15,'k','filled');
    mass6=scatter(x1+x2+x3+x4+x5+x6+x7/2        ,y1+y2+y3+y4+y5+y6+y7/2         ,15,'k','filled');
    mass7=scatter(x1+x2+x3+x4+x5+x6+x7+x8/2     ,y1+y2+y3+y4+y5+y6+y7+y8/2      ,15,'k','filled');
    mass8=scatter(x1+x2+x3+x4+x5+x6+x7+x8+x9    ,y1+y2+y3+y4+y5+y6+y7+y8+y9     ,15,'k','filled');

    disk1 = plot([dx1 dx1+2*r*cos(u0(1))],[dy1 dy1-2*r*sin(u0(1))],'k','LineWidth',2);
    disk2 = plot([dx2 dx2+2*r*cos(u0(3))],[dy2 dy2-2*r*sin(u0(3))],'k','LineWidth',2);
    disk3 = plot([dx3 dx3+2*r*cos(u0(5))],[dy3 dy3-2*r*sin(u0(5))],'k','LineWidth',2);
    disk4 = plot([dx4 dx4+2*r*cos(u0(7))],[dy4 dy4-2*r*sin(u0(7))],'k','LineWidth',2);
    disk5 = plot([dx5 dx5+2*r*cos(u0(9))],[dy5 dy5-2*r*sin(u0(9))],'k','LineWidth',2);
    disk6 = plot([dx6 dx6+2*r*cos(u0(11))],[dy6 dy6-2*r*sin(u0(11))],'k','LineWidth',2);
    disk7 = plot([dx7 dx7+2*r*cos(u0(13))],[dy7 dy7-2*r*sin(u0(13))],'k','LineWidth',2);
    disk8 = plot([dx8 dx8+2*r*cos(u0(15))],[dy8 dy8-2*r*sin(u0(15))],'k','LineWidth',2);
    drawnow
end