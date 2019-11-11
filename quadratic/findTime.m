function result = findTime(start,dest,maxa,maxv)

lim = maxv^2 / maxa;
dist = distance(start, dest);
if (dist < lim)
    result = sqrt(dist/maxa);
else
    result = maxv / maxa + dist / maxv;
end
end

