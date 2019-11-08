function result = constrain2A(constrain,numOfParams,t)

temp1 = constrain(:,1);
temp2 = constrain(:,2);
c1 = [];
c2 = [];
t1 = [];
for i = 1 : numOfParams
    c1(:,i) = temp1;
    c2(:,i) = temp2;
    for (j = 1 : length(temp1))
        t1(j,i) = t ^ (numOfParams - i);
    end
end
constrain = [c1,c2];
tr = [t1,t1];
% disp(c1);
% disp(c2);
result = constrain .* tr;
end

