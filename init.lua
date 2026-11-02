local path = ...
path = path:gsub("%.init$", "")

return require(path .. ".love-bark")