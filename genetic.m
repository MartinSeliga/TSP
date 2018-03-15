function handles = genetic(handles)
%{  
    1000 cities, 1000 population
    Parallel computing running approx. 8 times longer
    cause split and merge takes longer time than
    computation itself.
 
    if (handles.checkbox1.Value == 1)
        population = zeros(handles.CoP, handles.CoC);
        parfor i = 1:handles.CoP
            population(i,:) = randperm(handles.CoC);
            fitness(i,1) = 1/(distance(handles.cities...
                (population(i,:),:))+1);
        end
    elseif (handles.checkbox1.Value == 0)
        handles.population = zeros(handles.CoP, handles.CoC);
        for i = 1:handles.CoP
            handles.population(i,:) = randperm(handles.CoC);
            handles.fitness(i,1) = 1/(distance(handles.cities...
                (handles.population(i,:),:))+1);
        end
    end
%}

    % first generation
    % maybe will be fine to have current best solutions or at least
    % top few percent from greedy as a members of population
    handles.population = zeros(handles.CoP, handles.CoC);
    for i = 1:handles.CoP
        handles.population(i,:) = randperm(handles.CoC);
        handles.fitness(i,1) = 1/(distance(handles.cities...
            (handles.population(i,:),:))+1);
        if (handles.fitness(i,1) > handles.bestFitness)
            handles.bestFitness = handles.fitness(i,1);
            handles.bestSolution = handles.cities(...
                handles.population(i,:),:);
            handles.bestDist = distance(handles.bestSolution);
        end
    end
    % draw the best
    if (handles.draw == 1 || handles.draw == 2)
        cla(handles.axes1);
        draw(handles, 6);
        handles.text7.String = ...
            strcat({'Running genetic...currently 1. generation.'},...
            {'Shortrest distance is '}, num2str(handles.bestDist),...
            {'. Best fitness is '}, num2str(handles.bestFitness), {'.'});
        pause(0.0);
    end
    
    n = handles.CoP;
    
    newFitness = handles.fitness;
    newPopulation = handles.population;
    
    if (n <= 100)
        part = ceil(n/10);
    else
        part = 10; 
    end
    
    % next generations
    for i = 2:handles.generations
        
        % initialize new population from the old one sorted by fitness
        [newFitness, order] = sort(newFitness, 'descend');
        newPopulation = newPopulation(order(:,1),:);
        
        % Genetic
        % (1:part -> Survivors for new population)
        if (handles.checkbox1.Value == 1)
            parfor j = part+1:n

                % Tournament Selection
                % select random 10% and take one with best fitness
                parentA = handles.population(find(handles.fitness ==...
                    max(handles.fitness(randperm(n, ceil(n/10)))),1),:);
                parentB = handles.population(find(handles.fitness ==...
                    max(handles.fitness(randperm(n, ceil(n/10)))),1),:);

                % Crossover
                same = find(parentA==parentB);
                child = zeros(1, length(parentA));
                child(same) = parentA(same);
                diff = parentA(find(parentA~=parentB));
                if (length(diff) > 1)
                    diff = swap(diff,ceil(n/20));
                end
                child(child==0)=diff;
                newPopulation(j,:) = child;

                % Mutation
                if(randperm(4,1)==1)
                    newPopulation(j,:) = swap(newPopulation(j,:),1);
                end

                % Fitness
                newFitness(j,1) = 1/(distance(handles.cities(...
                    newPopulation(j,:),:))+1);            
            end
        else
            for j = part+1:n

                % Tournament Selection
                % select random 10% and take one with best fitness
                parentA = handles.population(find(handles.fitness ==...
                    max(handles.fitness(randperm(n, ceil(n/10)))),1),:);
                parentB = handles.population(find(handles.fitness ==...
                    max(handles.fitness(randperm(n, ceil(n/10)))),1),:);

                % Crossover
                same = find(parentA==parentB);
                child = zeros(1, length(parentA));
                child(same) = parentA(same);
                diff = parentA(find(parentA~=parentB));
                if (length(diff) > 1)
                    diff = swap(diff,ceil(n/20));
                end
                child(child==0)=diff;
                newPopulation(j,:) = child;

                % Mutation
                if(randperm(4,1)==1)
                    newPopulation(j,:) = swap(newPopulation(j,:),1);
                end

                % Fitness
                newFitness(j,1) = 1/(distance(handles.cities(...
                    newPopulation(j,:),:))+1);            
            end
        end
        
        handles.population = newPopulation;
        handles.fitness = newFitness;
        [handles.bestFitness, index] = max(newFitness);
        handles.bestSolution = handles.cities(handles.population...
            (index,:),:);
        handles.bestDist = distance(handles.bestSolution);
                
        
        % draw the best in generation i
        if (handles.draw == 1 || handles.draw == 2)
            cla(handles.axes1);
            draw(handles, 6);
            handles.text7.String = ...
                strcat({'Running genetic...currently '},num2str(i),...
                {'. generation. Shortrest distance is '}, num2str(...
                handles.bestDist), {'. Best fitness is '}, num2str(...
                handles.bestFitness), {'.'});
            pause(0.0);
        end
        
        handles.gen = i;
        if (handles.bestFitness > handles.fit)
            break;
        end
    end
    cla(handles.axes1);
    draw(handles, 3);
end


