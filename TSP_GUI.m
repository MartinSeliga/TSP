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
    handles.CoP = 200; % Count of population for genetic alg
    handles.generations = 1000;
    handles.gen = handles.generations;
    handles.fit = 1;
    handles.metric = 'e';
    
    % init for freez.m
    handles.rb1 = handles.radiobutton1.Enable;
    handles.rb2 = handles.radiobutton2.Enable;
    handles.rb3 = handles.radiobutton3.Enable;
    handles.pb1 = handles.pushbutton1.Enable;
    handles.pb2 = handles.pushbutton2.Enable;
    handles.pb3 = handles.pushbutton3.Enable;
    handles.pb4 = handles.pushbutton4.Enable;
    handles.pb5 = handles.pushbutton5.Enable;
    handles.pm1 = handles.popupmenu1.Enable;
    handles.cb1 = handles.checkbox1.Enable;
    handles.pm3 = handles.popupmenu3.Enable;
    poolobj = gcp('nocreate');
    if (~isempty(poolobj))
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
        perm works realy fast, unfortunately it's causing 
        high memory consumption cause it's generate double.
        (double = 8 bytes)
        
        if CoC = 11 then perms take approx. 3.27 GB of RAM
        15 -> 143 TB :D
    
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
            handles.text8.Enable = 'off';
            handles.edit1.Enable = 'off';
            handles.text9.Enable = 'off';
            handles.edit2.Enable = 'off';
            handles.text10.Enable = 'off';
            handles.edit3.Enable = 'off';
            handles.text1.String =  ...
                strcat({'Cities:    '}, num2str(handles.CoC));
            cla(handles.axes1);    
            draw(handles, 1);
        case 'radiobutton2'
            if (handles.alg == 1)
                handles.CoC = 100;
                handles.cities = rand(handles.CoC, 2);
                handles.text1.String =  ...
                    strcat({'Cities:    '}, num2str(handles.CoC));
                handles.pushbutton3.Enable = 'on';
            end
            handles.alg = 2;
            handles.text8.Enable = 'off';
            handles.edit1.Enable = 'off';
            handles.text9.Enable = 'off';
            handles.edit2.Enable = 'off';
            handles.text10.Enable = 'off';
            handles.edit3.Enable = 'off';
            cla(handles.axes1);    
            draw(handles, 1);
        case 'radiobutton3'
            if (handles.alg == 1)
                handles.CoC = 100;
                handles.cities = rand(handles.CoC, 2);
                handles.text1.String =  ...
                    strcat({'Cities:    '}, num2str(handles.CoC));
                handles.pushbutton3.Enable = 'on';
            end
            handles.alg = 3;
            handles.text8.Enable = 'on';
            handles.edit1.Enable = 'on';
            handles.text9.Enable = 'on';
            handles.edit2.Enable = 'on';
            handles.text10.Enable = 'on';
            handles.edit3.Enable = 'on';
            cla(handles.axes1);    
            draw(handles, 1);
    end
    
guidata(hObject, handles);


function pushbutton2_Callback(hObject, ~, handles)
% add city
    if (handles.alg == 1)
        handles.CoC = handles.CoC+1;
        handles = addCity(handles, 1);
    elseif (handles.alg == 2 || handles.alg == 3)
        handles.CoC = handles.CoC+10;
        handles = addCity(handles, 10);
    end
    handles.text1.String = ...
        strcat({'Cities:    '}, num2str(handles.CoC));
    handles.pushbutton3.Enable = 'on';
    cla(handles.axes1);
    draw(handles, 1);    
        
guidata(hObject, handles);


function pushbutton3_Callback(hObject, ~, handles)
% remove last added city/cities
    if (handles.alg == 1)
        handles.CoC = handles.CoC-1;
        handles = addCity(handles, -1);
    elseif (handles.alg == 2 || handles.alg == 3)
        handles.CoC = handles.CoC-10;
        handles = addCity(handles, -10);
    end
    handles.text1.String = ...
        strcat({'Cities:    '}, num2str(handles.CoC));
    if (handles.CoC <= 4 && handles.alg == 1)
        handles.pushbutton3.Enable = 'off';
    elseif (handles.CoC <= 10 && (handles.alg == 2 || handles.alg == 3))
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
            handles.checkbox1.Value = 0;
    end
    
