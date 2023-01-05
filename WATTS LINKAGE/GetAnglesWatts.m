function [DAngle,BAngle,CAngle] = GetAnglesWatts(coords,ang)

A = coords(1,:);
B = coords(2,:);
C = coords(3,:);
D = coords(4,:); 
 
vectDC = C-D;
vectDA = [2*D(1) D(2)]-D;
DAngle = acos(dot(vectDC,vectDA)/(norm(vectDC)*norm(vectDA))); 
X = cross([vectDC 0],[vectDA 0]);
if X(3) > 0
    DAngle = pi + abs(pi - DAngle);
end
DAngle = DAngle-ang;


vectBA = A-B;
vectBC = C-B;
BAngle = acos(dot(vectBA,vectBC)/(norm(vectBA)*norm(vectBC)));

vectCB = B-C;
vectCD = D-C;
CAngle = acos(dot(vectCB,vectCD)/(norm(vectCB)*norm(vectCD)));


end 