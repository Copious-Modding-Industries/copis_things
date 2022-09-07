dofile_once("data/scripts/lib/utilities.lua")
if DebugGetIsDevBuild() then
    function Dprint(...) print(...) end
else
    function Dprint() end
end

---@class List
List = {}
List.__mt = {__tostring = function(self) return "Class: List" end}
---@param data table
---@param wrapper function
---@param args any
---@return List
List.__mt.__call = function(self, data, wrapper, args)
    if not data or #data == 0 then return nil end
    local output = {__data = data, __wrapper = wrapper, __args = args or {}}
    setmetatable(output, List)
    return output
end
List.__index = function(self, key)
    if List[key] then
        return List[key]
    elseif type(key) == "number" then
        return self.__wrapper(self.__data[key], self.__args)
    else
        -- If addressed directly, assume the user wants the first entry
        return self.__wrapper(self.__data[1], self.__args)[key]
    end
end
List.__newindex = function(self, key, value)
    if List[key] then
        print_error("Tried to overwrite list class")
        return
    elseif type(key) == "number" then
        print_error("Tried to overwrite list index")
        -- Don't allow writing to the component list
    else
        -- If addressed directly, assume the user wants the first entry
        self.__wrapper(self.__data[1], self.__args)[key] = value
    end
end
List.__tostring = function(self)
    local output = "List: "
    for k, v in self:ipairs() do output = output .. "\n - " .. tostring(v) end
    return output
end
---@return int length
function List:len() return #self.__data end
---@return function iterator
function List:ipairs()
    local i = 0
    local n = #self.__data
    return function()
        i = i + 1
        if i <= n then return i, self[i] end
    end
end
function List:search(pred)
    local output = {}
    for i = 1, #self.__data do
        if pred(self.__wrapper(self.__data[i], self.__args)) then
            table.insert(output, self.__data[i])
        end
    end
    return List(output, self.__wrapper, self.__args)
end
function List:searchRaw(pred)
    -- Does not wrap list entries during the search
    local output = {}
    for i = 1, #self.__data do
        if pred(self.__data[i]) then table.insert(output, self.__data[i]) end
    end
    return List(output, self.__wrapper, self.__args)
end
function List:sort(comp)
    table.sort(self.__data, function(a, b)
        return comp(self.__wrapper(a, self.__args), self.__wrapper(b, self.__args))
    end)
end
function List:sortRaw(comp) table.sort(self.__data, comp) end
function List:getBest(score)
    local best = nil
    local best_score = nil
    for i = 1, #self.__data do
        local my_score = score(self.__wrapper(self.__data[i], self.__args))
        if not best_score or my_score > best_score then
            best = self.__data[i]
            best_score = my_score
        end
    end
    return self.__wrapper(best, self.__args)
end

setmetatable(List, List.__mt)

local ent_values_special = {
    variables = function(eid) return Variable(eid, "value_string") end,
    var_str = function(eid) return Variable(eid, "value_string") end,
    var_int = function(eid) return Variable(eid, "value_int") end,
    var_bool = function(eid) return Variable(eid, "value_bool") end,
    var_float = function(eid) return Variable(eid, "value_float") end
}

---@class Entity
Entity = {}
Entity.__cache = {}
Entity.__mt = {
    __tostring = function(self) return "Class: Entity" end,
    __call = function(self, id)
        if not id or id == 0 then return nil end
        if not Entity.__cache[id] then
            Entity.__cache[id] = {__id = id}
            setmetatable(Entity.__cache[id], Entity)
        end
        return Entity.__cache[id]
    end
}
Entity.__index = function(self, key)
    if Entity[key] then return Entity[key] end
    if key == "__id" then
        print_error("Illegal Entity ID")
        return 0
    end
    if ent_values_special[key] then
        return ent_values_special[key](self.__id)
    else
        return List(EntityGetComponentIncludingDisabled(self.__id, key), Component, self.__id)
    end
