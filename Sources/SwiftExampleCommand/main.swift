print("Hello, Swift Command!")

import Foundation

let fpath = CommandLine.arguments[1]
print("[0001] ARG PATH:", fpath)

let contents = FileManager.default.contents(atPath: fpath)!

let plist = try PropertyListSerialization.propertyList(from: contents, options: .mutableContainersAndLeaves, format: nil) as! NSMutableDictionary

plist["CFBundleVersion"] = "3"

if let data = try? PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: .max) {
    try data.write(to: NSURL(fileURLWithPath: fpath) as URL)
}
