#!/bin/lua

-- ll.lua
--
-- List directory contents sorted by file type and then by filename.
--
-- usage:
--
-- ./ll.lua

function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -Ghla "'..directory..'"')
  for filename in pfile:lines() do
    i = i + 1
    t[i] = filename
  end
  pfile:close()
  return t
end

red    = "\27[31m"
blue   = "\27[34m"
purple = "\27[35m"
normal = "\27[0m"

function colorDir(str)
  return blue .. str .. normal .. "/"
end

function colorExe(str)
  return red .. str .. normal .. "*"
end

function colorLnk(str)
  return purple .. str .. normal .. "@"
end

function filename(line)
  linePattern = "(%S+%s+%S+%s+%S+%s+%S+%s+%S+%s+%S+%s+%S+%s+%S+%s+)(%S+)"
  _, _, _, fname = string.find(line, linePattern)
  return fname or nil
end

function colorFilename(fileType, line)
  linePattern = "(%S+%s+%S+%s+%S+%s+%S+%s+%S+%s+%S+%s+%S+%s+%S+%s+)(%S+)"
  return string.gsub(line, linePattern, formatParts(fileType))
end

function formatParts(fileType) 
  return function (first, second)
    return first .. colorByType(fileType)(second)
  end
end

-- unix designators
-- d: directory
-- c: character device
-- b: block device
-- s: socket
-- p: pipe
-- D: door
-- l: symbolic link
-- -: file
--
-- fileType
-- dir: directory
-- exe: executable
-- lnk: link
-- fil: file

toFileType = {
  d = "dir",
  l = "lnk",
  x = "exe",
}

function fileType(line)
  firstBit = string.sub(line, 1, 1)
  lastBit = string.sub(line, 10, 10)

  if (firstBit == "-") then
    return lastBit == "x" and "exe" or "fil"
  else
    return toFileType[firstBit] or "fil"
  end
end

do
  local t = {
    dir = colorDir,
    lnk = colorLnk,
    exe = colorExe,
  }
  function colorByType(fileType)
    return function(line)
      return t[fileType] and t[fileType](line) or line
    end
  end
end

ord = {
  dir = 1,
  exe = 2,
  lnk = 3,
  fil = 4,
}
function byFileTypeThenFilename(lineA, lineB)
  fileTypeA = fileType(lineA)
  fileTypeB = fileType(lineB)

  filenameA = filename(lineA)
  filenameB = filename(lineB)

  ordA = ord[fileTypeA]
  ordB = ord[fileTypeB]

  if (filenameA == nil or filenameB == nil) then
    return false
  end

  if (ordA == ordB) then
    return filenameA < filenameB
  else 
    return ordA < ordB
  end
end

files = scandir("./")
table.sort(files, byFileTypeThenFilename)

for i,file in ipairs(files) do
  fType = fileType(file)
  coloredLine = colorFilename(fType, file)
  print(coloredLine)
end
