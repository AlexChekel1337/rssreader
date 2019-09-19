import UIKit
import ReactiveSwift

struct FeedViewModel {
    
    let sources: MutableProperty<[URL]> = MutableProperty.init([])
    let items: MutableProperty<[FeedItem]> = MutableProperty.init([])
    let isUpdating: MutableProperty<Bool> = MutableProperty.init(false)
    
    func reloadItems() {
        self.isUpdating.value = true
        ConnectionManager().fetchSources(sources.value) { (newItems) in
            self.items.value = newItems
            self.isUpdating.value = false
        }
    }
    
}
