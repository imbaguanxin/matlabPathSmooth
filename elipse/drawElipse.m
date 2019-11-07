function result = drawElipse(a,b,cosine,sine,cx,cy)
rot = [cosine, sine;-sine,cosine];
phi = 0 : 0.01 : 2*pi;
x = a .* cos(phi);
y = b .* sin(phi);
p = zeros(2,length(x));
for i = 1:length(x)
   p(:,i) = rot * [x(i);y(i)] + [cx ; cy];
end
plot(p(1,:), p(2,:), 'LineWidth', 1);
axis square;
% xlim([0 1000]);
% ylim([0 1000]);
result = 0;
end

