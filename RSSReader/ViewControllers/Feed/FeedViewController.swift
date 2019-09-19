import UIKit
import ReactiveSwift

//MARK: - FeedViewController

class FeedViewController: UIViewController {
    
    //MARK: Properties
    
    public var viewModel = FeedViewModel()
    
    private var tableView = UITableView()
    private var refreshControl = UIRefreshControl()
    private var heightCache: Dictionary<IndexPath, CGFloat> = [:]
    
    //MARK: Initialization and setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.title = "Новости"
        let sourceButton = UIBarButtonItem(title: "Источники", style: .plain, target: self, action: #selector(sourceButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = sourceButton
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(FeedSourceItemCell.self, forCellReuseIdentifier: "item")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.refreshControl.addTarget(self, action: #selector(refreshControlValueChanged(_:)), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        self.viewModel.items.signal.observeValues { (items) in
            DispatchQueue.main.async {
                self.heightCache = [:]
                self.tableView.reloadData()
            }
        }
        self.viewModel.sources.signal.observeValues { _ in
            self.viewModel.reloadItems()
        }
        
        self.viewModel.reloadItems()
    }
    
    //MARK: Actions
    
    @objc private func refreshControlValueChanged(_ sender: Any) {
        self.viewModel.reloadItems()
    }
    
    @objc private func sourceButtonPressed(_ sender: Any) {
        let vm = SourcesViewModel(sources: self.viewModel.sources)
        let sourcesVC = SourcesViewController(viewModel: vm)
        let navigationController = UINavigationController(rootViewController: sourcesVC)
        self.present(navigationController, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource protocol conformance

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! FeedSourceItemCell
        let item = self.viewModel.items.value[indexPath.row]
        
        cell.itemTitleLabel.text = item.title
        cell.itemDesctiptionLabel.text = item.description
        cell.itemLinkLabel.text = item.link?.host ?? "Нет ссылки"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heightCache[indexPath] ?? 70.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.heightCache[indexPath] = cell.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.viewModel.items.value[indexPath.row]
        if let url = item.link {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
