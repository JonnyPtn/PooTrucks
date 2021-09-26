---Poo Trucks
---@author Jonny
---@version 0.0.0.1
---@date 25/09/2021
---@class PooTrucks
PooTrucks = {}

function PooTrucks:loadMap(name)
    InGameMenuContractsFrame.onFrameOpen =
        Utils.overwrittenFunction(InGameMenuContractsFrame.onFrameOpen,
                                  self.onContractsFrameOpen)
end

function PooTrucks:onContractsFrameOpen(superFunc, ...)
    superFunc(self, ...)
    local missions = g_missionManager.missions
    print("Mission count: ", #missions)

    local path = ('%ssavegame%d'):format(getUserProfileAppPath(),
                                         g_careerScreen.selectedIndex) ..
                     "/poo.xml";
    print(path)
    local pooTrucks = createXMLFile("pooTrucks", path, "missions")

    for index, mission in ipairs(missions) do
        if mission.type.name == "harvest" then
            -- DebugUtil.printTableRecursively(mission)
            mission.depositedLiters = mission.expectedLiters
            setXMLString(pooTrucks, "missions.mission" .. index .. "#type",
                         g_fillTypeManager:getFillTypeNameByIndex(
                             mission.fillType))
            setXMLFloat(pooTrucks,
                        "missions.mission" .. index .. "#expectedLiters",
                        mission.expectedLiters)
            setXMLFloat(pooTrucks,
                        "missions.mission" .. index .. "#depositedLiters",
                        mission.depositedLiters)
        end
    end

    if pooTrucks and pooTrucks ~= 0 then
        saveXMLFile(pooTrucks)
        print("Saved poo trucks")
    end
end

addModEventListener(PooTrucks);
