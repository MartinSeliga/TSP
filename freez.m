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
        handles.pb6 = handles.pushbutton6.Enable;
        handles.pb7 = handles.pushbutton7.Enable;
        handles.pm1 = handles.popupmenu1.Enable;
        handles.cb1 = handles.checkbox1.Enable;
        handles.pm3 = handles.popupmenu3.Enable;
        handles.pm4 = handles.popupmenu4.Enable;
        handles.pm5 = handles.popupmenu5.Enable;
        handles.pm6 = handles.popupmenu6.Enable;
        handles.ed1 = handles.edit1.Enable;
        handles.ed2 = handles.edit2.Enable;
        handles.ed3 = handles.edit3.Enable;
        handles.ed5 = handles.edit5.Enable;
        handles.ed6 = handles.edit6.Enable;
        handles.ed7 = handles.edit7.Enable;
        
        handles.radiobutton1.Enable = 'off';
        handles.radiobutton2.Enable = 'off';
        handles.radiobutton3.Enable = 'off';
        handles.pushbutton1.Enable = 'off';
        handles.pushbutton2.Enable = 'off';
        handles.pushbutton3.Enable = 'off';
        handles.pushbutton4.Enable = 'off';
        handles.pushbutton5.Enable = 'off';
        handles.pushbutton6.Enable = 'off';
        handles.pushbutton7.Enable = 'off';
        handles.popupmenu1.Enable = 'off';
        handles.checkbox1.Enable = 'off';
        handles.popupmenu3.Enable = 'off';
        handles.popupmenu4.Enable = 'off';
        handles.popupmenu5.Enable = 'off';
        handles.popupmenu6.Enable = 'off';
        handles.edit1.Enable = 'off';
        handles.edit2.Enable = 'off';
        handles.edit3.Enable = 'off';
        handles.edit5.Enable = 'off';
        handles.edit6.Enable = 'off';
        handles.edit7.Enable = 'off';
    elseif (mode == 0)
        handles.radiobutton1.Enable = handles.rb1;
        handles.radiobutton2.Enable = handles.rb2;
        handles.radiobutton3.Enable = handles.rb3;
        handles.pushbutton1.Enable = handles.pb1;
        handles.pushbutton2.Enable = handles.pb2;
        handles.pushbutton3.Enable = handles.pb3;
        handles.pushbutton4.Enable = handles.pb4;
        handles.pushbutton5.Enable = handles.pb5;
        handles.pushbutton6.Enable = handles.pb6;
        handles.pushbutton7.Enable = handles.pb7;
        handles.popupmenu1.Enable = handles.pm1;
        handles.checkbox1.Enable = handles.cb1;
        handles.popupmenu3.Enable = handles.pm3;
        handles.popupmenu4.Enable = handles.pm4;
        handles.popupmenu5.Enable = handles.pm5;
        handles.popupmenu6.Enable = handles.pm6;
        handles.edit1.Enable = handles.ed1;
        handles.edit2.Enable = handles.ed2;
        handles.edit3.Enable = handles.ed3;
        handles.edit5.Enable = handles.ed5;
        handles.edit6.Enable = handles.ed6;
        handles.edit7.Enable = handles.ed7;
    end
end