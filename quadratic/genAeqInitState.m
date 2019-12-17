function result = genAeqInitState(inputT)
%GENAEQ Summary of this function goes here
%   Detailed explanation goes here
lastT = inputT(length(inputT));
len = length(inputT);
% hard code the start point and end point constraints
hardCodeConstraints = zeros(6,10*len);
% start point constraints
% start speed
hardCodeConstraints(5,4) = 1;
hardCodeConstraints(6,9) = 1;
% start acc
% hardCodeConstraints(7,3) = 2;
% hardCodeConstraints(8,6) = 2;
% start position
hardCodeConstraints(1,5) = 1;
hardCodeConstraints(2,10) = 1;
% end point constraints
hardCodeConstraints(3, 5 * 2 * (len - 1) + 1) = lastT(1)^4;
hardCodeConstraints(3, 5 * 2 * (len - 1) + 2) = lastT(1)^3;
hardCodeConstraints(3, 5 * 2 * (len - 1) + 3) = lastT(1)^2;
hardCodeConstraints(3, 5 * 2 * (len - 1) + 4) = lastT(1)^1;
hardCodeConstraints(3, 5 * 2 * (len - 1) + 5) = 1;
hardCodeConstraints(4, 5 * 2 * (len - 1) + 6) = lastT(1)^4;
hardCodeConstraints(4, 5 * 2 * (len - 1) + 7) = lastT(1)^3;
hardCodeConstraints(4, 5 * 2 * (len - 1) + 8) = lastT(1)^2;
hardCodeConstraints(4, 5 * 2 * (len - 1) + 9) = lastT(1)^1;
hardCodeConstraints(4, 5 * 2 * (len - 1) + 10) = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hardCodeConstraints = zeros(4*length(inputT),10*len);
% for i = 1 : length(inputT)
%     startRow = (i-1)*4;
%     startCol = (i-1)*10;
%     hardCodeConstraints(startRow+1, startCol+5) = 1;
%     hardCodeConstraints(startRow+2, startCol+10) = 1;
%     hardCodeConstraints(startRow+3, startCol+1) = inputT(i)^4;
%     hardCodeConstraints(startRow+3, startCol+2) = inputT(i)^3;
%     hardCodeConstraints(startRow+3, startCol+3) = inputT(i)^2;
%     hardCodeConstraints(startRow+3, startCol+4) = inputT(i)^1;
%     hardCodeConstraints(startRow+3, startCol+5) = 1;
%     hardCodeConstraints(startRow+4, startCol+6) = inputT(i)^4;
%     hardCodeConstraints(startRow+4, startCol+7) = inputT(i)^3;
%     hardCodeConstraints(startRow+4, startCol+8) = inputT(i)^2;
%     hardCodeConstraints(startRow+4, startCol+9) = inputT(i)^1;
%     hardCodeConstraints(startRow+4, startCol+10) = 1;
% end


flexConstraints = [];
for i = 1 : length(inputT) - 1
    t = inputT(i);
    tempFourOrderConstraints = [];
    for j = 1:length(inputT)
        if (i == j)
            temp = [t^4 t^3 t^2 t 1            0 0 0 0 0       0 0 0 0 -1          0 0 0 0 0;
                    4*t^3 3*t^2 2*t^1 1 0      0 0 0 0 0       0 0 0 -1 0          0 0 0 0 0;
                    12*t^2 6*t 2 0 0           0 0 0 0 0       0 0 -2 0 0          0 0 0 0 0;
                    24*t 6 0 0 0               0 0 0 0 0       0 -6 0 0 0          0 0 0 0 0;
%                     24 0 0 0 0                 0 0 0 0 0       -24 0 0 0 0         0 0 0 0 0;
                    0 0 0 0 0      t^4 t^3 t^2 t 1            0 0 0 0 0         0 0 0 0 -1;
                    0 0 0 0 0      4*t^3 3*t^2 2*t^1 1 0      0 0 0 0 0         0 0 0 -1 0;
                    0 0 0 0 0      12*t^2 6*t 2 0 0           0 0 0 0 0         0 0 -2 0 0;
                    0 0 0 0 0      24*t 6 0 0 0               0 0 0 0 0         0 -6 0 0 0;];
%                     0 0 0 0 0      24 0 0 0 0                 0 0 0 0 0         -24 0 0 0 0;];
            tempFourOrderConstraints = [tempFourOrderConstraints, temp];
        elseif (j ~= i + 1 )
            tempFourOrderConstraints = [tempFourOrderConstraints,zeros(8,10)];
        end
    end
%     [row, col] = size(flexConstraints);
% disp(row);
% disp(col);
%     [row, col] = size(tempFourOrderConstraints);
% disp(row);
% disp(col);
    flexConstraints = [flexConstraints; tempFourOrderConstraints];
end
% [row, col] = size(hardCodeConstraints);
% disp(row);
% disp(col);
% [row, col] = size(flexConstraints);
% disp(row);
% disp(col);
% result = [];
result = [hardCodeConstraints ; flexConstraints];
end

