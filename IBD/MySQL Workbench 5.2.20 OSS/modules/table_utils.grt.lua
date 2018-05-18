--
-- Workbench Utility Plugins
--


--
-- standard module/plugin functions
-- 

function getModuleInfo()
	return {
		name= "WbTableUtils",
		author= "MySQL AB.",
		version= "1.0",
		implements= "PluginInterface",
		functions= {
		"getPluginInfo:l<o@app.Plugin>:",
		"copyInsertToClipboard:i:o@db.Table"
		}
	}
end


-- helper function to create a descriptor for an argument of a specific type of object
function objectPluginInput(type)
	return grtV.newObj("app.PluginObjectInput", {objectStructName= type})
end

function getPluginInfo()
	local l
    local plugin

    -- create the list of plugins that this module exports
	l= new_plugin_list()

    plugin= new_plugin({
		name= "wb.table.util.copyInsertToClipboard",
        caption= "Copy Insert to Clipboard",
		moduleName= "WbTableUtils",
		pluginType= "normal", 
		moduleFunctionName= "copyInsertToClipboard",
		inputValues= {objectPluginInput("db.Table")},
		groups= {"Catalog/Utilities", "Menu/Objects"}
	})

    -- add to the list of plugins
    grtV.insert(l, plugin)

	return l
end

--    
-- implementation
--

function copyInsertToClipboard(table)

    local insert = "INSERT INTO `" .. table.name .. "` ("
    local c_separator = "`"
    local values = "VALUES ("
    local v_separator = ""
    local i
   
    for i = 1, grtV.getn(table.columns) do
      insert = insert .. c_separator .. table.columns[i].name
      c_separator = "`, `"
      values = values .. v_separator
      v_separator = " ,"
    end
      
    insert = insert .. "`) " .. values .. ");"
    Workbench:copyToClipboard(insert)

    return 0
end


