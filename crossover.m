function [childA, childB] = crossover(parentA, parentB, crossover)
    n = length(parentA);
    childA = zeros(1,n);
    childB = zeros(1,n);
    if (crossover == 1)
        % PMX crossover 
        x1 = randperm(n-1,1);
        x2 = randperm(n-x1,1)+x1;
        
        childA(x1:x2) = parentB(x1:x2);
        childB(x1:x2) = parentA(x1:x2);
        
        for i = 1:x2-x1+1
            mapRelation(1:2,i)=[childA(x1+i-1), childB(x1+i-1)]; 
        end
        
        for i = 1:x1-1
            if(length(find(childA == parentA(i))) < 1)
                childA(i) = parentA(i);
            end
            if(length(find(childB == parentB(i))) < 1)
                childB(i) = parentB(i);
            end
        end
        for i = x2+1:n
            if(isempty(find(childA == parentA(i),1)))
                childA(i) = parentA(i);
            end
            if(isempty(find(childB == parentB(i),1)))
                childB(i) = parentB(i);
            end
        end
        
        while(~isempty(find(childA == 0,1)))
            mapA = mapRelation;
            i = find(childA == 0,1);
            v = parentA(i);
            while (~isempty(find(mapA == v,1)))
                [j, k] = find(mapA == v,1);
                if (j == 1)
                    v = mapA(2,k);
                else
                    v = mapA(1,k);
                end
                mapA(:,k) = [];
            end
            childA(i) = v;            
        end
        
        while(~isempty(find(childB == 0,1)))
            mapB = mapRelation;
            i = find(childB == 0,1);
            v = parentB(i);
            while (~isempty(find(mapB == v,1)))
                [j, k] = find(mapB == v,1);
                if (j == 1)
                    v = mapB(2,k);
                else
                    v = mapB(1,k);
                end
                mapB(:,k) = [];
            end
            childB(i) = v;            
        end
        
    elseif (crossover == 2)
        % OX crossover
        x1 = randperm(n-1,1);
        x2 = randperm(n-x1,1)+x1;
        
        childA(x1:x2) = parentA(x1:x2);
        childB(x1:x2) = parentB(x1:x2);
        
        if (x2 < n)
            j = x2+1;
            i = x2+1;
        else
            j = 1;
            i = 1;
        end
        while(i ~= x1)
            while (~isempty(find(childA == parentB(j),1)))
                j = j + 1;
                if (j > n)
                    j = 1;
                end
            end
            childA(i) = parentB(j);
            i = i + 1;
            if (i > n)
                i = 1;
            end
        end
        if (x2 < n)
            j = x2+1;
            i = x2+1;
        else
            j = 1;
            i = 1;
        end
        while(i ~= x1)
            while (~isempty(find(childB == parentA(j),1)))
                j = j + 1;
                if (j > n)
                    j = 1;
                end
            end
            childB(i) = parentA(j);
            i = i + 1;
            if (i > n)
                i = 1;
            end
        end
    
    elseif (crossover == 3)
        % CX crossover
        i = 1;
        childA(1) = parentA(1);
        p = parentA;
        while (~isempty(find(p == parentB(i),1)))
            i = find(p == parentB(i),1);
            childA(i) = parentA(i);
            p(i) = 0;
        end
        for i = 2:n
            if childA(i) == 0
                childA(i) = parentB(i);
            end
        end
        i = 1;
        childB(1) = parentB(1);
        p = parentB;
        while (~isempty(find(p == parentA(i),1)))
            i = find(p == parentA(i),1);
            childB(i) = parentB(i);
            p(i) = 0;
        end
        for i = 2:n
            if childB(i) == 0
                childB(i) = parentA(i);
            end
        end
        
    elseif (crossover == 4)
        % my own :) ... not a good one, really
        same = find(parentA==parentB);
        childA = zeros(1, length(parentA));
        childA(same) = parentA(same);
        diff = parentA(find(parentA~=parentB));
        if (length(diff) > 1)
            diff = swap(diff,ceil(n/20));
        end
        childA(childA==0)=diff;
    end
end