end
Entity.__newindex = function(self, key, value) print_error("Can't set entity values") end
Entity.__tostring = function(self) return "Entity (" .. self.__id .. ")" end
-- Static functions
---@param id number
---@return Entity
function Entity.Wrap(id) return Entity(id) end
---@return Entity
function Entity.Current() return Entity(GetUpdatedEntityID()) end
---@param filename string
---@param x number
---@param y number
---@return Entity
function Entity.Load(filename, x, y) return Entity(EntityLoad(filename, x, y)) end
---@param filename string
---@param x number
---@param y number
---@return Entity
function Entity.LoadCameraBound(filename, x, y) return Entity(EntityLoadCameraBound(filename, x, y)) end
---@param name string
---@return Entity
function Entity.CreateNew(name) return Entity(EntityCreateNew(name)) end
---@param x number
---@param y number
---@param tag string
---@param radius number
---@return List
function Entity.GetInRadius(x, y, tag, radius)
    if not tag then
        return List(EntityGetInRadius(x, y, radius), Entity)
    else
        return List(EntityGetInRadiusWithTag(x, y, radius, tag), Entity)
    end
end
-- Member functions
---@return int id
function Entity:id() return self.__id end
---@return string name
function Entity:name() return EntityGetName(self.__id) end
---@param name string
function Entity:setName(name) return EntitySetName(self.__id, name) end
---@return bool
function Entity:alive() return EntityGetIsAlive(self.__id) end
function Entity:kill() EntityKill(self.__id) end
---@return number x, number y, number angle, number scale_x, number scale_y
function Entity:transform() return EntityGetTransform(self.__id) end
---@param x number
---@param y number
---@param angle number
---@param scale_x number
---@param scale_y number
function Entity:setTransform(x, y, angle, scale_x, scale_y)
    local ox, oy, oa, osx, osy = self:transform()
    x = x or ox
    y = y or oy
    angle = angle or oa
    scale_x = scale_x or osx
    scale_y = scale_y or osy
    return EntitySetTransform(self.__id, x, y, angle, scale_x, scale_y)
end
---@param tx number
---@param ty number
function Entity:setFacing(tx, ty)
    local x, y, _, sx, sy = EntityGetTransform(self.__id)
    local angle = math.atan2(ty - y, tx - x)
    return EntitySetTransform(self.__id, x, y, angle, sx, sy)
end
---@return string tags
function Entity:tags() return EntityGetTags(self.__id) end
---@param tag string
---@return bool
function Entity:hasTag(tag) return EntityHasTag(self.__id, tag) end
---@param tag string
function Entity:addTag(tag) EntityAddTag(self.__id, tag) end
---@param tag string
function Entity:removeTag(tag) EntityRemoveTag(self.__id, tag) end

-- Component functions
---@param ctype string
---@param values table
---@return Component
function Entity:addComponent(ctype, values)
    return Component(EntityAddComponent2(self.__id, ctype, values), self.__id)
end
---@return List|nil
function Entity:allComponents() return List(EntityGetAllComponents(self.__id), Component, self.__id) end
function Entity:componentsWithTag(ctype, tag)
    return List(EntityGetComponentIncludingDisabled(self.__id, ctype, tag), Component, self.__id)
end

---@param tag string
---@param enabled bool
function Entity:setEnabledWithTag(tag, enabled)
    EntitySetComponentsWithTagEnabled(self.__id, tag, enabled)
end

---@param filename string
---@param load_children bool
---@param set_name bool
---@param set_tags bool
function Entity:loadComponents(filename, load_children, set_name, set_tags)
    EntityLoadToEntity(filename, self.__id)
    if load_children or set_name or set_tags then
        local x, y = EntityGetTransform(self.__id)
        local surrogate = EntityLoad(filename, x, y)
        if load_children then
            local children = EntityGetAllChildren(surrogate)
            if children then
                for k, v in ipairs(children) do
                    EntityRemoveFromParent(v)
                    EntityAddChild(self.__id, v)
                end
            end
        end
        if set_name then self:setName(EntityGetName(surrogate)) end
        if set_tags then
            local tags = StringSplit(self:tags())
            for i = 1, #tags do self:removeTag(tags[i]) end
            tags = EntityGetTags(surrogate)
            tags = StringSplit(tags)
            for i = 1, #tags do self:addTag(tags[i]) end
        end
        EntityKill(surrogate)
    end
end
---@param types table
function Entity:removeComponents(types)
    if type(types) == "string" then
        local comps = self[types]
        if comps then for _, v in comps:ipairs() do v:remove() end end
    else
        for _, v in ipairs(types) do self:removeComponents(v) end
    end
end
-- Parent/child hierarchy
---@return Entity|nil
function Entity:parent() return Entity(EntityGetParent(self.__id)) end
---@param parent Entity|int
function Entity:setParent(parent)
    EntityRemoveFromParent(self.__id)
    if not parent then
        return
    elseif type(parent) == "number" then
        EntityAddChild(parent, self.__id)
    else
        EntityAddChild(parent:id(), self.__id)
    end
