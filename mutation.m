function [individual] = mutation(individual, mutation)
    n = length(individual);
    if (mutation == 1)
        % ISM mutation
        x1 = randperm(n,1);
        a = individual(x1);
        q = individual;
        q(x1) = [];
        x2 = randperm(n-1,1);
        individual(1:x2) = q(1:x2);
        individual(x2+1) = a;
        if (x2+1 < n)
            individual(x2+2:n) = q(x2+1:n-1);
        end
        
    elseif (mutation == 2)
        % DM mutation
        x1 = randperm(n-1,1);
        x2 = randperm(n-x1,1)+x1;
        a = individual(x1:x2);
        q = individual;
        q(x1:x2) = [];
        if (~isempty(q))
            x3 = randperm(length(q),1);
            individual(1:x3) = q(1:x3);
            individual(x3+1:x3+length(a)) = a;
            % n = 9, x1 = 5, x2 = 9, x3 = 3
            if (x3+length(a) < n)
                individual(x3+length(a)+1:n) = q(x3+1:length(q));
            end
        else
            individual = a;
        end
        
    elseif (mutation == 3)
        % EM mutation
        a = randperm(n,2);
        q = individual(a(1));
        individual(a(1)) = individual(a(2));
        individual(a(2)) = q;
        
    elseif (mutation == 4)
        % IVM mutation
        x1 = randperm(n-1,1);
        x2 = randperm(n-x1,1)+x1;
        a = fliplr(individual(x1:x2));
        q = individual;
        q(x1:x2) = [];
        if (~isempty(q))
            x3 = randperm(length(q),1);
            individual(1:x3) = q(1:x3);
            individual(x3+1:x3+length(a)) = a;
            if (x3+length(a) < n)
                individual(x3+length(a)+1:n) = q(x3+1:length(q));
            end
        else
            individual = a;
        end        
    
    elseif (mutation == 5)
        % PSM mutation
        a = randperm(randperm(n,1));
        individual(1:length(a)) = individual(a);
        
    elseif (mutation == 6)
        % RMS mutation
        a = sort(randperm(n,3));
        q = individual(a(1));
        individual(a(1)) = individual(a(2));
        individual(a(2)) = individual(a(3));
        individual(a(3)) = q;
    end
end