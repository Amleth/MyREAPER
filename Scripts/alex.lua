local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
dofile(script_path .. "Buffy.lua")
dofile(script_path .. "Helpers.lua")

N = 500
local ts_start, ts_end = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
local si = GetSelectedItems()

local A = {}
local B = {}
local L = {}
local P = {ts_start*1000}
local R = {}
local S = {}

for i=1,N do A[i] = math.random(0, 1000)/1000 end

for i=1,N do
  reaper.ShowConsoleMsg(reaper.GetMediaItemInfo_Value(si[math.random(Size(si))], "D_LENGTH"))
  reaper.ShowConsoleMsg("\n")
  B[i] = si[math.random(Size(si))]
end

for i=1,N do R[i] = math.random(0.9*1000, 1.0*1000)/1000 end

--for i=1,N do L[i] = math.random(100, 800) end
for i=1,N do L[i] = R[i]*1000 end

for i=1,N do P[i] = math.random(math.floor(ts_start)*1000, math.floor(ts_end)*1000) end
--local STEP = 100
--for i=1,N do
--  local p = math.random(math.floor(ts_start)*1000, math.floor(ts_end)*1000)
--  p = math.floor(p/STEP)*STEP
--  P[i] = p
--end

for i=1,N do S[i] = math.random(1, 6) end

Buffy(ts_start, A, B, L, N, P, R, S)