end
---@return Entity
function Entity:root() return Entity(EntityGetRootEntity(self.__id)) end
---@return List|nil
function Entity:children() return List(EntityGetAllChildren(self.__id), Entity) end
-- Misc Gameplay
---@param material string|int
---@param amount int
function Entity:addStains(material, amount)
    if type(material) == "string" then material = CellFactory_GetType(material) end
    EntityAddRandomStains(self.__id, material, amount)
end
---@param filename string
---@return Entity effect
function Entity:addGameEffect(filename) return Entity(LoadGameEffectEntityTo(self.__id, filename)) end
---@param material number
---@param amount number
---@return Entity effect
function Entity:setMaterialCount(material, amount)
    if type(material) == "number" then material = CellFactory_GetName(material) end
    AddMaterialInventoryMaterial(self.__id, material, amount)
end

-- Physics functions
---@param fx number
---@param fy number
function Entity:applyForce(fx, fy)
    if self.PhysicsBodyComponent or self.PhysicsBody2Component then
        PhysicsApplyForce(self.__id, fx, fy)
    elseif self.CharacterDataComponent then
        local vel = self.CharacterDataComponent.mVelocity
        local mass = self.CharacterDataComponent.mass
        vel.x = vel.x + fx / (2 * mass)
        vel.y = vel.y + fy / (2 * mass)
        self.CharacterDataComponent.mVelocity = vel
        self.CharacterDataComponent.mCollidedHorizontally = true
    elseif self.VelocityComponent then
        local vel = self.VelocityComponent.mVelocity
        local mass = self.VelocityComponent.mass
        vel.x = vel.x + fx / (60 * mass)
        vel.y = vel.y + fy / (60 * mass)
        self.VelocityComponent.mVelocity = vel
    end
end
---@param tz number
function Entity:applyTorque(tz) PhysicsApplyTorque(self.__id, tz) end
setmetatable(Entity, Entity.__mt)

---@class Vec2
Vec2 = {}
Vec2.__mt = {__tostring = function(self) return "Class: Vec2" end}
---@param data table
---@param wrapper function
---@param args any
---@return List
Vec2.__mt.__call = function(self, component_id, name)
    local x, y = ComponentGetValue2(component_id, name)
    local output = {x, y}
    setmetatable(output, Vec2)
    return output
end
Vec2.__index = function(self, key)
    if key == "x" or key == "min" then
        return self[1]
    elseif key == "y" or key == "max" then
        return self[2]
    end
    return nil
end
Vec2.__newindex = function(self, key, value)
    if key == "x" or key == "min" then
        self[1] = value
    elseif key == "y" or key == "max" then
        self[2] = value
    end
end
Vec2.__tostring = function(self) return "Vector2: (" .. self[1] .. ", " .. self[2] .. ")" end

setmetatable(Vec2, Vec2.__mt)

---@param component_id int
---@param key string
---@param value table
function SetVec2(component_id, key, value)
    if value[1] then
        ComponentSetValue2(component_id, key, value[1], value[2])
    elseif value.x then
        ComponentSetValue2(component_id, key, value.x, value.y)
    elseif value.min then
        ComponentSetValue2(component_id, key, value.min, value.max)
    else
        print_error("Invalid Vec2 structure for setter")
    end
end

MetaObject = {}
MetaObject.__mt = {
    __call = function(self, c_id, obj_name)
        if not c_id or c_id == 0 or not obj_name then return nil end
        local output = {__id = c_id, __name = obj_name}
        setmetatable(output, MetaObject)
        return output
    end
}
MetaObject.__index = function(self, key) return
    ComponentObjectGetValue2(self.__id, self.__name, key) end
MetaObject.__newindex = function(self, key, value)
    ComponentObjectSetValue2(self.__id, self.__name, key, value)
end
setmetatable(MetaObject, MetaObject.__mt)

