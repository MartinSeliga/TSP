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


function TSP_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% GUI initialization
    handles.output = hObject;

    handles.alg = 1; % 1=brute, 2=greedy, 3=genetic
    handles.CoC = 4; % Count of "cities"
    handles.draw = 1; % 1=all, 2=best, 3=solution
    handles.cities = rand(handles.CoC, 2); % Initialize cities
    handles.bestDist = distance(handles.cities); % Current best distance
    handles.bestSolution = handles.cities; % Current best solution
    handles.permutation = 1:handles.CoC; % Current permutation
    handles.permCities = handles.cities; % Copy for permutations
    
    % refresh symbol for button
    [a,map]=imread('refresh-button.jpg');
    [r,c,d]=size(a); 
    x=ceil(r/30); 
    y=ceil(c/30); 
    g=a(1:x:end,1:y:end,:);
    g(g==255)=5.5*255;
    set(handles.pushbutton4,'CData',g);
    
    cla(handles.axes1);    
    draw_cities(handles);
    
    % high memory consumptions but working really fast
    %handles.permutations = perms(handles.permutation);
    
guidata(hObject, handles);


function varargout = TSP_GUI_OutputFcn(~,~,~)
% no idea :)


function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% change algorithm
    switch get(eventdata.NewValue,'Tag')
        case 'radiobutton1'
            handles.alg = 1;
        case 'radiobutton2'
            handles.alg = 2;
        case 'radiobutton3'
            handles.alg = 3;
    end
    
guidata(hObject, handles);


function pushbutton2_Callback(hObject, eventdata, handles)
% add city
    handles.CoC = handles.CoC+1;
    handles.text1.String = ...
        strcat({'Count of cities: '}, num2str(handles.CoC));
    handles.pushbutton3.Enable = 'on';
    handles.cities(length(handles.cities)+1,1) =  rand(1);
    handles.cities(length(handles.cities),2) =  rand(1);
    handles.permCities = handles.cities;
    handles.bestDist = distance(handles.cities);
    handles.bestSolution = handles.cities;
    handles.permutation = 1:handles.CoC;
    
    cla(handles.axes1);
    draw_cities(handles);    
        
guidata(hObject, handles);


function pushbutton3_Callback(hObject, eventdata, handles)
% remove last added city
    handles.CoC = handles.CoC-1;
    handles.text1.String = ...
        strcat({'Count of cities: '}, num2str(handles.CoC));
    if (handles.CoC <= 4)
        handles.pushbutton3.Enable = 'off';
    end
    handles.cities = handles.cities(1:end-1,:);
    handles.permCities = handles.cities;
    handles.bestDist = distance(handles.cities);
    handles.bestSolution = handles.cities;
    handles.permutation = 1:handles.CoC;
    
    cla(handles.axes1);
    draw_cities(handles);
    
guidata(hObject, handles);


function popupmenu1_Callback(hObject, ~, handles)
% visualisation
    switch get(hObject, 'Value')
        case 1
            handles.draw = 1;
        case 2
            handles.draw = 2;
        case 3
            handles.draw = 3;
    end
    
guidata(hObject, handles);


function popupmenu1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton4_Callback(hObject, eventdata, handles)
% new random position
    handles.cities = rand(handles.CoC, 2);
    handles.permCities = handles.cities;
    handles.bestDist = distance(handles.cities);
    handles.bestSolution = handles.cities;
    handles.permutation = 1:handles.CoC;
    
    cla(handles.axes1);
    draw_cities(handles);
    
guidata(hObject, handles);


function pushbutton1_Callback(hObject, eventdata, handles)
% 
if (handles.alg == 1)
    handles.text7.String = {'Running brute force...'};
    %set(handles.text7, 'String', 'Running brute force...');
    brute(hObject, handles);
elseif (handles.alg == 2)
    % not yet
else
    % not yet too
end



    
    