guidata(hObject, handles);


function pushbutton4_Callback(hObject, ~, handles)
% new random position
    handles.cities = rand(handles.CoC, 2);
    handles.permCities = handles.cities;
    
    cla(handles.axes1);
    draw(handles, 1);
    
guidata(hObject, handles);


function pushbutton1_Callback(hObject, ~, handles)
% start
    handles.bestDist = distance(handles.cities, handles.metric); % Current best distance
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
    elseif (handles.alg == 3)
        handles.fitness = zeros(handles.CoP, 1);
        handles.bestFitness = 0;
        handles.text7.String = {'Running genetic...'};
        handles = freez(handles, 1);
        pause(0.0);
        tic;
        handles = genetic(handles);
    end
    q = datestr(toc/86400, 'MM:SS.FFF');
    handles = freez(handles, 0);
    status = strcat({'Complete! Runtime '}, q);
    if (handles.alg == 1)
        status = strcat(status, {'. The shortest distance is '}...
            , num2str(handles.bestDist), '.');
    elseif (handles.alg == 2)
        status = strcat(status, {'. The shortest distance found is '},...
            num2str(handles.bestDist), '.');
    elseif (handles.alg == 3)
        status = strcat(status, {'. The shortest distance found in '},...
            num2str(handles.gen), {'th generation and it is '},...
            num2str(handles.bestDist), {', with fitness '},...
            num2str(handles.bestFitness), {'.'});
    end
    handles.text7.String = status;
    poolobj = gcp('nocreate');
    if isempty(poolobj)
        handles.pushbutton5.String = 'Start parallel pool';
    end
    
guidata(hObject, handles);


function checkbox1_Callback(hObject, ~, handles)
% run in parallel only without visualization
    if (handles.checkbox1.Value == 1)
        poolobj = gcp('nocreate');
        if isempty(poolobj)
            handles.checkbox1.Value = 0;
            msgbox('Start parallel pool first.','Warning', 'warn');
        else
            handles.popupmenu1.Value = 3;
            handles.draw = 3;        
        end
    end

guidata(hObject, handles);


function pushbutton5_Callback(hObject, ~, handles)
% start/stop parallel pool
    poolobj = gcp('nocreate');
    if isempty(poolobj)
        handles = freez(handles, 1);
        handles.text7.String = {'Starting parallel pool...'};
        pause(0.0);
        parpool;
        handles = freez(handles, 0);
        handles.pushbutton5.String = 'Stop parallel pool';
        handles.text7.String = {'Parallel pool has been started...'};
    else
        delete(poolobj);
        handles.pushbutton5.String = 'Start parallel pool';
    end    
    
guidata(hObject, handles);


function edit1_Callback(hObject, ~, handles)
    q = ceil(str2double(get(hObject,'String')));
    if (isnan(q))
        set(hObject,'String',handles.CoP);
        warndlg('Really?');
    elseif (q < 2)
        set(hObject,'String',handles.CoP);
        warndlg('Input must be from interval <2,inf>.');
    else
        handles.CoP = q;
    end
    
guidata(hObject, handles);


function edit2_Callback(hObject, ~, handles)
    q = ceil(str2double(get(hObject,'String')));
    if (isnan(q))
        set(hObject,'String',handles.generations);
        warndlg('Really?');
    elseif (q < 2)
        set(hObject,'String',handles.generations);
        warndlg('Input must be from interval <2,inf>.');
    else
        handles.generations = q;
    end
    
guidata(hObject, handles);


function edit3_Callback(hObject, ~, handles)
    q = str2double(get(hObject,'String'));
    if (isnan(q))
        set(hObject,'String',handles.fit);
        warndlg('Really?');
    elseif (q > 1 || q < 0)
        set(hObject,'String',handles.fit);
        warndlg('Input must be from interval <0,1>.');
    else
        handles.fit = q;
    end
    
guidata(hObject, handles);


function popupmenu3_Callback(hObject, eventdata, handles)
% compute distance
    switch get(hObject, 'Value')
        case 1
            handles.metric = 'e';
        case 2
            handles.metric = 'm';
    end
    
guidata(hObject, handles);



function popupmenu1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu3_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
