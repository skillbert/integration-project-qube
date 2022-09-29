function [A,B,C,D]=auto_full(L_p,L_r,m_p,m_r,J_p,J_r,C_p,C_r,R_m,K_t,K_m,g,K_wire)
A=reshape([0.0,0.0,-(K_wire.*(J_p.*4.0+L_p.^2.*m_p))./(J_p.*J_r.*4.0+J_p.*L_r.^2.*m_p.*4.0+J_r.*L_p.^2.*m_p),(K_wire.*L_p.*L_r.*m_p.*2.0)./(J_p.*J_r.*4.0+J_p.*L_r.^2.*m_p.*4.0+J_r.*L_p.^2.*m_p),0.0,0.0,(L_p.^2.*L_r.*g.*m_p.*m_r)./(J_p.*J_r.*4.0+J_p.*L_r.^2.*m_p.*4.0+J_r.*L_p.^2.*m_p),(L_p.*g.*m_r.*(J_r+L_r.^2.*m_p).*-2.0)./(J_p.*J_r.*4.0+J_p.*L_r.^2.*m_p.*4.0+J_r.*L_p.^2.*m_p),1.0,0.0,-((C_r.*R_m+K_m.*K_t).*(J_p.*4.0+L_p.^2.*m_p))./(R_m.*(J_p.*J_r.*4.0+J_p.*L_r.^2.*m_p.*4.0+J_r.*L_p.^2.*m_p)),(L_p.*L_r.*m_p.*(C_r.*R_m+K_m.*K_t).*2.0)./(R_m.*(J_p.*J_r.*4.0+J_p.*L_r.^2.*m_p.*4.0+J_r.*L_p.^2.*m_p)),0.0,1.0,(C_p.*L_p.*L_r.*m_p.*2.0)./(J_p.*J_r.*4.0+J_p.*L_r.^2.*m_p.*4.0+J_r.*L_p.^2.*m_p),(C_p.*(J_r+L_r.^2.*m_p).*-4.0)./(J_p.*J_r.*4.0+J_p.*L_r.^2.*m_p.*4.0+J_r.*L_p.^2.*m_p)],[4,4]);
B=[0.0;0.0;(K_t.*(J_p.*4.0+L_p.^2.*m_p))./(R_m.*(J_p.*J_r.*4.0+J_p.*L_r.^2.*m_p.*4.0+J_r.*L_p.^2.*m_p));(K_t.*L_p.*L_r.*m_p.*-2.0)./(R_m.*(J_p.*J_r.*4.0+J_p.*L_r.^2.*m_p.*4.0+J_r.*L_p.^2.*m_p))];
C=reshape([1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0],[2,4]);
D=[0.0;0.0];
