local WidgetContainer = require("ui/widget/container/widgetcontainer")
local Provider        = require("provider")
local OrgExporter     = require("orgexporter")

local OrgExporterPlugin = WidgetContainer:extend{
    name        = "provider_org_exporter",
    is_doc_only = false,
}

function OrgExporterPlugin:init()
    -- Передаём сам класс (прототип), а не экземпляр
    Provider:register("exporter", "org", OrgExporter)
end

return OrgExporterPlugin
