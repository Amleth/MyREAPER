function Buffy(play_pos, a, b, cut, f, l, n, p, r, s)
  --------------------------------------------------------------------------------
  -- INIT
  --------------------------------------------------------------------------------
  
  reaper.Undo_BeginBlock()
  
  reaper.Main_OnCommand(1016, 0)
  math.randomseed(os.time())
  reaper.SetEditCurPos2(0, play_pos, true, true)
  --reaper.Main_OnCommand(40001, 0) -- create a new track
  local track = reaper.GetSelectedTrack(0, 0)
 
  --------------------------------------------------------------------------------
  -- MAIN
  -------------------------------------------------------------------------------
  
  for i=1,n do
    -- source item
    local temp_item = nil
    local item
    if #f > 0 then
      reaper.SetEditCurPos2(0, play_pos, true, true)
      reaper.InsertMedia(f[math.random(#f)], 0)
      reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELITEMSUNDEDCURSELTX"),0)
      item = reaper.GetSelectedMediaItem(0, 0)
      temp_item = item
    else
      item = b[i]
    end
    local take = reaper.GetMediaItemTake(item, 0)
    local item_len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
    
    -- reinit selection
    reaper.Main_OnCommand(40289, 0)
    reaper.SetTrackSelected(track, true)
    reaper.SetMediaItemSelected(item, true)
  
    -- clone source item
    reaper.Main_OnCommand(41295, 0)
    local clone = reaper.GetSelectedMediaItem(0, 0)
    reaper.MoveMediaItemToTrack(clone, track)
    local clone_len = reaper.GetMediaItemInfo_Value(clone, "D_LENGTH")
    reaper.SetMediaItemPosition(clone, play_pos, false)
    local clone_pos = reaper.GetMediaItemInfo_Value(clone, "D_POSITION")
    local clone_end = clone_pos + clone_len
    
    -- create grain
    local grain = clone
    local grain_len = l[i]
    if cut == true then
      local cur_pos_ms = math.random(math.floor(clone_pos*1000), math.floor(clone_end*1000))
      reaper.SetEditCurPos2(0, cur_pos_ms/1000, false, false)
      reaper.Main_OnCommand(40757, 0) -- Item: Split items at edit cursor (no change selection)
      reaper.SetEditCurPos2(0, (cur_pos_ms + grain_len)/1000, false, false)
      reaper.Main_OnCommand(40757, 0)
      local left = reaper.GetSelectedMediaItem(0, 0)
      grain = reaper.GetSelectedMediaItem(0, 1)
      local right = reaper.GetSelectedMediaItem(0, 2)
      reaper.DeleteTrackMediaItem(track, left)
      if right ~= nil then
        reaper.DeleteTrackMediaItem(track, right)
      end
    else
      reaper.SetMediaItemLength(grain, l[i]/1000, false)
    end

    -- position
    local grain_pos = p[i]
    reaper.SetMediaItemPosition(grain, grain_pos/1000, false)

    -- rate 
    local take = reaper.GetMediaItemTake(grain, 0)
    reaper.SetMediaItemTakeInfo_Value(take, "B_PPITCH", 0)
    reaper.SetMediaItemTakeInfo_Value(take, "D_PLAYRATE", r[i])
    
    -- amplitude
    if a[i] > 1 then a[i] = 1 end
    reaper.SetMediaItemInfo_Value(grain, "D_VOL", a[i])
    
    -- fade out
    if grain_len == -1 then
      grain_len = reaper.GetMediaItemInfo_Value(grain, "D_LENGTH")
    end
    reaper.SetMediaItemInfo_Value(grain, "D_FADEOUTLEN", grain_len)
    reaper.SetMediaItemInfo_Value(grain, "C_FADEOUTSHAPE", 4)
    
    -- spatialization
    reaper.SetMediaItemTakeInfo_Value(take, "D_PAN", -1 + math.random(0, 2000)/1000)
    for _s=1,s[i] do
      reaper.Main_OnCommand(40118, 0)
    end
    
    -- cleanup
    if temp_item ~= nil then
      reaper.DeleteTrackMediaItem(track, temp_item)
    end
  end
  
  --------------------------------------------------------------------------------
  -- END
  --------------------------------------------------------------------------------
  
  reaper.UpdateArrange()
  reaper.Main_OnCommand(40289, 0)
  reaper.SetEditCurPos2(0, play_pos, true, true)
  
  reaper.Undo_EndBlock("Buffy", -1)
  reaper.Main_OnCommand(1007, 0)
end
