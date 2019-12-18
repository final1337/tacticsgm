-- ****************************************************************************
-- *
-- *  PROJECT:     Hamburg Tactics
-- *  FILE:        server/classes/notificationbox/NotificationGUI.lua
-- *  PURPOSE:     Notification Box / Infobox
-- *
-- ****************************************************************************

Notification = inherit(Object)

Notification.Boxes = {}

addEvent("Client:Notification:Show", true)

function Notification:constructor()
    self.m_StartX = 25*(screenWidth/1920)
    self.m_StartY = 725*(screenHeight/1080)
    self.m_Space = 50 -- offset per entry
    self.m_Height = 32

    self.m_DurTime = 5000 -- Default, if nothing has been specified
    self.m_OffsetOut = 1000
    self.m_OffsetIn = 1000

    addEventHandler("onClientRender", root, bind(self.Render, self))
end

function Notification.Event_Notification(msg, r, g, b, duration)
    table.insert(Notification.Boxes, {
        Text = msg;
        Time = getTickCount();
        Duration = duration or 5000;
        Expiretime = getTickCount()+(duration or 5000);
        red = r;
        green = g;
        blue = b;
        curOffset = 50*(#Notification.Boxes);
        curFade = 1
    })
    playSound("files/sounds/Message.mp3")
end
addEventHandler("Client:Notification:Show", root, Notification.Event_Notification)

function Notification:Render()
    for k, v in ipairs(Notification.Boxes) do
        self.m_TextWidth = dxGetTextWidth(v.Text, 1, "default-bold")+70

        if getTickCount() >= v.Expiretime-self.m_OffsetOut then
            local easingVal = (getTickCount()-(v.Expiretime-self.m_OffsetOut))/self.m_OffsetOut
            easingVal = getEasingValue(easingVal, "InBack")

            dxDrawRectangle(self.m_StartX, self.m_StartY-v.curOffset, self.m_TextWidth-(self.m_TextWidth*easingVal), self.m_Height, tocolor(0, 0, 0, 180))
            dxDrawText(v.Text, self.m_StartX+self.m_Height+10, self.m_StartY-v.curOffset, self.m_StartX+self.m_TextWidth-(self.m_TextWidth*easingVal), self.m_StartY-v.curOffset+self.m_Height, tocolor(v.red, v.green, v.blue, 255), 1, "default-bold", "left", "center", true)
        else
            local easingVal = math.min(1, (getTickCount()-(v.Time))/self.m_OffsetIn)
            easingVal = getEasingValue(easingVal, "OutBack")

            dxDrawRectangle(self.m_StartX, self.m_StartY-v.curOffset, self.m_TextWidth*easingVal, self.m_Height, tocolor(0, 0, 0, 180))
            dxDrawText(v.Text, self.m_StartX+self.m_Height+10, self.m_StartY-v.curOffset, self.m_StartX+self.m_TextWidth*easingVal, self.m_StartY-v.curOffset+self.m_Height, tocolor(v.red, v.green, v.blue, 255), 1, "default-bold", "left", "center", true)

            local maxOffset = self.m_Space*(k-5)

            if v.curOffset > maxOffset then
                v.curOffset = math.max(maxOffset, v.curOffset-10)
            end
            if getTickCount() >= v.Expiretime then table.remove(Notification.Boxes, k) end
        end
    end
end