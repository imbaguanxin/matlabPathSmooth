function result = genAeq(inputT)
%GENAEQ Summary of this function goes here
%   Detailed explanation goes here
lastT = inputT(length(inputT));
len = length(inputT);
hardCodeConstraints = zeros(4,10*len);
% hard code the start point and end point constraints
% start point constraints
hardCodeConstraints(1,5) = 1;
hardCodeConstraints(2,10) = 1;
% end point constraints
hardCodeConstraints(3,5 * 2 * (len - 1) + 1) = lastT(1)^4;
hardCodeConstraints(3,5 * 2 * (len - 1) + 2) = lastT(1)^3;
hardCodeConstraints(3,5 * 2 * (len - 1) + 3) = lastT(1)^2;
hardCodeConstraints(3,5 * 2 * (len - 1) + 4) = lastT(1)^1;
hardCodeConstraints(3,5 * 2 * (len - 1) + 5) = 1;
hardCodeConstraints(4,5 * 2 * (len - 1) + 6) = lastT(1)^4;
hardCodeConstraints(4,5 * 2 * (len - 1) + 7) = lastT(1)^3;
hardCodeConstraints(4,5 * 2 * (len - 1) + 8) = lastT(1)^2;
hardCodeConstraints(4,5 * 2 * (len - 1) + 9) = lastT(1)^1;
hardCodeConstraints(4,5 * 2 * (len - 1) + 10) = 1;

flexConstraints = [];
for i = 1 : length(inputT) - 1
    disp(i);
    t = inputT(i);
    tempFourOrderConstraints = [];
    for j = 1:length(inputT)
        if (i == j)
            temp = [t^4 t^3 t^2 t 1            0 0 0 0 0       0 0 0 0 -1          0 0 0 0 0;
                    4*t^3 3*t^2 2*t^1 1 0      0 0 0 0 0       0 0 0 -1 0          0 0 0 0 0;
                    12*t^2 6*t 2 0 0           0 0 0 0 0       0 0 -2 0 0          0 0 0 0 0;
                    24*t 6 0 0 0               0 0 0 0 0       0 -6 0 0 0          0 0 0 0 0;
                    24 0 0 0 0                 0 0 0 0 0       -24 0 0 0 0         0 0 0 0 0;
                    0 0 0 0 0      t^4 t^3 t^2 t 1            0 0 0 0 0         0 0 0 0 -1;
                    0 0 0 0 0      4*t^3 3*t^2 2*t^1 1 0      0 0 0 0 0         0 0 0 -1 0;
                    0 0 0 0 0      12*t^2 6*t 2 0 0           0 0 0 0 0         0 0 -2 0 0;
                    0 0 0 0 0      24*t 6 0 0 0               0 0 0 0 0         0 -6 0 0 0;
                    0 0 0 0 0      24 0 0 0 0                 0 0 0 0 0         -24 0 0 0 0;];
            tempFourOrderConstraints = [tempFourOrderConstraints, temp];
        elseif (j ~= i + 1 )
            tempFourOrderConstraints = [tempFourOrderConstraints,zeros(10,10)];
        end
    end
    flexConstraints = [flexConstraints; tempFourOrderConstraints];
end
% disp(flexConstraints);
result = [hardCodeConstraints ; flexConstraints];
end

