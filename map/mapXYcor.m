classdef mapXYcor
    %MAPXYCOR 此处显示有关此类的摘要
    %   一个以正常XY坐标系的地图
    
    properties
        cellStatus
        xLength
        yLength
    end
    
    methods
        function obj = mapXYcor(maxX,maxY)
            %MAPXYCOR 构造此类的实例
            %   构造
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
                         color = [255,255,255];
                    elseif (temp == 1)
                        color = [0,0,0];
                    elseif (temp == 2)
                        color = [0,255,0];
                    elseif (temp == 3)
                        color = [255,0,0];
                    elseif (temp == 4)
                        color = [0,0,255];
                    elseif (temp == 5)
                        color = [102/255,204/255,255/255];
                    end
                    result(self.yLength + 1 - j,i,:) = color;
                end
            end
        end
        
    end
end

