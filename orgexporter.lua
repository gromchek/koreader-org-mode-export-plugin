local _ = require("gettext")

local OrgExporter = require("base"):new{
    name      = "org",
    extension = "org",
    mimetype  = "text/plain",
}

function OrgExporter:getMenuTable()
    return {
        text = _("Org-mode"),
        checked_func = function() return self:isEnabled() end,
        sub_item_table = {
            {
                text = _("Export to Org-mode"),
                checked_func = function() return self:isEnabled() end,
                callback = function() self:toggleEnabled() end,
            },
        },
    }
end

local function exportBook(file, booknotes)
    local title  = booknotes.title  or "Unknown title"
    local author = booknotes.author or "Unknown author"

    -- Document header
    file:write("#+TITLE:   " .. title .. "\n")
    file:write("#+AUTHOR:  " .. author .. "\n")
    file:write("#+STARTUP: overview\n")
    file:write("#+OPTIONS: toc:nil num:nil\n")
    file:write("\n")

    -- Level 1: book
    file:write("* " .. title .. "\n")
    file:write(":PROPERTIES:\n")
    file:write(":AUTHOR:   " .. author .. "\n")
    if booknotes.file then
        file:write(":FILE:     " .. booknotes.file .. "\n")
    end
    file:write(":END:\n")
    file:write("\n")

    local current_chapter = nil

    -- booknotes is an array of entries; each entry is a table { clipping }
    -- clipping fields: text, note, chapter, page, time
    for _, entry in ipairs(booknotes) do
        local clipping = entry[1]
        if clipping and (clipping.text or clipping.note) then
            -- Level 2: chapter heading (only when chapter changes)
            local chapter = clipping.chapter
            if chapter and chapter ~= "" and chapter ~= current_chapter then
                current_chapter = chapter
                file:write("** " .. chapter .. "\n")
                file:write("\n")
            end

            -- Level 3: single highlight
            local page = tostring(clipping.page or "?")
            local ts = ""
            if clipping.time and clipping.time > 0 then
                ts = "  <" .. os.date("%Y-%m-%d %H:%M", clipping.time) .. ">"
            end
            file:write("*** p. " .. page .. ts .. "\n")

            -- Highlighted text as quote block
            if clipping.text and clipping.text ~= "" then
                file:write("#+begin_quote\n")
                file:write(clipping.text .. "\n")
                file:write("#+end_quote\n")
            end

            -- User note
            if clipping.note and clipping.note ~= "" then
                file:write("\n")
                file:write("/Note:/ " .. clipping.note .. "\n")
            end

            file:write("\n")
        end
    end
end

function OrgExporter:export(t)
    local path = self:getFilePath(t)
    local file = io.open(path, "w")
    if not file then return false end

    for _, booknotes in ipairs(t) do
        exportBook(file, booknotes)
    end

    file:write("-----\n")
    file:write("Generated: " .. self:getTimeStamp() .. "\n")
    file:close()
    return true
end

return OrgExporter
