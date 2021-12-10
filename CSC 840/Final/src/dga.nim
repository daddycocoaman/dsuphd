import os
import std/strformat
from std/strutils import parseUInt, intToStr, fromHex

proc printHelp() =
  # Prints help
  echo &"\nUsage: dga <day> <month> <year> <seed> <number of domains (default: 40)>"
  echo &"Example: dga 14 5 2015 b6354bc3\n"


proc dga(day: var uint, month: var uint, year: var uint, seed: var uint): array[
    40, string] =

  var tld_index = day;
  var domain_list: array[40, string]
  var tlds: array[9, string] = ["in", "me", "cc", "su", "tw", "net", "com",
      "pw", "org"]

  for n in 0..39:
    var domain: string

    for i in 0..14:
      day = (day shr 15) xor 16 * (day and 0x1FFF xor 4 * (seed xor day))
      year = ((year and 0xFFFFFFF0.uint) shl 17) xor ((year xor (7 * year)) shr 11)
      month = 14 * (month and 0xFFFFFFFE.uint) xor ((month xor (4 * month)) shr 8)
      seed = (seed shr 6) xor ((day + 8 * seed) shl 8) and 0x3FFFF00.uint
      domain &= chr((((day xor month xor year) mod 25) + 97).int)

    tld_index += 1
    domain_list[n] = (&"{domain}.{tlds[tld_index mod 8]}")
  return domain_list


proc main() =
  var params = commandLineParams()
  var param_len = len(params)

  # If num of params invalid, print help
  if not param_len == 4:
    printHelp()
    quit(1)

  var
    day: uint = parseUInt(params[0])
    month: uint = parseUInt(params[1])
    year: uint = parseUInt(params[2])
    seed: uint = fromHex[uint](params[3])
    domains = dga(day, month, year, seed)

  for i in low(domains)..high(domains):
    echo domains[i]

main()