local component_special_types = {
    AbilityComponent = {gun_config = MetaObject, gunaction_config = MetaObject},
    AdvancedFishAIComponent = {
        mTargetPos = Vec2,
        mTargetVec = Vec2,
        mLastFramesMovementAreaMin = Vec2,
        mLastFramesMovementAreaMax = Vec2
    },
    AnimalAIComponent = {
        attack_melee_finish_config_explosion = MetaObject,
        mLastFramesMovementAreaMin = Vec2,
        mLastFramesMovementAreaMax = Vec2,
        mNextJumpTarget = Vec2,
        mHomePosition = Vec2
    },
    AreaDamageComponent = {aabb_min = Vec2, aabb_max = Vec2},
    BossDragonComponent = {mTargetVec = Vec2, mRandomTarget = Vec2, mLastLivingTargetPos = Vec2},
    CardinalMovementComponent = {mPrevPos = Vec2},
    CharacterDataComponent = {mVelocity = Vec2},
    CharacterPlatformingComponent = {mExAnimationPos = Vec2},
    CharacterStatsComponent = {stats = MetaObject},
    ConsumableTeleportComponent = {target_location = Vec2},
    ControlsComponent = {
        mAimingVector = Vec2,
        mAimingVectorNormalized = Vec2,
        mAimingVectorNonZeroLatest = Vec2,
        mGamepadAimingVectorRaw = Vec2,
        mJumpVelocity = Vec2,
        mMousePosition = Vec2,
        mMousePositionRaw = Vec2,
        mMousePositionRawPrev = Vec2,
        mMouseDelta = Vec2,
        mGamepadIndirectAiming = Vec2
    },
    CrawlerAnimalComponent = {
        mMin = Vec2,
        mMax = Vec2,
        mPrevNonSnappedPosition = Vec2,
        mPrevCellPosition = Vec2,
        mPrevCellPosition2 = Vec2,
        mPrevCellPosition3 = Vec2,
        mPrevCellPosition4 = Vec2,
        mPrevCellPosition5 = Vec2,
        mPrevCellPosition6 = Vec2,
        mPrevCellPosition7 = Vec2,
        mPrevCellPosition8 = Vec2,
        mLatestPosition = Vec2
    },
    DamageModelComponent = {damage_multipliers = MetaObject, mPhysicsDamageVecThisFrame = Vec2},
    DamageNearbyEntitiesComponent = {mVelocity = Vec2},
    DrugEffectComponent = {drug_fx_target = MetaObject, m_drug_fx_current = MetaObject},
    DrugEffectModifierComponent = {fx_add = MetaObject, fx_multiply = MetaObject},
    ElectricityComponent = {mAvgDir = Vec2, mPrevPos = Vec2},
    EnergyShieldComponent = {mPrevPosition = Vec2},
    ExplodeOnDamageComponent = {config_explosion = MetaObject},
    ExplosionComponent = {config_explosion = MetaObject},
    FishAIComponent = {aabb_min = Vec2, aabb_max = Vec2, velocity = Vec2, mLastCheckPos = Vec2},
    GhostComponent = {velocity = Vec2, mTargetPosition = Vec2, mRandomTarget = Vec2},
    HitboxComponent = {offset = Vec2},
    HotspotComponent = {offset = Vec2},
    IKLimbAttackerComponent = {mTarget = Vec2},
    IKLimbComponent = {
        end_position = Vec2,
        mJointWorldPos = Vec2,
        mPart0PrevPos = Vec2,
        mPart1PrevPos = Vec2
    },
    IKLimbWalkerComponent = {mTarget = Vec2, mPrevTarget = Vec2, mPrevCenterPosition = Vec2},
    IKLimbsAnimatorComponent = {mPrevBodyPosition = Vec2},
    InheritTransformComponent = {Transform = MetaObject},
    Inventory2Component = {mSmoothedItemAngleVec = Vec2},
    InventoryComponent = {
        ui_container_size = Vec2,
        ui_element_size = Vec2,
        ui_position_on_screen = Vec2
    },
    InventoryGuiComponent = {},
    ItemComponent = {spawn_pos = Vec2, inventory_slot = Vec2},
    ItemPickUpperComponent = {mLatestItemOverlapInfoBoxPosition = Vec2},
    LaserEmitterComponent = {laser = MetaObject},
    LifetimeComponent = {randomize_lifetime = Vec2},
    LightningComponent = {config_explosion = MetaObject, mExPosition = Vec2},
    LoadEntitiesComponent = {count = Vec2},
    MaterialAreaCheckerComponent = {area_aabb = MetaObject},
    -- MaterialInventoryComponent = {count_per_material_type = MATERIAL_VEC_DOUBLES},
    MaterialSeaSpawnerComponent = {size = Vec2, offset = Vec2},
    MaterialSuckerComponent = {randomized_position = MetaObject},
    ParticleEmitterComponent = {
        offset = Vec2,
        area_circle_radius = Vec2,
        gravity = Vec2,
        mExPosition = Vec2,
        m_last_emit_position = Vec2
    },
    PathFindingComponent = {path_next_node_vector_to = Vec2},
    PhysicsAIComponent = {mLastPositionWhenHadPath = Vec2},
    PhysicsBody2Component = {mLocalPosition = Vec2},
    PhysicsBodyComponent = {initial_velocity = Vec2, mLocalPosition = Vec2},
    PhysicsPickUpComponent = {
        transform = MetaObject,
        original_left_joint_pos = Vec2,
        original_right_joint_pos = Vec2,
        leftJointPos = Vec2,
        rightJointPos = Vec2
    },
    PlatformShooterPlayerComponent = {
        eating_area_min = Vec2,
        eating_area_max = Vec2,
        mSmoothedCameraPosition = Vec2,
        mSmoothedAimingVector = Vec2,
        mDesiredCameraPos = Vec2
    },
    PressurePlateComponent = {aabb_min = Vec2, aabb_max = Vec2},
    ProjectileComponent = {
        config = MetaObject,
        config_explosion = MetaObject,
        damage_by_type = MetaObject,
        damage_critical = MetaObject,
        shell_casing_offset = Vec2
    },
    SetLightAlphaFromVelocityComponent = {mPrevPosition = Vec2},
    SetStartVelocityComponent = {velocity = Vec2, randomize_angle = Vec2, randomize_speed = Vec2},
    SimplePhysicsComponent = {mOldPosition = Vec2},
    SpriteComponent = {transform_offset = Vec2, offset_animator_offset = Vec2},
    SpriteParticleEmitterComponent = {
        -- color = fcolor,
        -- color_change = fcolor,
        velocity = Vec2,
        gravity = Vec2,
        scale = Vec2,
        scale_velocity = Vec2,
        randomize_lifetime = Vec2,
        randomize_position = MetaObject,
        randomize_velocity = MetaObject,
        randomize_scale = MetaObject,
        randomize_rotation = Vec2,
        randomize_angular_velocity = Vec2,
        randomize_alpha = Vec2,
        randomize_animation_speed_coeff = Vec2,
        expand_randomize_position = Vec2
    },
    TeleportComponent = {target = Vec2, source_location_camera_aabb = MetaObject},
    VelocityComponent = {mVelocity = Vec2, mPrevVelocity = Vec2, mPrevPosition = Vec2},
    VerletPhysicsComponent = {animation_target_offset = Vec2, m_position_previous = Vec2},
    VerletWorldJointComponent = {world_position = Vec2},
    WorldStateComponent = {player_spawn_location = Vec2},
    WormAIComponent = {mRandomTarget = Vec2},
    WormComponent = {mTargetVec = Vec2, mTargetPosition = Vec2},
    WormPlayerComponent = {mPrevPosition = Vec2, mDirection = Vec2}
}

