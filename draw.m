function draw(handles, mode)
    hold(handles.axes1, 'on');
    l = length(handles.permCities);
    if (mode == 1)
        x = handles.permCities(:,1);
        x(l+1) = x(1);
        y = handles.permCities(:,2);
        y(l+1) = y(1);
        plot(handles.axes1, x, y, 'o--', 'Color', [0.5 0.5 0.5],...
            'MarkerFaceColor',[0.5,0.5,0.5]);        
    elseif (mode == 2)
        bx = handles.bestSolution(:,1);
        bx(l+1) = bx(1);
        by = handles.bestSolution(:,2);
        by(l+1) = by(1);
        plot(handles.axes1, bx, by, 'b-o','MarkerFaceColor','b',...
            'MarkerEdgeColor','b',...%'MarkerSize',5,...
            'LineWidth',2);
    end 
end