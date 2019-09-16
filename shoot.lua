local cw,pw,tie = 0,0,0 --comment
print("gg")
math.randomseed( os.time() )
print([[
             Shoot!
--------------------------------
How to play: 
"shoot" - fire bullet
"load" - loads gun with a bullet
"block" - blocks bullets]])

while true do
   print("--------------------------------")
   print(string.format([[New game! %i/%i (%i)
]],pw,cw,tie))
   local plr = {}
   local pl = false
   local comp = {}
   local cl = false

   while true do
      local input = io.read()
      --handle comp move
      local move
      local rand = math.random()*100
      local p = plr[#plr]
      local c = comp[#comp]
      if #comp == 0 then
         move = "load"
      elseif not cl then
         if p == "shoot" then
            move = "load"
         elseif c == "shoot" and not pl then move = "load"
         elseif not c =="shoot" then
            if rand <= 20 then
               move = "load"
            else
               move = "block"
            end
         else
            if rand <= 30 then
            move = "load" else move = "block"
            end
         end
      elseif cl then
         if p == "shoot" and rand <= 70 then move = "shoot"
         elseif rand <= 50 then
            move = "shoot"
         else
            move = "block"
         end
      end

      print("Mr.AI: "..move)
      comp[#comp+1] = move
      if move == "shoot" then
         --sound
         cl = false
      elseif move == "load" then
         cl = true
      end

      --handle player move
      if string.lower(input) == "shoot" or string.sub(input,1,1) == "s" then
         if pl then
            pl = false
            plr[#plr+1] = "shoot"
         else
            print">Your gun wasn't loaded!"
            plr[#plr+1] = "blank"
         end
      elseif string.lower(input) == "load"  or string.sub(input,1,1) == "l" then
         if not pl then
            pl = true
            plr[#plr+1] = "load"
         else
            print">Your gun was already loaded!"
            plr[#plr+1] = "double"
         end
      elseif string.lower(input) == "block"  or string.sub(input,1,1) == "b" then
         plr[#plr+1] = "block"
      else -- block
         plr[#plr+1] = "block"
         print">Unkown, defaulted to block!"
      end
      print()

      --handle end
      local cc,pc = comp[#comp],plr[#plr]
      if cc == 'shoot' or pc == 'shoot' then
         if cc == pc then
            print">>Tie game!"
            tie = tie +1
            break
         elseif pc =="load" or pc == "blank" or pc == "double" then
            print">>Computer wins!"
            cw = cw +1
            break
         elseif cc == "load" then
            print">>You win!"
            pw = pw+1
            break
         end
      end

   end
   print("Moves:"..#plr)
   local mis = 0
   for i,v in next, plr do
      if v == "blank" or v == "double" then mis = mis + 1
      end
   end
   print(string.format("Mistakes: %i (%d%%)", mis, math.floor(mis/#plr*100+.5)))
end


