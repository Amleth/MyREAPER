function Size(t)
  local count = 0
  for _, __ in pairs(t) do
    count = count + 1
  end
  return count
end


function GetSelectedItems()
  local selected_items = {}
  local n_selected_items = reaper.CountSelectedMediaItems(0)
  for i=0,n_selected_items-1 do
    selected_items[i] = reaper.GetSelectedMediaItem(0, i)
  end
  return selected_items
end