---@class Component
Component = {}
Component.__cache = {}
Component.__mt = {
    __tostring = function(self) return "Class: Component" end,
    __call = function(self, c_id, e_id)
        if not c_id or c_id == 0 or not e_id or e_id == 0 then return nil end
        if not Component.__cache[e_id] then Component.__cache[e_id] = {} end
        if not Component.__cache[e_id][c_id] then
            Component.__cache[e_id][c_id] = {__id = c_id, __entity = e_id}
            setmetatable(Component.__cache[e_id][c_id], Component)
        end
        return Component.__cache[e_id][c_id]
    end
}
Component.__index = function(self, key)
    if Component[key] then return Component[key] end
    if key == "__id" then
        print_error("Illegal Component ID")
        return 0
    end
    if component_special_types[self:type()] and component_special_types[self:type()][key] then
        return component_special_types[self:type()][key](self.__id, key)
    else
        return ComponentGetValue2(self.__id, key)
    end
end
Component.__newindex = function(self, key, value)
    if key == "__id" then
    elseif component_special_types[self:type()] and component_special_types[self:type()][key] == Vec2 then
        SetVec2(self.__id, key, value)
    else
        ComponentSetValue2(self.__id, key, value)
    end
end
Component.__tostring = function(self) return self:type() .. " (" .. tostring(self.__id) .. ")" end
function Component:id() return self.__id end
function Component:type() return ComponentGetTypeName(self.__id) end
function Component:hasTag(tag) return ComponentHasTag(self.__id, tag) end
function Component:addTag(tag) return ComponentAddTag(self.__id, tag) end
function Component:removeTag(tag) return ComponentRemoveTag(self.__id, tag) end
function Component:members() return ComponentGetMembers(self.__id) end
function Component:isEnabled() return ComponentGetIsEnabled(self.__id) end
function Component:setEnabled(value) EntitySetComponentIsEnabled(self.__entity, self.__id, value) end
function Component:remove() EntityRemoveComponent(self.__entity, self.__id) end
function Component:getVelocity()
    local vx, vy = PhysicsGetComponentVelocity(self.__entity, self.__id)
    return {x = vx, y = vy}
