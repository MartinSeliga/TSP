function [parentA, parentB] = selection(population, fitness, selection, wheelFitness, n, prob)
    pop = population;
    wf = wheelFitness;
    if (selection == 1)
        % Random Selection
        % select random parents
        index = randperm(n, 1);
        parentA = pop(index,:);
        pop(index,:) = [];
        parentB = pop(randperm(n-1, 1),:);
        
    elseif (selection == 2)
        % Cutting Selection
        % select random from top prob%
        index = randperm(ceil(n*prob), 1);
        parentA = pop(index,:);
        pop(index,:) = [];
        parentB = pop(randperm(ceil(n*prob), 1),:);
        
    elseif (selection == 3)
        % Tournament Selection
        % select random 10% and take one with the best fitness
        index = find(fitness == max(fitness(randperm(n, ceil(n/10)))),1);
        parentA = pop(index,:);
        pop(index,:) = [];
        parentB = pop(find(fitness == max(fitness(randperm(n-1, ceil(n/10)))),1),:);
    
    elseif (selection == 4)
        % Roulette Selection
        % not really good for bigger CoC
        i = rand;
        index = find(wf > i,1);
        parentA = pop(index,:);
        wf(index,:) = [];
        pop(index,:) = [];
        j = rand;
        parentB = pop(find(wf > j,1),:);
        if (length(parentA) < 1)
            parentA = pop(n-1,:);
        end
        if (length(parentB) < 1)
            parentB = pop(n-1,:);
        end
    end
end












