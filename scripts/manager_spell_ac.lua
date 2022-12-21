-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

local resetSpellsOriginal;
local resetPreparedOriginal;
local tSpellsets = { "spellset", "weaponspellset", "itemspellset", "otherspellset" };

function onInit()
    -- check first if we want to rather use Kelrugem's SpellManager implementation
    if CompManagerAC.EXTENSIONS["Full OverlayPackage"] then
        return;
    end

    resetSpellsOriginal = SpellManager.resetSpells;
    SpellManager.resetSpells = resetSpells;

    resetPreparedOriginal = SpellManager.resetPrepared;
    SpellManager.resetPrepared = resetPrepared;
end

-- Reset power points and individual spells cast
function resetSpells(nodeCaster)
    for _,sSpellset in ipairs(tSpellsets) do
        for _,nodeSpellClass in pairs(DB.getChildren(nodeCaster, sSpellset)) do
            DB.setValue(nodeSpellClass, "pointsused", "number", 0);
            
            for _,nodeLevel in pairs(DB.getChildren(nodeSpellClass, "levels")) do
                for _,nodeSpell in pairs(DB.getChildren(nodeLevel, "spells")) do
                    DB.setValue(nodeSpell, "cast", "number", 0);
                end
            end
        end 
    end
end

-- Iterate through each spell to reset
function resetPrepared(nodeCaster)
    for _,sSpellset in ipairs(tSpellsets) do
        for _,nodeSpellClass in pairs(DB.getChildren(nodeCaster, sSpellset)) do
            for _,nodeLevel in pairs(DB.getChildren(nodeSpellClass, "levels")) do
                for _,nodeSpell in pairs(DB.getChildren(nodeLevel, "spells")) do
                    DB.setValue(nodeSpell, "prepared", "number", 0);
                end
            end
        end
    end
end
