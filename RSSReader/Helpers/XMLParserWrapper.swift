import UIKit

class XMLParserWrapper: NSObject {
    
    //MARK: Properties
    
    public var parser: XMLParser?
    
    private var tempItem: FeedItem?
    private var tempElement: String?
    private var parsedItems: Array<FeedItem> = []
    
    private var formatter: DateFormatter = DateFormatter()
    
    struct Keys {
        static let itemKey: String = "item"
        static let titleKey: String = "title"
        static let descriptionKey: String = "description"
        static let dateKey: String = "pubDate"
        static let linkKey: String = "link"
    }
    
    //MARK: Initialization
    
    override init() {
        super.init()
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
    }
    
    //MARK: Functionality
    
    public func fetchSource(_ feedURL: URL) -> Array<FeedItem> {
        self.parser = XMLParser(contentsOf: feedURL)
        guard let p = self.parser else { return [] }
        p.delegate = self
        if (p.parse()) { return self.parsedItems } else { return [] }
    }
}

extension XMLParserWrapper: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parse error occured: \(parseError.localizedDescription)")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.tempElement = elementName
        if (elementName == XMLParserWrapper.Keys.itemKey) {
            self.tempItem = FeedItem()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if var item = self.tempItem {
            if (self.tempElement == XMLParserWrapper.Keys.titleKey) { item.title = string }
            else if (self.tempElement == XMLParserWrapper.Keys.descriptionKey) { item.description = string }
            else if (self.tempElement == XMLParserWrapper.Keys.dateKey) {
                if let date = self.formatter.date(from: string) { item.date = date }
            }
            else if (self.tempElement == XMLParserWrapper.Keys.linkKey) {
                if let itemURL = URL(string: string) { item.link = itemURL }
            }
            
            self.tempItem = item
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == XMLParserWrapper.Keys.itemKey) {
            if let item = self.tempItem { parsedItems.append(item) }
            tempItem = nil
        }
    }
    
}
