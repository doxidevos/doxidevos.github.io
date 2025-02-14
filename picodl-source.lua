-- picodl: Minimal Picotron Downloader Command
-- Usage: picodl "download URL" "base file name" "file extension"

local args = env().argv or {}
local url = args[1] or ""
local baseName = args[2] or ""
local ext = args[3] or ""
local currentver = "2"
local onlinever

-- Fetch online version first
onlinever = fetch("https://doxidevos.github.io/picodlver.txt") or ""
onlinever = onlinever:gsub("\n", "") -- Removing any newline character from the fetched version.

local newversiondata = ""
local newversionsave = "/desktop/picodlupd/install_picodl_version/" .. onlinever .. ".p64"
local newversionname = "install_picodl_version" .. onlinever .. ".p64"

function chkver()
    print("Checking For Updates")
    if currentver == onlinever or onlinever == "" then
        print("No Updates Available")
    else
        print("Downloading update...")
        newversiondata = fetch("https://doxidevos.github.io/picodl_install.p64") or ""
        
        if newversiondata == "" then
            print("Update download failed.")
            return false
        end

        mkdir("/desktop/picodlupd/")
        mkdir("/desktop/picodlupd/install_picodl_version/")

        store(newversionsave, newversiondata, {})
        print("Your update is in a folder on your desktop. Run it whenever possible please :)")
    end	
end

-- Check for an update
chkver()

if url == "" or baseName == "" or ext == "" then
    print("Usage: picodl \"<download URL>\" \"base file name\" \"file extension\"")
    return
end

-- Ensure the extension starts with a dot.
if ext:sub(1, 1) ~= "." then ext = "." .. ext end
local fileName = baseName .. ext

-- Save the file to /desktop (i.e. root/Desktop).
local fullPath = "/desktop/" .. fileName

print("Downloading from: " .. url)
local data = fetch(url) or ""

if data == "" then
    print("Download failed for URL: " .. url)
    return
end

store(fullPath, data, {})  -- Always pass an empty table for metadata.
print("Download complete! File saved as: " .. fullPath)


]]

-- Ensure the system util folder exists.
mkdir("/appdata/system/util")

-- Install the downloader command by storing it into /appdata/system/util as "picodl.lua".
store("/appdata/system/util/picodl.lua", downloader_code, {})

print("Installation complete! The downloader command 'picodl' has been installed.")
print("You can now run it from the terminal as:")
print('  picodl "download URL" "base file name" "file extension"')
print("Reboot Reccomended!")
