function Link (el)
  if el.target:match "^.%/.*.md$" then
    baseName, _  = string.gsub(el.target, "./(.*)%.md$", "%1")
    el.target = "./" .. baseName .. ".html"
    el.content = {pandoc.Str("(see " .. baseName .. ")")}
  end

  return el
end
