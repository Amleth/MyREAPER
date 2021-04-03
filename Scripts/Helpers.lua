dofile(reaper.GetResourcePath().."/UserPlugins/ultraschall_api.lua")

function GetSelectedItems()
  local selected_items = {}
  local n_selected_items = reaper.CountSelectedMediaItems(0)
  for i=1,n_selected_items do
    selected_items[i] = reaper.GetSelectedMediaItem(0, i-1)
  end
 return selected_items
end

function GetWaveFiles(path)
  local waveFiles = {}
  nfiles, files = ultraschall.GetAllFilenamesInPath(path)
 for f=1,nfiles do
    if (files[f]):sub(-4) == ".wav" then
      table.insert(waveFiles, files[f])
    end
  end
  return waveFiles
end
