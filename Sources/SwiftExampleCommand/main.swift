print("Hello, Swift Command!")

import Foundation

class MyXMLStructure: NSObject, XMLParserDelegate {
    var depth: Int = 0;
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        depth += 1
        print(String(repeating: "→", count: depth), "START ", elementName)

    }
    func parser(_ parser: XMLParser, foundCharacters word: String) {
        let trimmed = word.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed != "" {
            print(String(repeating: " ", count: depth + 1), "=", trimmed)
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print(String(repeating: "→", count: depth), "END   ", elementName)
        depth -= 1
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("[1001] PARSE ERROR:", parseError)
    }
}
let instance = MyXMLStructure()

let fpath = CommandLine.arguments[1]
print("[0001] ARG PATH:", fpath)

let url = NSURL(fileURLWithPath: fpath) as URL
var xmlparser = XMLParser(contentsOf: url)!
xmlparser.delegate = instance

if xmlparser.parse() {
    print("[0002] DEPTH:", instance.depth)
} else {
    print("[1002] :", xmlparser.parserError)
}
