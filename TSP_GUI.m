function varargout = TSP_GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TSP_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TSP_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function TSP_GUI_OpeningFcn(hObject, ~, handles, varargin)
% GUI initialization
    handles.output = hObject;

    handles.alg = 1; % 1=brute, 2=greedy, 3=genetic
    handles.draw = 1; % 1=all, 2=best, 3=solution
    handles.CoC = 6; % Count of "cities"
    handles.cities = rand(handles.CoC, 2); % Initialize cities
    
    handles.rb1 = 'off';
    handles.rb2 = 'off';
    handles.rb3 = 'off';
    handles.pb1 = 'off';
    handles.pb2 = 'off';
    handles.pb3 = 'off';
    handles.pb4 = 'off';
    handles.pb5 = 'off';
    handles.pm1 = 'off';
    handles.cb1 = 'off';
    
    poolobj = gcp('nocreate');
    if ~isempty(poolobj)
        handles.pushbutton5.String = 'Stop parallel pool';
    end
    
    % refresh symbol for button
    a=imread('refresh-button.jpg');
    [r,c,d]=size(a); 
    x=ceil(r/30); 
    y=ceil(c/30); 
    g=a(1:x:end,1:y:end,:);
    g(g==255)=5.5*255;
    set(handles.pushbutton4,'CData',g);
    
    cla(handles.axes1);    
    draw(handles, 1);
    
    %{
        Creating all possible permutation with matlab function
        perm works realy fast, unfortunatelly it's causing 
        high memory consumptions cause it generates double.
        (double = 8 bytes)
        
        if CoC = 12 then perms take cca 7.14 GB of RAM
        16 -> 305 TB :D
    
        handles.permutations = perms(1:handles.CoC);    
    %}
    
guidata(hObject, handles);


function varargout = TSP_GUI_OutputFcn(~,~,~)
% no idea :)


function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% change algorithm
    switch get(eventdata.NewValue,'Tag')
        case 'radiobutton1'
            handles.alg = 1;
            handles.CoC = 6;
            handles.cities = rand(handles.CoC, 2);
            handles.pushbutton3.Enable = 'on';
            handles.checkbox1.Enable = 'off';
            handles.checkbox1.Value = 0;
            handles.text1.String =  ...
                strcat({'Count of cities: '}, num2str(handles.CoC));
            cla(handles.axes1);    
            draw(handles, 1);
        case 'radiobutton2'
            handles.alg = 2;
            handles.CoC = 100;
            handles.cities = rand(handles.CoC, 2);
            handles.pushbutton3.Enable = 'on';
            handles.checkbox1.Enable = 'on';
            handles.text1.String =  ...
                strcat({'Count of cities: '}, num2str(handles.CoC));
            cla(handles.axes1);    
            draw(handles, 1);
        case 'radiobutton3'
            handles.alg = 3;
    end
    
guidata(hObject, handles);


function pushbutton2_Callback(hObject, ~, handles)
% add city
    if (handles.alg == 1)
        handles.CoC = handles.CoC+1;
        handles = addCity(handles, 1);
    elseif (handles.alg == 2)
        handles.CoC = handles.CoC+10;
        handles = addCity(handles, 10);
    end
    handles.text1.String = ...
        strcat({'Count of cities: '}, num2str(handles.CoC));
    handles.pushbutton3.Enable = 'on';
    cla(handles.axes1);
    draw(handles, 1);    
        
guidata(hObject, handles);


function pushbutton3_Callback(hObject, ~, handles)
% remove last added city/cities
    if (handles.alg == 1)
        handles.CoC = handles.CoC-1;
        handles = addCity(handles, -1);
    elseif (handles.alg == 2)
        handles.CoC = handles.CoC-10;
        handles = addCity(handles, -10);
    end
    handles.text1.String = ...
        strcat({'Count of cities: '}, num2str(handles.CoC));
    if (handles.CoC <= 4 && handles.alg == 1)
        handles.pushbutton3.Enable = 'off';
    elseif ((handles.CoC <= 10 && handles.alg == 2))
        handles.pushbutton3.Enable = 'off';
    end
    cla(handles.axes1);
    draw(handles, 1);
    
guidata(hObject, handles);


function popupmenu1_Callback(hObject, ~, handles)
% visualisation
    switch get(hObject, 'Value')
        case 1
            handles.draw = 1;
            handles.checkbox1.Value = 0;
        case 2
            handles.draw = 2;
            handles.checkbox1.Value = 0;
        case 3
            handles.draw = 3;
    end
    
guidata(hObject, handles);


function popupmenu1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton4_Callback(hObject, ~, handles)
% new random position
    handles.cities = rand(handles.CoC, 2);
    handles.permCities = handles.cities;
    
    cla(handles.axes1);
    draw(handles, 1);
    
guidata(hObject, handles);


function pushbutton1_Callback(hObject, ~, handles)
%
    handles.bestDist = distance(handles.cities); % Current best distance
    handles.bestSolution = handles.cities; % Current best solution
    handles.permCities = handles.cities; % Copy for permutations
    if (handles.alg == 1)
        handles.permutation = 1:handles.CoC; % Current permutation
        handles.text7.String = {'Running brute force...'};
        handles = freez(handles, 1);
        pause(0.0);
        tic;
        handles = brute(handles);
    elseif (handles.alg == 2)
        handles.text7.String = {'Running greedy...'};
        handles = freez(handles, 1);
        pause(0.0);
        tic;
        handles = greedy(handles);
    else
        % not yet
    end
    q = datestr(toc/86400, 'MM:SS.FFF');
    handles = freez(handles, 0);
    handles.text7.String = strcat({'Complete! Runtime '}, q,...
        {'. Shortest distance is '}, num2str(handles.bestDist));
    
guidata(hObject, handles);


function checkbox1_Callback(hObject, eventdata, handles)
    if (handles.checkbox1.Value == 1)
        handles.popupmenu1.Value = 3;
        handles.draw = 3;
    else
        
    end

guidata(hObject, handles);


function pushbutton5_Callback(hObject, eventdata, handles)
    poolobj = gcp('nocreate'); % If no pool, do not create new one.
    if isempty(poolobj)
        handles = freez(handles, 1);
        pause(0.0);
        parpool;
        handles = freez(handles, 0);
        handles.pushbutton5.String = 'Stop parallel pool';
    else
        delete(poolobj);
        handles.pushbutton5.String = 'Start parallel pool';
    end
    
    
guidata(hObject, handles);
