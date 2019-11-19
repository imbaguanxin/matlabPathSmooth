cons1 = [1,1,2;1,1,-2;-1,1,2;-1,1,-2];
center1 = [0,0];
cons2 = [1,1,0;1,-1,0;1,1,4;1,-1,-4];
center2 = [2,0];

[m1,b1] = splitConstrain(cons1,center1);
[m2,b2] = splitConstrain(cons2,center2);

t1 = 15;
t2 = 15;
A1 = [];
A2 = [];
B1 = [];
B2 = [];
% build constraints
for i = 0 : 0.1 : floor(t1)
    A1 = [A1; constrain2A(m1,5,i,1,2)];
    B1 = [B1; b1];
end
for i = 0 : 0.1 : floor(t2)
    A2 = [A2; constrain2A(m2,5,i,2,2)];
    B2 = [B2; b2];
end

Afinal = [A1 ; A2];
Bfinal = [B1 ; B2];  

H = hardCodeH(t1, t2);
f = zeros(1,20);

aeq = hardCodeAeq(t1);
beq = zeros(18,1);
beq(1) = -1;
beq(2) = 1;
beq(3) = 1;
beq(4) = 0;
beq(5) = 1;
beq(6) = 0;
beq(7) = 3;
beq(8) = 1;

z = quadprog(H,f,Afinal,Bfinal,aeq,beq);

disp(z);

t = 0:0.1:15;
x = z(1) * t.^4 + z(2) * t.^3 + z(3) * t.^2 + z(4) * t.^1 + z(5);
y = z(6) * t.^4 + z(7) * t.^3 + z(8) * t.^2 + z(9) * t.^1 + z(10);
plot(x,y);

hold on;
t = 0:0.1:15;
x = z(11) * t.^4 + z(12) * t.^3 + z(13) * t.^2 + z(14) * t.^1 + z(15);
y = z(16) * t.^4 + z(17) * t.^3 + z(18) * t.^2 + z(19) * t.^1 + z(20);
plot(x,y);
