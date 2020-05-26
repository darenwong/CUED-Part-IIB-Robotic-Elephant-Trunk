% Derive the linearised robot equation for 2-Segment robot

n = 8;
syms('theta',[n 1])
syms('dot_theta',[n 1])
syms('ddot_theta',[n 1])

syms k l r r2 lambda

syms('x',[2*n 1])
syms('dot_x',[2*n 1])

syms f1 f2 ff1 ff2;

G =[k*theta1
 k*theta2
 k*theta3
 k*theta4
 k*theta5
 k*theta6
 k*theta7
 k*theta8];

G_lin = [diff(G(1), theta1), diff(G(1), theta2), diff(G(1), theta3), diff(G(1), theta4), diff(G(1), theta5), diff(G(1), theta6), diff(G(1), theta7), diff(G(1), theta8);...
    diff(G(2), theta1), diff(G(2), theta2), diff(G(2), theta3), diff(G(2), theta4), diff(G(2), theta5), diff(G(2), theta6), diff(G(2), theta7), diff(G(2), theta8);...
    diff(G(3), theta1), diff(G(3), theta2), diff(G(3), theta3), diff(G(3), theta4), diff(G(3), theta5), diff(G(3), theta6), diff(G(3), theta7), diff(G(3), theta8);...
    diff(G(4), theta1), diff(G(4), theta2), diff(G(4), theta3), diff(G(4), theta4), diff(G(4), theta5), diff(G(4), theta6), diff(G(4), theta7), diff(G(4), theta8);...
    diff(G(5), theta1), diff(G(5), theta2), diff(G(5), theta3), diff(G(5), theta4), diff(G(5), theta5), diff(G(5), theta6), diff(G(5), theta7), diff(G(5), theta8);...
    diff(G(6), theta1), diff(G(6), theta2), diff(G(6), theta3), diff(G(6), theta4), diff(G(6), theta5), diff(G(6), theta6), diff(G(6), theta7), diff(G(6), theta8);...
    diff(G(7), theta1), diff(G(7), theta2), diff(G(7), theta3), diff(G(7), theta4), diff(G(7), theta5), diff(G(7), theta6), diff(G(7), theta7), diff(G(7), theta8);...
    diff(G(8), theta1), diff(G(8), theta2), diff(G(8), theta3), diff(G(8), theta4), diff(G(8), theta5), diff(G(8), theta6), diff(G(8), theta7), diff(G(8), theta8)];

Q = [f1*r*cos(theta1/2) - f2*r*cos(theta1/2) + ff1*r2*cos(theta1/2) - ff2*r2*cos(theta1/2) + f1*l*sin(theta1/2) + f2*l*sin(theta1/2) + ff1*l*sin(theta1/2) + ff2*l*sin(theta1/2)
 f1*r*cos(theta2/2) - f2*r*cos(theta2/2) + ff1*r2*cos(theta2/2) - ff2*r2*cos(theta2/2) + f1*l*sin(theta2/2) + f2*l*sin(theta2/2) + ff1*l*sin(theta2/2) + ff2*l*sin(theta2/2)
 f1*r*cos(theta3/2) - f2*r*cos(theta3/2) + ff1*r2*cos(theta3/2) - ff2*r2*cos(theta3/2) + f1*l*sin(theta3/2) + f2*l*sin(theta3/2) + ff1*l*sin(theta3/2) + ff2*l*sin(theta3/2)
 f1*r*cos(theta4/2) - f2*r*cos(theta4/2) + ff1*r2*cos(theta4/2) - ff2*r2*cos(theta4/2) + f1*l*sin(theta4/2) + f2*l*sin(theta4/2) + ff1*l*sin(theta4/2) + ff2*l*sin(theta4/2)
                                                                                           f1*r*cos(theta5/2) - f2*r*cos(theta5/2) + f1*l*sin(theta5/2) + f2*l*sin(theta5/2)
                                                                                           f1*r*cos(theta6/2) - f2*r*cos(theta6/2) + f1*l*sin(theta6/2) + f2*l*sin(theta6/2)
                                                                                           f1*r*cos(theta7/2) - f2*r*cos(theta7/2) + f1*l*sin(theta7/2) + f2*l*sin(theta7/2)
                                                                                           r*(f1*cos(theta8/2) - f2*cos(theta8/2)) + l*(f1*sin(theta8/2) + f2*sin(theta8/2))];
 
