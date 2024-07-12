function canshu=PAS_FD_CheckPZ(hObject, eventdata, handles)
FIDpz=fopen('PAS配置文件.log','r');
while ~feof(FIDpz)
    tmp=fgetl(FIDpz);
    switch tmp(1)
        case '#'
            continue;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        case '1'%绘图
            switch tmp(3)
                case '1'%一般曲线绘制
                    while ~feof(FIDpz)
                        tmp=fgetl(FIDpz);
                        switch tmp(1)
                            case '#'
                                continue;
                            case '0'
                                canshu11=strsplit(tmp,',');
                                if length(canshu11)<11
                                    errordlg('配置文件中一般曲线配置的参数个数不够！');
                                    fclose(FIDpz);
                                    return;
                                end
                                canshu11=canshu11(2:end);
                                break;
                            otherwise
                                errordlg('配置文件中缺少一般曲线配置的参数行！');
                                fclose(FIDpz);
                                return;
                        end
                    end
                otherwise
                    errordlg('配置文件中定义了没有的菜单项！');
                    fclose(FIDpz);
                    return;
            end
            continue;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        case '3'%异常模版识别
            switch tmp(3)
                case '1'%曲线形态类比（同测项追溯）
                    while ~feof(FIDpz)
                        tmp=fgetl(FIDpz);
                        switch tmp(1)
                            case '#'
                                continue;
                            otherwise
                                if isempty(str2num(tmp))%不是数字
                                    errordlg('配置文件中曲线形态类比（同测项追溯）的参数行设置错误！');
                                    fclose(FIDpz);
                                    return;
                                else
                                    canshu31={tmp};
                                    break;
                                end
                        end
                    end
                    continue;
                case '2'%曲线形态类比（多测项）
                    while ~feof(FIDpz)
                        tmp=fgetl(FIDpz);
                        switch tmp(1)
                            case '#'
                                continue;
                            otherwise
                                if isempty(str2num(tmp))%不是数字
                                    errordlg('配置文件中曲线形态类比（多测项）的参数行设置错误！');
                                    fclose(FIDpz);
                                    return;
                                else
                                    canshu32={tmp};
                                    break;
                                end
                        end
                    end
                    continue;
                otherwise
            end
            continue;
        case '4'%潮汐分析
            switch tmp(3)
                case '1'%数据检查
                    while ~feof(FIDpz)
                        tmp=fgetl(FIDpz);
                        switch tmp(1)
                            case '#'
                                continue;
                            otherwise
                                if isempty(str2num(tmp))%不是数字
                                    errordlg('配置文件中数据检查的参数行设置错误！');
                                    fclose(FIDpz);
                                    return;
                                else
                                    canshu41={tmp};
                                    break;
                                end
                        end
                    end
                    continue;
                case '2'%潮汐因子玫瑰图计算及成图
                    while ~feof(FIDpz)
                        tmp=fgetl(FIDpz);
                        switch tmp(1)
                            case '#'
                                continue;
                            otherwise
                                if isempty(str2num(tmp))%不是数字
                                    errordlg('配置文件中潮汐因子玫瑰图计算及成图的参数行设置错误！');
                                    fclose(FIDpz);
                                    return;
                                else
                                    canshu42={tmp};
                                    break;
                                end
                        end
                    end
                    continue;
                case '3'%由结果绘玫瑰图
                    while ~feof(FIDpz)
                        tmp=fgetl(FIDpz);
                        switch tmp(1)
                            case '#'
                                continue;
                            otherwise
                                if isempty(str2num(tmp))%不是数字
                                    errordlg('配置文件中由结果绘玫瑰图的参数行设置错误！');
                                    fclose(FIDpz);
                                    return;
                                else
                                    canshu43={tmp};
                                    break;
                                end
                        end
                    end
                    continue;
                case '4'%由结果绘指定方位潮汐因子
                    while ~feof(FIDpz)
                        tmp=fgetl(FIDpz);
                        switch tmp(1)
                            case '#'
                                continue;
                            otherwise
                                if isempty(str2num(tmp))%不是数字
                                    errordlg('配置文件中由结果绘指定方位潮汐因子的参数行设置错误！');
                                    fclose(FIDpz);
                                    return;
                                else
                                    canshu44={tmp};
                                    break;
                                end
                        end
                    end
                    continue;
                otherwise
            end
            continue;
        otherwise
            errordlg('定义了没有的菜单项！');
            fclose(FIDpz);
            return;
    end
end

canshu.canshu11=canshu11;
canshu.canshu31=canshu31;
canshu.canshu32=canshu32;
canshu.canshu41=canshu41;
canshu.canshu42=canshu42;
canshu.canshu43=canshu43;
canshu.canshu44=canshu44;

fclose(FIDpz);
