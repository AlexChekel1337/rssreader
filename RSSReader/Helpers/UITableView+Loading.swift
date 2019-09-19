import UIKit

extension UITableView {
    
    public func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        self.backgroundView = activityIndicator
        activityIndicator.startAnimating()
    }
    
    public func hideActivityIndicator() {
        self.backgroundView = nil
    }
    
}
