import UIKit

class ConnectionManager: NSObject {
    
    public func fetchSources(_ sources: Array<URL>, completion: @escaping (_ items: Array<FeedItem>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var items: Array<FeedItem> = []
            for source in sources {
                let wrapper = XMLParserWrapper()
                let sourceItems = wrapper.fetchSource(source)
                items.append(contentsOf: sourceItems)
            }
            
            completion(items.sorted(by: { $0.date > $1.date }))
        }
    }
    
}
