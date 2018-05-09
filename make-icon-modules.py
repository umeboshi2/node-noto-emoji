import os
import json
import subprocess
IconsFilename = 'icons.json'
if not os.path.isfile(IconsFilename):
    #raise RuntimeError("Need to run \"make-icons.coffee\" first.")
    subprocess.check_call(['npx', 'coffee', 'make-icons.coffee'])
    
icons = json.load(open(IconsFilename))


def get_module_name(emoji):
    if len(emoji) > 2:
        raise RuntimeError("we are only handling certain icons")
    val = ord(emoji[0])
    h = hex(val)[2:]
    modName = "asturur-noto-emoji/svg/emoji_u{}.svg".format(h)
    filename = "node_modules/{}".format(modName)
    if os.path.isfile(filename):
        return modName
    return None


def create_modfile(name, module):
    line = "module.exports = require(\"{}\");\n".format(module)
    filename = "dist/{}.js".format(name)
    with open(filename, 'w') as outfile:
        outfile.write(line)

        
modules = {}
for key, value in icons.items():
    module_name = get_module_name(value)
    if module_name:
        modules[key] = module_name
        
    
if not os.path.isdir('dist'):
    os.mkdir('dist')

    
for name, mod in modules.items():
    create_modfile(name, mod)
    print("Created", name)
    
    
