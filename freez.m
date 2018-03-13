function handles = freez (handles, mode)
    if (mode == 1)
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
        
        handles.radiobutton1.Enable = 'off';
        handles.radiobutton2.Enable = 'off';
        handles.radiobutton3.Enable = 'off';
        handles.pushbutton1.Enable = 'off';
        handles.pushbutton2.Enable = 'off';
        handles.pushbutton3.Enable = 'off';
        handles.pushbutton4.Enable = 'off';
        handles.pushbutton5.Enable = 'off';
        handles.popupmenu1.Enable = 'off';
        handles.checkbox1.Enable = 'off';
    elseif (mode == 0)
        handles.radiobutton1.Enable = handles.rb1;
        handles.radiobutton2.Enable = handles.rb2;
        handles.radiobutton3.Enable = handles.rb3;
        handles.pushbutton1.Enable = handles.pb1;
        handles.pushbutton2.Enable = handles.pb2;
        handles.pushbutton3.Enable = handles.pb3;
        handles.pushbutton4.Enable = handles.pb4;
        handles.pushbutton5.Enable = handles.pb5;
        handles.popupmenu1.Enable = handles.pm1;
        handles.checkbox1.Enable = handles.cb1;
    end
end