sys_for_mpc_C_3=load('mpc/final_plant.mat','sys_for_mpc_C_3').sys_for_mpc_C_3;

%% create MPC controller object with sample time
mpc1 = mpc(sys_for_mpc_C_3, 0.005);
%% specify prediction horizon
mpc1.PredictionHorizon = 140;
%% specify control horizon
mpc1.ControlHorizon = 3;
%% specify nominal values for inputs and outputs
mpc1.Model.Nominal.U = 0;
mpc1.Model.Nominal.Y = [0;0;0;0];
%% specify constraints for MV and MV Rate
mpc1.MV(1).Min = -1;
mpc1.MV(1).Max = 1;
%% specify constraints for OV
mpc1.OV(1).Min = -2.35619449019234;
mpc1.OV(1).Max = 2.35619449019234;
mpc1.OV(2).Min = -0.174532925199433;
mpc1.OV(2).Max = 0.174532925199433;
%% specify weights
mpc1.Weights.MV = 1;
mpc1.Weights.MVRate = 1;
mpc1.Weights.OV = [30 1 1 1];
mpc1.Weights.ECR = 1000000;
%% specify simulation options
options = mpcsimopt();
options.RefLookAhead = 'off';
options.MDLookAhead = 'off';
options.Constraints = 'on';
options.OpenLoop = 'off';
%% run simulation
sim(mpc1, 2001, mpc1_RefSignal_3, mpc1_MDSignal_3, options);
