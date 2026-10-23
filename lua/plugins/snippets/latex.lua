local ls = require("luasnip")
local s, t, i = ls.snippet, ls.text_node, ls.insert_node

return {
    s("mk", { t("$"), i(1, "math"), t("$") }),
    s("dm", { t({"\\[", "\t"}), i(1, "dmath"), t({"", "\\]"})})
}


