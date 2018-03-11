function brute(hObject, handles)
    z = factorial(handles.CoC);
    if (handles.draw < 3)
        for i = 1:z
            handles.text7.String = ...
                strcat({'Running brute force...'}, {'done: '}, ...
                 num2str(round(((i/z)*100),2)), {'%'});
            d = distance(handles.permCities);
            if d < handles.bestDist
                handles.bestDist = d;
                handles.bestSolution = handles.permCities;
            end
            if (handles.draw == 1)
                cla(handles.axes1);
                draw(handles, 1);
                draw(handles, 2);
                pause(0.0);
            elseif (d == handles.bestDist)
                cla(handles.axes1);
                draw(handles, 2);
                pause(0.0);
            end
            handles.permutation = next_perm(handles.permutation);
            handles.permCities = handles.cities(handles.permutation,:);
        end
    else
        for i = 1:z
            d = distance(handles.permCities);
            if d < handles.bestDist
                handles.bestDist = d;
                handles.bestSolution = handles.permCities;
            end
            handles.permutation = next_perm(handles.permutation);
            handles.permCities = handles.cities(handles.permutation,:);
        end
        draw(handles, 2);        
    end
%guidata(hObject, handles);
end