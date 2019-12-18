

addEventHandler("onClientRender", root,
function()
    dxDrawImage(149, 292, 385, 449, ":tacticsgm/files/images/lobbys/1vs1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(553, 292, 385, 449, ":tacticsgm/files/images/lobbys/tactics.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(957, 292, 385, 449, ":tacticsgm/files/images/lobbys/deathmatch.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(1375, 292, 385, 449, ":tacticsgm/files/images/lobbys/dd.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawRectangle(554, 744, 384, 55, tocolor(0, 0, 0, 174), false)
    dxDrawRectangle(150, 744, 384, 55, tocolor(0, 0, 0, 174), false)
    dxDrawText("0 Spieler", 149, 744, 534, 799, tocolor(255, 255, 255, 255), 1.00, userdata: 0002026A, "center", "center", false, false, false, false, false)
    dxDrawRectangle(957, 744, 384, 55, tocolor(0, 0, 0, 174), false)
    dxDrawRectangle(1376, 744, 384, 55, tocolor(0, 0, 0, 174), false)
    dxDrawText("0 Spieler", 554, 744, 939, 799, tocolor(255, 255, 255, 255), 1.00, userdata: 0002026A, "center", "center", false, false, false, false, false)
    dxDrawText("0 Spieler", 957, 744, 1342, 799, tocolor(255, 255, 255, 255), 1.00, userdata: 0002026A, "center", "center", false, false, false, false, false)
    dxDrawText("0 Spieler", 1376, 744, 1761, 799, tocolor(255, 255, 255, 255), 1.00, userdata: 0002026A, "center", "center", false, false, false, false, false)
    dxDrawRectangle(149, 206, 1611, 76, tocolor(0, 0, 0, 174), false)
    dxDrawText("Hamburg Tactics", 149, 206, 1760, 282, tocolor(255, 255, 255, 255), 1.00, userdata: 0002026A, "center", "center", false, false, false, false, false)
end
)