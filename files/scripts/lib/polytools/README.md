# polytools
A library which adds polymorph-related functions for use in Noita mods

## Features:
- Polymorph anything into (almost) anything else consistently
- Use a silent polymorph to hide an entity temporarily with minimal side effects
- Easily add components to allow a polymorphed player to still have an inventory and GUI
- Automatically patch projectiles and physics objects to not explode or completely bug out, respectively
- Easily copy and paste serialization data from an entity to another entity or create a perfect clone of an entity
- Extract the path to the xml file that was used to create an entity

## How to Use:
1. Add this repository as a subrepo to your mod or copy the latest release into a folder somewhere in your mod
2. execute this code in your mod's init.lua to tell polytools (replacing `<polytools_path>` with the path to the polytools folder) where its files are:
    - `dofile_once("<polytools_path>/polytools_init.lua").init("<polytools_path>")`
3. Use the functions exposed by polytools.lua for easy polymorphing!