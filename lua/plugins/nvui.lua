local specs = {
  {
    "nvchad/ui",
    config = function()
      require("nvchad")
    end
  },
  { "nvchad/volt" },
  {
    "Debajyati/base46",
    branch = "fix",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  }
}

return specs
