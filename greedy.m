function handles = greedy(handles)
    n = length(handles.cities);
    distM = squareform(pdist(handles.cities));
    if (handles.draw == 1 || handles.draw == 2)
        for i = 1:n
            d = 0;
            % current = greedy start from city i
            current = 1:n;
            visited = zeros(1,n);
            current(1) = i;            
            visited(i) = 1;
            I = i;
            for j = 2:n
                dists = distM(I,:);
                J = find(dists == min(dists(~visited)),1);
                visited(J) = 1;
                current(j) = J;
                d = d+distM(I,J);
                I = J;
                if (handles.draw == 1)
                    handles.permCities = handles.cities(current,:);
                    handles.permCities = handles.permCities(1:j,:);
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
                cla(handles.axes1);
                draw(handles, 5);
                handles.text7.String = ...
                    strcat({'Running greedy...'}, {'currently '}, ...
                     num2str(round((100/n)*i,2)), {'% done.'});
                pause(0.0);
            end
            d = d+distM(I,i);
            if (d < handles.bestDist)
                handles.bestDist = d;
                handles.bestSolution = handles.cities(current,:);  
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
        cla(handles.axes1);
        draw(handles, 3);
    elseif (handles.draw == 3)
        tours = zeros(n,n);
        distH = zeros(1,n);
        if (handles.checkbox1.Value == 1)
            parfor i = 1:n
                d = 0;
                current = 1:n;
                visited = zeros(1,n);
                visited(i) = 1;
                current(1) = i;
                I = i;
                for j = 2:n
                    dists = distM(I,:);
                    J = find(dists == min(dists(~visited)),1);
                    visited(J) = 1;
                    current(j) = J;
                    d = d+distM(I,J);
                    I = J;
                end
                d = d+distM(I,i);
                tours(i,:) = current;
                distH(i) = d;
            end
        elseif (handles.checkbox1.Value == 0)
            for i = 1:n
                d = 0;
                current = 1:n;
                visited = zeros(1,n);
                visited(i) = 1;
                current(1) = i;
                I = i;
                for j = 2:n
                    dists = distM(I,:);
                    J = find(dists == min(dists(~visited)),1);
                    visited(J) = 1;
                    current(j) = J;
                    d = d+distM(I,J);
                    I = J;
                end
                d = d+distM(I,i);
                tours(i,:) = current;
                distH(i) = d;
            end
        end
        handles.bestDist = min(distH);
        handles.bestSolution = handles.cities(...
            tours(find(distH == handles.bestDist,1),:),:);
        cla(handles.axes1);
        draw(handles, 3);
    end
end