Q_dq_dtheta_lin = [diff(Q(1), theta1), diff(Q(1), theta2), diff(Q(1), theta3), diff(Q(1), theta4), diff(Q(1), theta5), diff(Q(1), theta6), diff(Q(1), theta7), diff(Q(1), theta8);...
    diff(Q(2), theta1), diff(Q(2), theta2), diff(Q(2), theta3), diff(Q(2), theta4), diff(Q(2), theta5), diff(Q(2), theta6), diff(Q(2), theta7), diff(Q(2), theta8);...
    diff(Q(3), theta1), diff(Q(3), theta2), diff(Q(3), theta3), diff(Q(3), theta4), diff(Q(3), theta5), diff(Q(3), theta6), diff(Q(3), theta7), diff(Q(3), theta8);...
    diff(Q(4), theta1), diff(Q(4), theta2), diff(Q(4), theta3), diff(Q(4), theta4), diff(Q(4), theta5), diff(Q(4), theta6), diff(Q(4), theta7), diff(Q(4), theta8);...
    diff(Q(5), theta1), diff(Q(5), theta2), diff(Q(5), theta3), diff(Q(5), theta4), diff(Q(5), theta5), diff(Q(5), theta6), diff(Q(5), theta7), diff(Q(5), theta8);...
    diff(Q(6), theta1), diff(Q(6), theta2), diff(Q(6), theta3), diff(Q(6), theta4), diff(Q(6), theta5), diff(Q(6), theta6), diff(Q(6), theta7), diff(Q(6), theta8);...
    diff(Q(7), theta1), diff(Q(7), theta2), diff(Q(7), theta3), diff(Q(7), theta4), diff(Q(7), theta5), diff(Q(7), theta6), diff(Q(7), theta7), diff(Q(7), theta8);...
    diff(Q(8), theta1), diff(Q(8), theta2), diff(Q(8), theta3), diff(Q(8), theta4), diff(Q(8), theta5), diff(Q(8), theta6), diff(Q(8), theta7), diff(Q(8), theta8)];

Q_dq_df1_lin = [diff(Q(1),f1);...
    diff(Q(2),f1);...
    diff(Q(3),f1);...
    diff(Q(4),f1);...
    diff(Q(5),f1);...
    diff(Q(6),f1);...
    diff(Q(7),f1);...
    diff(Q(8),f1)];

Q_dq_dff2_lin = [diff(Q(1),ff2);...
    diff(Q(2),ff2);...
    diff(Q(3),ff2);...
    diff(Q(4),ff2);...
    diff(Q(5),ff2);...
    diff(Q(6),ff2);...
    diff(Q(7),ff2);...
    diff(Q(8),ff2)];

Q_dq_df2_lin = [diff(Q(1),f2);...
    diff(Q(2),f2);...
    diff(Q(3),f2);...
    diff(Q(4),f2);...
    diff(Q(5),f2);...
    diff(Q(6),f2);...
    diff(Q(7),f2);...
    diff(Q(8),f2)];

Q_dq_dff1_lin = [diff(Q(1),ff1);...
    diff(Q(2),ff1);...
    diff(Q(3),ff1);...
    diff(Q(4),ff1);...
    diff(Q(5),ff1);...
    diff(Q(6),ff1);...
    diff(Q(7),ff1);...
    diff(Q(8),ff1)];

x_ee = - l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) - 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) - 2*l*sin(theta1 + theta2 + theta3 + theta4) - 2*l*sin(theta1 + theta2) - 2*l*sin(theta1) - 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) - 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5) - 2*l*sin(theta1 + theta2 + theta3); 
y_ee = l + l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*cos(theta1 + theta2 + theta3 + theta4) + 2*l*cos(theta1 + theta2) + 2*l*cos(theta1) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5) + 2*l*cos(theta1 + theta2 + theta3);
t_ee = atan(-x_ee/y_ee)*180/pi;
t_ee_dt_dtheta_lin = [diff(t_ee(1), theta1), diff(t_ee(1), theta2), diff(t_ee(1), theta3), diff(t_ee(1), theta4), diff(t_ee(1), theta5), diff(t_ee(1), theta6), diff(t_ee(1), theta7), diff(t_ee(1), theta8)];
r_ee = (x_ee^2+y_ee^2)^(0.5);
r_ee_dr_dtheta_lin = [diff(r_ee(1), theta1), diff(r_ee(1), theta2), diff(r_ee(1), theta3), diff(r_ee(1), theta4), diff(r_ee(1), theta5), diff(r_ee(1), theta6), diff(r_ee(1), theta7), diff(r_ee(1), theta8)];


