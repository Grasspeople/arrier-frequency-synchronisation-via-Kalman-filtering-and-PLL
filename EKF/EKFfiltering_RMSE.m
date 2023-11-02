clear
%%
%Number of steps
Nsteps =100 ;

x_ini=[pi/2,20,0]';
P=diag([(pi^2)/3 1 1]);
Q=diag([0.1 0.1 0.1]);%covariance matrix
R=diag([(pi/3)^2 (pi/3)^2]);

T=0.05;%sampling period
F=[1 T (T^2)/2; 0 1 T; 0 0 1];

[x_truth,y_measure] = generate_truth_measurement(Nsteps,x_ini,Q,R,F);

%%
%Extended Kalman filter
%initialisation
x_k=x_ini;
P_k=P;
[x_u_series,RMSE] = EKF(Nsteps,x_k,P_k,R,Q,F,y_measure,x_truth);
%%
draw_filtered(Nsteps,y_measure,x_truth,x_u_series)     
%%

