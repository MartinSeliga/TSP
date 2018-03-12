function handles = brute(handles)
    z = factorial(handles.CoC);
    if (handles.draw < 3)
        for i = 1:z
            d = distance(handles.permCities);
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
            elseif (d < tempDist)
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
        for i = 1:z
            d = distance(handles.permCities);
            if (d < handles.bestDist)
                handles.bestDist = d;
                handles.bestSolution = handles.permCities;
            end
            handles.permutation = next_perm(handles.permutation);
            handles.permCities = handles.cities(handles.permutation,:);
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
            d = distance(cities(perm,:));
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