dot_x_ee = - dot_theta7*(l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7)) - dot_theta5*(l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5)) - dot_theta6*(l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7)) - dot_theta3*(l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*cos(theta1 + theta2 + theta3 + theta4) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5) + 2*l*cos(theta1 + theta2 + theta3)) - dot_theta4*(l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*cos(theta1 + theta2 + theta3 + theta4) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5)) - dot_theta1*(l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*cos(theta1 + theta2 + theta3 + theta4) + 2*l*cos(theta1 + theta2) + 2*l*cos(theta1) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5) + 2*l*cos(theta1 + theta2 + theta3)) - dot_theta2*(l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*cos(theta1 + theta2 + theta3 + theta4) + 2*l*cos(theta1 + theta2) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*cos(theta1 + theta2 + theta3 + theta4 + theta5) + 2*l*cos(theta1 + theta2 + theta3)) - dot_theta8*l*cos(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8);
dot_y_ee = - dot_theta1*(l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*sin(theta1 + theta2 + theta3 + theta4) + 2*l*sin(theta1 + theta2) + 2*l*sin(theta1) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5) + 2*l*sin(theta1 + theta2 + theta3)) - dot_theta7*(l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7)) - dot_theta2*(l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*sin(theta1 + theta2 + theta3 + theta4) + 2*l*sin(theta1 + theta2) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5) + 2*l*sin(theta1 + theta2 + theta3)) - dot_theta5*(l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5)) - dot_theta6*(l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7)) - dot_theta3*(l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*sin(theta1 + theta2 + theta3 + theta4) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5) + 2*l*sin(theta1 + theta2 + theta3)) - dot_theta4*(l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6) + 2*l*sin(theta1 + theta2 + theta3 + theta4) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7) + 2*l*sin(theta1 + theta2 + theta3 + theta4 + theta5)) - dot_theta8*l*sin(theta1 + theta2 + theta3 + theta4 + theta5 + theta6 + theta7 + theta8);
dot_t_ee = (x_ee*dot_y_ee-y_ee*dot_x_ee)/(x_ee^2+y_ee^2)*180/pi;
dot_r_ee = (x_ee*dot_x_ee+y_ee*dot_y_ee)/(x_ee^2+y_ee^2)^0.5;

dot_t_ee_ddt_dtheta_lin = [diff(dot_t_ee(1), theta1), diff(dot_t_ee(1), theta2), diff(dot_t_ee(1), theta3), diff(dot_t_ee(1), theta4), diff(dot_t_ee(1), theta5), diff(dot_t_ee(1), theta6), diff(dot_t_ee(1), theta7), diff(dot_t_ee(1), theta8)];
dot_t_ee_ddt_ddtheta_lin = [diff(dot_t_ee(1), dot_theta1), diff(dot_t_ee(1), dot_theta2), diff(dot_t_ee(1), dot_theta3), diff(dot_t_ee(1), dot_theta4), diff(dot_t_ee(1), dot_theta5), diff(dot_t_ee(1), dot_theta6), diff(dot_t_ee(1), dot_theta7), diff(dot_t_ee(1), dot_theta8)];
dot_r_ee_ddt_dtheta_lin = [diff(dot_r_ee(1), theta1), diff(dot_r_ee(1), theta2), diff(dot_r_ee(1), theta3), diff(dot_r_ee(1), theta4), diff(dot_r_ee(1), theta5), diff(dot_r_ee(1), theta6), diff(dot_r_ee(1), theta7), diff(dot_r_ee(1), theta8)];
dot_r_ee_ddt_ddtheta_lin = [diff(dot_r_ee(1), dot_theta1), diff(dot_r_ee(1), dot_theta2), diff(dot_r_ee(1), dot_theta3), diff(dot_r_ee(1), dot_theta4), diff(dot_r_ee(1), dot_theta5), diff(dot_r_ee(1), dot_theta6), diff(dot_r_ee(1), dot_theta7), diff(dot_r_ee(1), dot_theta8)];
