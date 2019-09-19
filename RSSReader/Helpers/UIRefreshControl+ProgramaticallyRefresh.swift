import UIKit

extension UIRefreshControl {
    
    func beginRefreshingProgramatically(in tableView: UITableView) {
        self.beginRefreshing()
        let offsetPoint = CGPoint(x: 0, y: -self.frame.size.height)
        tableView.setContentOffset(offsetPoint, animated: true)
    }
    
}
