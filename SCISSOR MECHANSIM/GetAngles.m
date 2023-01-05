function [DAngle,BAngle,CAngle] = GetAngles(coords)

A = coords(1,:);
B = coords(2,:);
C = coords(3,:);
D = coords(4,:); 
 
vectDC = C-D;
vectDA = 2*D-D;
% vectDA = A-D;
DAngle = acos(dot(vectDC,vectDA)/(norm(vectDC)*norm(vectDA)));

vectBA = A-B;
vectBC = C-B;
BAngle = acos(dot(vectBA,vectBC)/(norm(vectBA)*norm(vectBC)));

vectCB = B-C;
vectCD = D-C;
CAngle = acos(dot(vectCB,vectCD)/(norm(vectCB)*norm(vectCD)));


end 