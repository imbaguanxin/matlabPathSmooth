for i = 1 : length(abc)
    temp = abc(i,:);
    drawLine(temp(1),temp(2),temp(3));
    hold on;
    disp(i);
end
xlim([0 1000]);
ylim([0 1000]);