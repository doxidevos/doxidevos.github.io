-- picodl: Minimal Picotron Downloader Command
-- Usage: picodl "download URL" "base file name" "file extension"

local args = env().argv or {}
local type = args[1] or ""
local url = args[2] or ""
local baseName = args[3] or ""
local ext = args[4] or ""
local currentver = "3"
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

if type == web then

if url == "" or baseName == "" or ext == "" then
    print("Usage: picodl web \"<download URL>\" \"base file name\" \"file extension\"")
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
	
print("This feature will be added soon")
local fullPath = "Canceled By Program"

	else if type == "cart" then
	
if url  == "" then
print("Usage: picodl cart \"<cart name>\" (not added yet, coming soon)")
return
end

else
print("Usage: picodl \"<web/cart>\" \"<download URL>\" \"base file name\" \"file extension\"")
print(" or picodl cart \"<cart name>\" which will be added soon")
   return

end



store(fullPath, data, {})  -- Always pass an empty table for metadata.
if type == "web" then
print("Download complete! File saved as: " .. fullPath)
else if type == "cart" then
print("This feature is in the works!")
else
print("Uh Oh! Something happened!")
end
end
end
