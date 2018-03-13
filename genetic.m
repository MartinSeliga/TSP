function handles = genetic(handles)
%{  
    100 cities, 100000 population
    parallel computing running approx. 4 times longer!
 
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
    handles.population = zeros(handles.CoP, handles.CoC);
    % first generation
    for i = 1:handles.CoP
        handles.population(i,:) = randperm(handles.CoC);
        handles.fitness(i,1) = 1/(distance(handles.cities...
            (handles.population(i,:),:))+1);
        if (handles.fitness(i,1) > handles.bestFitness)
            handles.bestFitness = handles.fitness(i,1);
            handles.bestDist = distance(handles.cities...
                (handles.population(i,:),:));
            handles.bestSolution = handles.cities(handles.population(i,:),:);
        end
    end
    % draw the best
    if (handles.draw == 1)
        cla(handles.axes1);
        draw(handles, 6);
        handles.text7.String = ...
            strcat({'Running genetic...currently 1. generation.'},...
            {'Shortrest distance is '}, num2str(handles.bestDist), {'.'});
        pause(0.0);
    end
    % next generations
    n = handles.CoP;
    for i = 2:handles.generations
        % selection
        visited = zeros(n,1);
        order = zeros(n,1);
        for j = 1:n
            order(j) = find(handles.fitness == max(handles.fitness(~visited)),1);
            visited(order(j)) = 1;
        end
        handles.population = handles.population(order(:,1),:);
        % crossover
        
        % mutation
        for j = n/2+1:n
            handles.population(j,:) = swap(handles.population(j,:),...
                handles.CoC/10);            
        end
        % fitness
        for j = n/10:n
            handles.fitness(j,1) = 1/(distance(handles.cities...
                (handles.population(j,:),:))+1);
            if (handles.fitness(j,1) > handles.bestFitness)
                handles.bestFitness = handles.fitness(j,1);
                handles.bestDist = distance(handles.cities...
                    (handles.population(j,:),:));
                handles.bestSolution = handles.cities(handles.population(j,:),:);
            end
        end
        % draw the best in generation i
        if (handles.draw == 1)
            cla(handles.axes1);
            draw(handles, 6);
            handles.text7.String = ...
                strcat({'Running genetic...currently '},num2str(i),...
                {'. generation. Shortrest distance is '}, num2str(...
                handles.bestDist), {'.'});
            pause(0.0);
        end
    end

end








%{
function fitness = calcFitness(cities, population, fitness, parallel)
    if (parallel == 1)
        parfor i = 1:length(population(:,1))
            fitness(i,1) = distance(cities(population(i,:),:));
        end
    elseif (parallel == 0)
        parfor i = 1:length(population(:,1))
            
        end
    end
end
%}