local Config=Config or {} ; local shown=false
CreateThread(function()
  while true do
    Wait(0)
    local ped=PlayerPedId()
    local p=GetEntityCoords(ped)
    for _,m in ipairs(Config.Safehouses or {}) do
      local d = #(p - vector3(m.x+0.0, m.y+0.0, m.z+0.0))
      if d < 20.0 then
        DrawMarker(1,m.x,m.y,m.z-1.0,0,0,0,0,0,0,1.2,1.2,0.6,255,255,255,120,false,true,2,false,nil,nil,false)
      end
      if d < (Config.MarkerDist or 2.0) then
        SetTextComponentFormat("STRING"); AddTextComponentString("~INPUT_CONTEXT~ Enter "..(m.label or "Safehouse"))
        DisplayHelpTextFromStringLabel(0,0,1,-1)
        if IsControlJustPressed(0,38) then
          local fw = GetEntityForwardVector(ped)
          SetEntityCoords(ped, m.x+fw.x*2.0, m.y+fw.y*2.0, m.z+0.0, false,false,false,true)
        end
      end
    end
  end
end)
