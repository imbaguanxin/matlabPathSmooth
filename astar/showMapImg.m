function imgResult = showMapImg(map)
    imgResult = zeros(map.rowLength,map.colLength,3);
        for i = 1 : map.rowLength
            for j = 1 : map.colLength
               temp = map.cellStatus(i,j);
               if (temp == 0)
                   imgResult(i,j,:) = [255,255,255];
               elseif (temp == 1)
                   imgResult(i,j,:) = [0,0,0];
               elseif (temp == 2)
                   imgResult(i,j,:) = [0,255,0];
               elseif (temp == 3)
                   imgResult(i,j,:) = [255,0,0];
               elseif (temp == 4)
                   imgResult(i,j,:) = [0,0,255];
               elseif (temp == 5)
                   imgResult(i,j,:) = [102/255,204/255,255/255];
               end
            end
         end
end

