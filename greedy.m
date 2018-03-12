function handles =greedy(handles)
    n = length(handles.cities);
    distM = squareform(pdist(handles.cities));
    for i = 1:n
        d = 0;
        this = 1:n;
        visited = zeros(1,n);
        I = i;
        visited(I) = 1;
        this(1) = I;
        for j = 2:n
            dists = distM(I,:);
            dists(logical(visited)) = NaN;
            next = min(dists(~visited));
            J = find(dists == next,1);
            visited(J) = 1;
            this(j) = J;
            d = d+distM(I,J);
            I = J;
            handles.permCities = handles.cities(this,:);
            handles.permCities = handles.permCities(1:j,:);
            if (handles.draw == 1)
                cla(handles.axes1);
                draw(handles, 4);
                handles.text7.String = ...
                    strcat({'Running greedy...'}, {'currently '},...
                     num2str(round((100/n)*(i-1)+(100/n/(n-1))...
                     *(j-1),2)), {'% done.'});
                pause(0.0);
            end
        end
        if (handles.draw == 1)
            %cla(handles.axes1);
            %draw(handles, 5);
            handles.text7.String = ...
                strcat({'Running greedy...'}, {'currently '}, ...
                 num2str(round((100/n)*i,2)), {'% done.'});
            pause(0.0);
        end
        d = d+distM(I,i);
        if (d < handles.bestDist)
            handles.bestDist = d;
            handles.bestSolution = handles.cities(this,:);  
            if (handles.draw == 2)
                cla(handles.axes1);
                draw(handles, 3);
                handles.text7.String = ...
                    strcat({'Running greedy...'}, {'currently '}, ...
                     num2str(round((100/n)*i,2)), {'% done.'});
                pause(0.0);
            end
        end
    end
    if (handles.draw == 1)
        draw(handles, 3);
    else
        cla(handles.axes1);
        draw(handles, 3);
    end
end