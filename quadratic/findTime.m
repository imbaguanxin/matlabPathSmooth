function result = findTime(start,dest,maxa,maxv)

lim = maxv^2 / maxa;
dist = distance(start, dest);
if (dist < lim)
    result = 2 * sqrt(dist/maxa);%sqrt(dist/maxa);
else
    result = 2 * maxv / maxa + (dist - lim) / maxv;% maxv / maxa + dist / maxv;
end
end

