
%% mpc with noise model


loadeddata = load('not_wobbly');
mpctest=loadeddata.mpc1;

% setmpcsignals(plant,'MV',1,'UD',[2 3 4]);
% mpctest=;

sys_0 = ss(sys) ;

sys_plantmpc=ss(sys_0.A.*[1,1,1,1;1,1,1,1;1,1,1,-1;-1,-1,-1,1],[diag([1,1,1,-1])*sys_0.B, [1;0;0;0]],eye(4),zeros(4,2));

sys_plantmp1c=ss(sys_0.A.*[1,1,1,1;1,1,1,1;1,1,1,-1;-1,-1,-1,1],[diag([1,1,1,-1])*sys_0.B, [0;0;0;0]],eye(4),[0 1;0 0;0 0; 0 0]);
%indist=tf(0.1,[1,0]);

%setindist(mpctest,'model',indist);

