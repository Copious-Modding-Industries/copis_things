dofile_once("[POLYTOOLS_PATH]disco_util/disco_util.lua")
local polytools = dofile_once("[POLYTOOLS_PATH]polytools.lua")
local self = Entity.Current()
polytools.load(self, self.var_str.polydata)
