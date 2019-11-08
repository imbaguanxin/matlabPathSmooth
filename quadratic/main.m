temp = [1,1,1;1,1,-1;-1,1,1;-1,1,-1];
center = [0,0];

[m,b] = splitConstrain(temp,center);
A = constrain2A(m,5,2);
