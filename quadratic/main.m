cons1 = [1,1,2;   1,1,-2;   -1,1,2;   -1,1,-2];
center1 = [0,0];
cons2 = [1,1,0;   1,1,-4;   -1,1,4;   -1,1,0];
center2 = [2,0];
cons3 = [1,1,-2;   1,1,-6;   -1,1,6;   -1,1,2];
center3 = [4,0];
cons4 = [1,1,-4;   1,1,-8;   -1,1,8;   -1,1,4];
center4 = [6,0];
cons5 = [1,1,-6;   1,1,-10;   -1,1,10;   -1,1,6];
center5 = [8,0];

[m1,b1] = splitConstrain(cons1,center1);
[m2,b2] = splitConstrain(cons2,center2);
[m3,b3] = splitConstrain(cons3,center3);
[m4,b4] = splitConstrain(cons4,center4);
[m5,b5] = splitConstrain(cons5,center5);

t1 = 15;
t2 = 15;
t3 = 15;
t4 = 15;
t5 = 15;
A1 = [];
A2 = [];
A3 = [];
A4 = [];
A5 = [];
B1 = [];
B2 = [];
B3 = [];
B4 = [];
B5 = [];
% build constraints
for i = 0 : 1 : floor(t1)
    A1 = [A1; constrain2A(m1,5,i,1,5)];
    B1 = [B1; b1];
end
for i = 0 : 1 : floor(t2)
    A2 = [A2; constrain2A(m2,5,i,2,5)];
    B2 = [B2; b2];
end
for i = 0 : 1 : floor(t3)
    A3 = [A3; constrain2A(m3,5,i,3,5)];
    B3 = [B3; b3];
end
for i = 0 : 1 : floor(t4)
    A4 = [A4; constrain2A(m4,5,i,4,5)];
    B4 = [B4; b4];
end
for i = 0 : 1 : floor(t5)
    A5 = [A5; constrain2A(m5,5,i,5,5)];
    B5 = [B5; b5];
end

Afinal = [A1 ; A2; A3; A4];% A5];
Bfinal = [B1 ; B2; B3; B4];% B5];  

path = {[-1,0.5],[1,0],[3,0.5],[5,-0.5], [7,0],[9,-0.5]};
time = [15,15,15,15,15];
beq = genBeq(path);
f = zeros(1, length(time) * 10);
H = genHessenberg(time);
aeq = genAeq(time);

z = quadprog(H,f,Afinal,Bfinal,aeq,beq);

disp(z);
plotSmoothPath(time,z);
for i = 1 : length(path)
    pt = path{i};
    plot(pt(1),pt(2),'o');
    hold on;
end
% t = 0:0.1:15;
% x = z(1) * t.^4 + z(2) * t.^3 + z(3) * t.^2 + z(4) * t.^1 + z(5);
% y = z(6) * t.^4 + z(7) * t.^3 + z(8) * t.^2 + z(9) * t.^1 + z(10);
% plot(x,y);
% 
% hold on;
% t = 0:0.1:15;
% x = z(11) * t.^4 + z(12) * t.^3 + z(13) * t.^2 + z(14) * t.^1 + z(15);
% y = z(16) * t.^4 + z(17) * t.^3 + z(18) * t.^2 + z(19) * t.^1 + z(20);
% plot(x,y);
% 
% hold on;
% t = 0:0.1:15;
% x = z(21) * t.^4 + z(22) * t.^3 + z(23) * t.^2 + z(24) * t.^1 + z(25);
% y = z(26) * t.^4 + z(27) * t.^3 + z(28) * t.^2 + z(29) * t.^1 + z(30);
% plot(x,y);


% x to t, y to t velocity
% t = 0:0.1:15;
% x = z(1) * 4 * t.^3 + z(2) * 3 * t.^2 + z(3) * 2 * t + z(4);
% y = z(6) * 4 * t.^3 + z(7) * 3 * t.^2 + z(8) * 2 * t + z(9);
% plot(t,x);
% hold on;
% plot(t,y);

% x to t, y to t acceleration
% t = 0:0.1:15;
% x = z(1) * 12 * t.^2 + z(2) * 6 * t.^2 + z(3) * 2;
% y = z(6) * 12 * t.^2 + z(7) * 6 * t.^2 + z(8) * 2;
% plot(t,x);
% hold on;
% plot(t,y);

% x to t, y to t jerk
% t = 0:0.1:15; 
% x = z(1) * 24 * t.^1 + z(2) * 6;
% y = z(6) * 24 * t.^1 + z(7) * 6;
% plot(t,x);
% hold on;
% plot(t,y);