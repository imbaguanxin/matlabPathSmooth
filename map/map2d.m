classdef map2d
    properties
        % 0-clear, 1-obstcal, 2-searched
        cellStatus
        parent
        rowLength
        colLength
    end
    
    methods
        % consturctor
        function self=map2d(row,col)
            if (row > 0 && col >0)
                self.cellStatus = zeros(row,col);
                self.parent = cell(row,col);
                self.rowLength = row;
                self.colLength = col;
            else
                fprintf("size must be positive numbers");
            end
        end
        
        function result=validPos(self,row,col)
            result = row > 0 && row < self.rowLength + 1 && col > 0 && col < self.colLength + 1;
        end
        
        function result=isBlank(self,row,col)
            if (self.validPos(row,col))
                result = self.cellStatus(row,col) == 0;
            else
                result = false;
            end
        end
        
        function result=findParent(self,row,col)
            if (self.validPos(row,col))
                result = self.parent{row, col};
            else
                fprintf("not a valid grid, find parent failed.");
            end
        end
        
        function result=isInsideBlock(self,row,col)
            dirction = {[1,1],[1,-1],[-1,1],[-1,-1]};
            pt = [row,col];
            acc = 0;
            for i = 1 : length(dirction)
                temp = pt + dirction{i};
                if ( ~self.isBlank(temp(1),temp(2)))
                    acc = acc + 1;
                end
            end
            result =  acc > 3;
        end
        
        function result=changeCorrdinate(self)
            result = map2d(self.rowLength, self.colLength);
            for i = 1:self.rowLength
                for j = 1:self.colLength
                    result.cellStatus(j,self.rowLength + 1 - i) = self.cellStatus(i,j);
                end
            end
        end
        
        function result = showMapMatrixImg(self)
            result = zeros(self.rowLength, self.colLength, 3);
            for i = 1 : self.rowLength
                for j = 1 : self.colLength
                    temp = self.cellStatus(i,j);
                    if (temp == 0)
                        result(i,j,:) = [255,255,255];
                    elseif (temp == 1)
                        result(i,j,:) = [0,0,0];
                    elseif (temp == 2)
                        result(i,j,:) = [0,255,0];
                    elseif (temp == 3)
                        result(i,j,:) = [255,0,0];
                    elseif (temp == 4)
                        result(i,j,:) = [0,0,255];
                    elseif (temp == 5)
                        result(i,j,:) = [102/255,204/255,255/255];
                    end
                end
            end
        end
        
        function result = pointToXYCor(self,point)
            result = [point(2), self.rowLength + 1 - point(1)];
        end
        

        
    end
end