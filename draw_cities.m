function draw_cities(handles)
    hold(handles.axes1, 'on');
    l = length(handles.cities);
    x = handles.cities(:,1);
    x(l+1) = x(1);
    y = handles.cities(:,2);
    y(l+1) = y(1);
    plot(handles.axes1, x, y, 'o', 'Color', [0.5 0.5 0.5],...
        'MarkerFaceColor',[0.5,0.5,0.5])      
end