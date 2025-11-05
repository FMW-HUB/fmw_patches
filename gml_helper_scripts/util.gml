function optionalOf(arg0, arg1)
{
    var globalVar = variable_global_get(arg0);
    var defaultVar = arg1;
    
    if (globalVar != undefined)
        return globalVar;
    else
        return arg1;
}

function config_mod_init()
{
    var fileInd = 0;
    var fileName = file_find_first("mods/*.json", 0);
    var files = [];
    
    while (fileName != "")
    {
        files[fileInd] = fileName;
        fileName = file_find_next();
        fileInd += 1;
    }
    
    var modListSize = array_length(files);
    
    for (var i = 0; i < modListSize; i++)
    {
        var f = file_text_open_read("mods/" + files[i]);
        var json = file_text_read_string(f);
        var modStruct = json_parse(json);
        var type = modStruct.Type;
        var dataVal;
        
        switch (type)
        {
            case 0:
                dataVal = bool(modStruct.Value);
                break;
            
            case 1:
                dataVal = string(modStruct.Value);
                break;
            
            case 2:
                dataVal = [int64(modStruct.Value), int64(modStruct.Min), int64(modStruct.Max)];
                break;
            
            default:
                dataVal = modStruct.Value;
                break;
        }
        
        variable_global_set(modStruct.Name, dataVal);
        struct_destroy(modStruct);
        file_text_close(f);
    }
}
