classdef mapXYcor
    %MAPXYCOR 此处显示有关此类的摘�?
    %   一个以正常XY�??标系的地图
    
    properties
        cellStatus
        xLength
        yLength
    end
    
    methods
        function obj = mapXYcor(maxX,maxY)
            %MAPXYCOR creates a empty x-y corrdinate map
            if (maxX > 0 && maxY > 0)
                obj.cellStatus = zeros(maxX, maxY);
                obj.xLength = maxX;
                obj.yLength = maxY;
            else
                fprintf("size must be positive numbers");
            end
        end
        
        function result=validPos(self,x,y)
            result = x > 0 && x < self.xLength + 1 && y > 0 && y < self.yLength + 1;
        end
        
        function result=isBlank(self,x,y)
            if (self.validPos(x,y))
                result = self.cellStatus(x,y) == 0;
            else
                result = false;
            end
        end
        
        function result=isInsideBlock(self,x,y)
            dirction = {[1,0],[-1,0],[0,1],[0,-1]};
            pt = [x,y];
            acc = 0;
            for i = 1 : length(dirction)
                temp = pt + dirction{i};
                if ( ~self.isBlank(temp(1),temp(2)))
                    acc = acc + 1;
                end
            end
            result =  acc > 3;
        end
        
        function result = showMapImg(self)
            result = zeros(self.yLength, self.xLength, 3);
            for i = 1 : self.xLength
                for j = 1 : self.yLength
                    temp = self.cellStatus(i,j);
                    color = [.5,.5,.5];
                    if (temp == 0)
                        % #FFFFFF white
                         color = [255,255,255];
                    elseif (temp == 1)
                        % #000000 black
                        color = [0,0,0];
                    elseif (temp == 2)
                        % #00FF00 pure green
                        color = [0,255,0];
                    elseif (temp == 3)
                        % #FF0000 pure red
                        color = [255,0,0];
                    elseif (temp == 4)
                        % #0000FF pure blue
                        color = [0,0,255];
                    elseif (temp == 5)
                        % #66CCFF sky blue
                        color = [102/255,204/255,255/255];
                    elseif (temp == 6)
                        % #00FFFF cyan
                        color = [0/255,255/255,255/255];
                    elseif (temp == 7)
                        % #7FFFD4 Aquamarine
                        color = [127/255,255/255,212/255];
                    elseif (temp == 8)
                        % #CD5C5C IndianRed
                        color = [205/255,92/255,92/255];
                    elseif (temp == 9)
                        % #FF69B4 HotPink
                        color = [255/255,105/255,180/255];
                    elseif (temp == 10)
                        % #8A2BE2 BlueViolet
                        color = [138/255,43/255,226/255];
                    elseif (temp == 11)
                        % #EED5D2 MistyRose
                        color = [238/255,213/255,210/255];
                    elseif (temp == 12)
                        % #AB82FF MediumPurple
                        color = [171/255,130/255,255/255];
                    elseif (temp == 13)
                        % #DCDCDC Gainsboro
                        color = [220/255,220/255,220/255];
                    elseif (temp == 14)
                        % #9C9C9C grey
                        color = [156/255,156/255,156/255];
                    end
                    result(self.yLength + 1 - j,i,:) = color;
                end
            end
        end
        
    end
end

