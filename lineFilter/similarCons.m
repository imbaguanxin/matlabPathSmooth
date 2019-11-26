function res = similarCons(block)
res = false;
a1 = block(1,1);
a2 = block(2,1);
a3 = block(3,1);
b1 = block(1,2);
b2 = block(2,2);
b3 = block(3,2);
c1 = block(1,3);
c2 = block(2,3);
c3 = block(3,3);
[k1,t1] = getSlopForm(a1,b1,c1);
[k2,t2] = getSlopForm(a2,b2,c2);
[k3,t3] = getSlopForm(a3,b3,c3);
% if (abs(k1 - pi/2) < pi/360 && abs(k3 - pi/2) < pi/360)
%     if ((t1-t3) < 1)
%         res = true;
%     end
% end
% if (abs(k2 - pi/2) < pi/360 && abs(k3 - pi/2) < pi/360)
%     if ((t2-t3) < 1)
%         res = true;
%     end
% end
if (abs(k1 - k3) < pi/360 && abs(k1/t1 - k3/t3) < 0.01)
    res = true;
end
if (abs(k2 - k3) < pi/360 && abs(k2/t2 - k3/t3) < 0.01)
    res = true;
end
end

