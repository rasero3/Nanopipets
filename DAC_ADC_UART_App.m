classdef DAC_ADC_UART_App < matlab.apps.AppBase
    properties (Access = public)
        UIFigure matlab.ui.Figure
        Sliders matlab.ui.control.Slider
        VoltageEdits matlab.ui.control.NumericEditField
        SendButton matlab.ui.control.Button
        UARTReceiveAxes matlab.ui.control.UIAxes
        voltaje
        serialObj
        dataBuffer
    end
    properties (Access = private)
        serialByteBuffer uint8 = uint8([]);  % Buffer bytes sin procesar
    end
    methods (Access = private)
        function startupFcn(app)
            port = "COM9"; % Cambia según tu equipo
            baudRate = 115200;
            app.serialObj = serialport(port, baudRate);
           configureCallback(app.serialObj, "byte", 3, @app.uartDataReceived);
            app.dataBuffer = cell(1,8); % Para 8 canales
            % Inicializar buffers vacíos
            for k = 1:8
                app.dataBuffer{k} = [];
            end
            
            plot(app.UARTReceiveAxes, nan, nan);
            title(app.UARTReceiveAxes, 'Datos ADC recibidos');
            xlabel(app.UARTReceiveAxes, 'Muestra');
            ylabel(app.UARTReceiveAxes, 'Voltaje');
        end

        

        function dacCode = getDACCode(app, voltage)
            Vref = 2.5;
            gain = 1;
            division = 1;
            dacCode = round(voltage / (Vref * gain / division) * 65536);
            dacCode = max(0, min(dacCode, 65535));
        end

        function invByte = invertBits(app, byte)
            invByte = uint8(0);
            for i = 0:7
                bitVal = bitget(byte, i+1);
                invByte = bitor(invByte, bitshift(bitVal, 7 - i));
            end
        end

        function sendUART(app)
            for ch = 0:7
                voltage = app.VoltageEdits(ch+1).Value;
                if voltage > 0
                    dacCode = app.getDACCode(voltage);
                    cmdByte = uint8(ch+8);
                    byte2 = bitshift(dacCode, -8);
                    byte3 = bitand(dacCode, 255);
                    
                    cmdByteInv = app.invertBits(cmdByte);
                    byte2Inv = app.invertBits(byte2);
                    byte3Inv = app.invertBits(byte3);
                    
                    msg = uint8([cmdByteInv, byte2Inv, byte3Inv]);
                    write(app.serialObj, msg, "uint8");
                    pause(0.000001);
                end
            end
        end

        function uartDataReceived(app, src, ~)
            if isempty(app.serialByteBuffer)
                app.serialByteBuffer = uint8([]);
            end
        
            data = read(src, src.NumBytesAvailable, "uint8");
            app.serialByteBuffer = [app.serialByteBuffer, data];  % acumular bytes recibidos
        
            while length(app.serialByteBuffer) >= 3
                channel = double(app.invertirBits(app.serialByteBuffer(1)));                    % Canal raw (0-7)
        
                byte2Inv = app.invertirBits(app.serialByteBuffer(2));
                byte3Inv = app.invertirBits(app.serialByteBuffer(3));
        
                % Combinar los bytes en uint16
                rawValue = uint16(byte2Inv) * 256 + uint16(byte3Inv);
                % Interpretar como entero con signo int16 (complemento a dos)
                adcRaw = typecast(rawValue, 'int16');
        
                % Convertir a voltaje considerando rango bipolar ±2.5 V
                adcVal = double(adcRaw) * 2.5 / 32768;
        
                idx = channel + 1;  % Índice 1-based
                if idx >= 1 && idx <= 8
                    app.dataBuffer{idx} = [app.dataBuffer{idx}, adcVal];  % Acumular datos
                    fprintf('Canal %d - Voltaje recibido: %.4f V\n', channel, adcVal);
                end
                app.serialByteBuffer(1:3) = [];  % Eliminar bytes procesados
            end
            app.updatePlot();
        end
        
        function updatePlot(app)
            cla(app.UARTReceiveAxes);
            hold(app.UARTReceiveAxes, 'on');
            colors = lines(8);
            for ch = 1:8
                data = app.dataBuffer{ch};
                if ~isempty(data)
                    plot(app.UARTReceiveAxes, data, 'Color', colors(ch,:), 'DisplayName', sprintf('Canal %d', ch-1));
                end
            end
            hold(app.UARTReceiveAxes, 'off');
            legend(app.UARTReceiveAxes, 'show', 'Location', 'northeast');
            drawnow;
        end


        function SliderValueChanged(app, event, idx)
            app.VoltageEdits(idx).Value = event.Value;
        end

        function EditValueChanged(app, event, idx)
            val = app.VoltageEdits(idx).Value;
            if val < 0; val=0; elseif val>2.5; val=2.5; end
            app.VoltageEdits(idx).Value = val;
            app.Sliders(idx).Value = val;
        end

        function SendButtonPushed(app, event)
            app.sendUART();
        end
    end



    

    methods (Access = public)
        function app = DAC_ADC_UART_App
            createComponents(app)
            runStartupFcn(app, @(app)startupFcn(app))
            if nargout == 0
                clear app
            end
        end


        function createComponents(app)
            set(0, "Units", "pixels");
            screensize = get(0, 'ScreenSize');
            numChannels = 8;
            sliderSpacing = 100;
            sliderStartY = screensize(4)-50;
            sliderX = 60;
            editX = screensize(3)*1/6+sliderX+180;
            labelX = 60;
            
            app.UIFigure = uifigure('Position',screensize,'Name','DAC & ADC UART');
            app.UIFigure.WindowState = 'maximized';
            graphwidth = screensize(3)*2/3;
            graphheight = screensize(4);
            app.UARTReceiveAxes = uiaxes(app.UIFigure, ...
                'Position', [screensize(3)-graphwidth screensize(4)-graphheight graphwidth graphheight]);

            title(app.UARTReceiveAxes, 'Datos ADC recibidos');
            xlabel(app.UARTReceiveAxes, 'Muestra');
            ylabel(app.UARTReceiveAxes, 'Voltaje');



            for k = 1:numChannels
                y = sliderStartY - (k-1)*sliderSpacing;
                uilabel(app.UIFigure, 'Position',[labelX y+5 80 22], ...
                    'Text', sprintf('Channel: %d:', k-1));
                app.Sliders(k) = uislider(app.UIFigure, ...
                    'Position', [sliderX y screensize(3)*1/6+160 3], ...
                    'Limits',[0 2.5], ...
                    'ValueChangedFcn',@(s,e)app.SliderValueChanged(e,k));
                app.VoltageEdits(k) = uieditfield(app.UIFigure,'numeric', ...
                    'Position',[editX y-10 50 22], ...
                    'Limits',[0 2.5], ...
                    'ValueChangedFcn',@(s,e)app.EditValueChanged(e,k));
            end
            app.SendButton = uibutton(app.UIFigure, ...
                'Text','Enviar', ...
                'Position',[250 40 100 30], ...
                'ButtonPushedFcn',@(s,e)app.SendButtonPushed(e));
        end
    end
end
