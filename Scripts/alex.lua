reaper.ClearConsole()
local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
dofile(script_path .. "Buffy.lua")
dofile(script_path .. "Helpers.lua")

N = 500
local ts_start, ts_end = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
local si = GetSelectedItems()

local A = {}
local B = {}
local F = {}
local L = {}
local P = {ts_start*1000}
local R = {}
local S = {}

-- A
for i=1,N do A[i] = 1 end -- math.random(1000, 1000)/1000 end

-- B
for i=1,N do B[i] = si[math.random(#si)] end

-- cut
cut = true

-- F
--F = GetWaveFiles("/Users/amleth/AppData/Roaming/REAPER/amleth/sc-guzheng-stereo")

-- R
for i=1,N do R[i] = math.random(0.1*1000, 1.0*1000)/1000 end

-- L
--for i=1,N do L[i] = -1 end
for i=1,N do L[i] = math.random(100, 3000) end
--for i=1,N do L[i] = reaper.GetMediaItemInfo_Value(B[i], "D_LENGTH")*1000 end

-- P
for i=1,N do P[i] = math.random(math.floor(ts_start)*1000, math.floor(ts_end)*1000) end
--local STEP = 100
--for i=1,N do
--  local p = math.random(math.floor(ts_start)*1000, math.floor(ts_end)*1000)
--  p = math.floor(p/STEP)*STEP
--  P[i] = p
--end

-- S
for i=1,N do S[i] = math.random(1, 6) end

Buffy(ts_start, A, B, cut, F, L, N, P, R, S)
