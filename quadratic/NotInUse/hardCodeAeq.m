function result = hardCodeAeq(t)
result = [0 0 0 0 1     0 0 0 0 0   0 0 0 0 0  0 0 0 0 0;
          0 0 0 0 0     0 0 0 0 1   0 0 0 0 0  0 0 0 0 0;
          0 0 0 0 0            0 0 0 0 0       t^4 t^3 t^2 t 1         0 0 0 0 0;
          0 0 0 0 0            0 0 0 0 0       0 0 0 0 0         t^4 t^3 t^2 t 1 ;
          t^4 t^3 t^2 t 1            0 0 0 0 0       0 0 0 0 -1          0 0 0 0 0;
          4*t^3 3*t^2 2*t^1 1 0      0 0 0 0 0       0 0 0 -1 0          0 0 0 0 0;
          12*t^2 6*t 2 0 0           0 0 0 0 0       0 0 -2 0 0          0 0 0 0 0;
          24*t 6 0 0 0               0 0 0 0 0       0 -6 0 0 0          0 0 0 0 0;
          24 0 0 0 0                 0 0 0 0 0       -24 0 0 0 0         0 0 0 0 0;
          0 0 0 0 0      t^4 t^3 t^2 t 1            0 0 0 0 0         0 0 0 0 -1;
          0 0 0 0 0      4*t^3 3*t^2 2*t^1 1 0      0 0 0 0 0         0 0 0 -1 0;
          0 0 0 0 0      12*t^2 6*t 2 0 0           0 0 0 0 0         0 0 -2 0 0;
          0 0 0 0 0      24*t 6 0 0 0               0 0 0 0 0         0 -6 0 0 0;
          0 0 0 0 0      24 0 0 0 0                 0 0 0 0 0         -24 0 0 0 0;];
end


% 0 0 0 0 0     0 0 0 0 0   0 0 0 0 1  0 0 0 0 0;
%           0 0 0 0 0     0 0 0 0 0   0 0 0 0 0  0 0 0 0 1;
%           t^4 t^3 t^2 t 1            0 0 0 0 0       0 0 0 0 0         0 0 0 0 0;
%           0 0 0 0 0            t^4 t^3 t^2 t 1       0 0 0 0 0         0 0 0 0 0;

