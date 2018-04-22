function handles = brute(handles)
    z = factorial(handles.CoC-1);
    if (handles.draw == 1 || handles.draw == 2)
        for i = 1:z
            d = distance(handles.permCities, handles.metric);
            tempDist = handles.bestDist;
            if d < handles.bestDist
                handles.bestDist = d;
                handles.bestSolution = handles.permCities;
            end
            if (handles.draw == 1)
                cla(handles.axes1);
                draw(handles, 2);
                handles.text7.String = ...
                    strcat({'Running brute force...'}, {'currently '}, ...
                     num2str(round(((i/z)*100),2)), {'% done.'});
                pause(0.0);
            elseif (handles.draw == 2 && d < tempDist)
                cla(handles.axes1);
                draw(handles, 3);
                handles.text7.String = ...
                    strcat({'Running brute force...'}, {'currently '}, ...
                     num2str(round(((i/z)*100),2)), {'% done.'});
                pause(0.0);
            end
            handles.permutation = next_perm(handles.permutation);
            handles.permCities = handles.cities(handles.permutation,:);
        end
    elseif (handles.draw == 3)
        if (handles.checkbox1.Value == 1)
            p = 1;
            q = handles.CoC;
            while q > 11
                p = p * q;
                q = q - 1;
            end
            for i = 1:p
                precompute = zeros(ceil(z/p),handles.CoC);
                precompute(1,:) = handles.permutation;
                for j = 2:ceil(z/p)
                    precompute(j,:) = next_perm(precompute(j-1,:));
                end
                handles.permutation = precompute(j,:);
                dists = 1:ceil(z/p);
                cities = handles.cities;
                metric = handles.metric;
                
                parfor j = 1:ceil(z/p)
                    dists(j) = distance(cities(precompute(j,:),:), metric);
                end
                
                [d, index] = min(dists);
                if (d < handles.bestDist)
                    handles.bestDist = d;
                    handles.bestSolution = handles.cities(precompute(index,:),:);
                end
            end
        else
            for i = 1:z
                d = distance(handles.permCities, handles.metric);
                if (d < handles.bestDist)
                    handles.bestDist = d;
                    handles.bestSolution = handles.permCities;
                end
                handles.permutation = next_perm(handles.permutation);
                handles.permCities = handles.cities(handles.permutation,:);
            end
        end
        cla(handles.axes1);
        draw(handles, 3);        
    end
    %{
    it's not possible to run computing in parallel due to 
    dependencies of permutation
    next_perm is clearly dependant on previous permutation :-/
    
    elseif (handles.draw == 3)
        cities = handles.cities;
        perm = 1:handles.CoC;
        best = handles.bestDist;
        bestPerm = perm;
        parfor i = 1:z
            d = distance(cities(perm,:), handles.metric);
            if (d < best)
                best = d;
                bestPerm = perm;
            end
            perm = next_perm(perm);
        end
        cla(handles.axes1);
        draw(handles, 3);        
    end
    %}
end