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
        
        % set cell status
        function self=setStatus(self,row,col,status)
            if(self.validPos(row,col))
                self.cellStatus(row,col) = status;
            else 
                fprintf("not a valid grid, set status failed.");
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
        
        function self=setParent(self,row,col,prow,pcol)
           if (self.validPos(row,col) && self.validPos(prow,pcol))
               self.parent{row,col} = [prow,pcol];
           else
                fprintf("not a valid grid, set parent failed.");
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
    end     
end