-- This script may be used with the email-filter or repo.email-filter settings in cgitrc.
-- It adds gravatar icons to author names. It is designed to be used with the lua:
-- prefix in filters. It takes some part from the kernel.org's one.
--
-- Requirements:
--      lua-md5 (from SBo)
--

local md5 = require("md5")

function filter_open(email, page)
        buffer = ""
        hexdigest = md5.sumhexa(email:sub(2, -2):lower())
end

function filter_close()
        html("<span class='gravatar'><img class='inline' src='//www.gravatar.com/avatar/" .. hexdigest .. "?s=13&amp;d=retro' /><img class='onhover' src='//www.gravatar.com/avatar/" .. hexdigest .. "?s=128&d=retro' /></span> " .. buffer)
        return 0
end

function filter_write(str)
        buffer = buffer .. str
end


