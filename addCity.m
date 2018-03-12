function handles = addCity(handles, count)
    if (count > 0)
        for i =1:count
            handles.cities(length(handles.cities)+1,1) =  rand(1);
            handles.cities(length(handles.cities),2) =  rand(1);
        end
    elseif (count < 0)
        for i =1:count*-1
            handles.cities = handles.cities(1:end-1,:);
        end
    end
end