end
function Component:getAngularVelocity()
    return PhysicsGetComponentAngularVelocity(self.__entity, self.__id)
end

setmetatable(Component, Component.__mt)

Variable = {}
Variable.__cache = {}
Variable.__mt = {
    __call = function(self, e_id, var_type)
        if not e_id or e_id == 0 or not var_type then return nil end
        local output = {__id = e_id, __type = var_type}
        if not Variable.__cache[e_id] then Variable.__cache[e_id] = {} end
        setmetatable(output, Variable)
        return output
    end
}
Variable.__index = function(self, key)
    if Variable[key] then return Variable[key] end
    if not Variable.__cache[self.__id][key] then
        local vars = EntityGetComponentIncludingDisabled(self.__id, "VariableStorageComponent")
        if vars then
            for k, v in ipairs(vars) do
                Variable.__cache[self.__id][ComponentGetValue2(v, "name")] = v
            end
        end
    end
    local v = Variable.__cache[self.__id][key]
    if not v then
        return nil
    else
        return ComponentGetValue2(v, self.__type)
    end
end
Variable.__newindex = function(self, key, value)
    if not Variable.__cache[self.__id][key] then
        local vars = EntityGetComponentIncludingDisabled(self.__id, "VariableStorageComponent")
        if vars then
            for k, v in ipairs(vars) do
                Variable.__cache[self.__id][ComponentGetValue2(v, "name")] = v
            end
        end
    end
    if value == nil then
        local v = Variable.__cache[self.__id][key]
        if v then EntityRemoveComponent(self.__id, v) end
        return
    end
    if not Variable.__cache[self.__id][key] then
        Variable.__cache[self.__id][key] = EntityAddComponent2(self.__id,
                                                               "VariableStorageComponent",
                                                               {name = key})
    end
    ComponentSetValue2(Variable.__cache[self.__id][key], self.__type, value)
end

setmetatable(Variable, Variable.__mt)

---@param str string
---@param separator string
---@param func function|nil
---@return table
function StringSplit(str, separator, func)
    separator = separator or ","
    local output = {}
    if not str or str == "" then return output end
    if func then
        for seg in string.gmatch(str, "([^" .. separator .. "]+)[" .. separator .. "$]") do
            table.insert(output, func(seg))
        end
    else
        for seg in string.gmatch(str, "([^" .. separator .. "]+)[" .. separator .. "$]") do
            table.insert(output, seg)
        end
    end
    return output
end

---@param from Entity
---@param to Entity
function WandCopy(from, to)
    local names_ac = {"ui_name", "mana_max", "mana", "mana_charge_speed"}
    local names_gunconfig = {
        "reload_time",
        "actions_per_round",
        "deck_capacity",
        "shuffle_deck_when_empty"
    }
    local names_gunactionconfig = {"fire_rate_wait", "spread_degrees", "speed_multiplier"}
    local fromac = from.AbilityComponent
    local toac = to.AbilityComponent
    for index, name in ipairs(names_ac) do toac[name] = fromac[name] end
    for index, name in ipairs(names_gunconfig) do toac.gun_config[name] = fromac.gun_config[name] end
    for index, name in ipairs(names_gunactionconfig) do
        toac.gunaction_config[name] = fromac.gunaction_config[name]
    end
end

---@param wand Entity
---@return List cards, List always_cast
function GetSpells(wand)
    local spells = wand:children()
    local cards = spells and spells:search(function(ent)
        return ent:hasTag("card_action") and not ent.ItemComponent.permanently_attached
    end)
    local always_cast = spells and spells:search(function(ent)
        return ent:hasTag("card_action") and ent.ItemComponent.permanently_attached
    end)
    return cards, always_cast
end
