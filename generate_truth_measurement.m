function [x_truth,y_measure] = generate_truth_measurement(Nsteps,x_ini,P_ini,Q_ini,R_ini,H,F,T)
chol_P=chol(P_ini)';
if Q_ini == zeros(3)
    chol_Q = zeros(3);
else
    chol_Q=chol(Q_ini)';
end
chol_R=chol(R_ini)';
independent_P_noise = randn(3, Nsteps);
independent_Q_noise = randn(3, Nsteps);
independent_R_noise = randn(3, Nsteps);
V = chol_Q * independent_Q_noise;%chol_Q * independent_Q_noise;%procedure noise
N = chol_R * independent_R_noise;%measurement noise

%true phase/freq/freq dot
x_truth=zeros(3,Nsteps); %theta f fdot
x_truth(:,1) = x_ini + V(:,1);
%measurement（only phase）
y_measure=zeros(3,Nsteps);
y_measure(:,1)=H*x_truth(:,1)+N(:,1);



%%
for k=2:Nsteps
    
    %Truth
    x_truth(:,k)=F*x_truth(:,k-1)+V(:,k);
    
    %Measurement
    y_measure(:,k)=H*x_truth(:,k)+N(:,k);
end
end