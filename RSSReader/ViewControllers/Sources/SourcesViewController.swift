import UIKit
import ReactiveSwift

//MARK: - SourcesViewController

class SourcesViewController: UIViewController {
    
    //MARK: Properties
    
    public var viewModel: SourcesViewModel
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    
    //MARK: Initialization and setup
    
    init(viewModel: SourcesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.title = "Источники"
        let cancelButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(cancelButtonPressed(_:)))
        let addButton = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = addButton
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "source")
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    //MARK: Actions
    
    @objc private func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func addButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Новый источник", message: "Введите адрес чтобы добавить новый источник", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Добавить", style: .default) { (action) in
            guard let textFields = alertController.textFields else { return }
            guard let urlString = textFields[0].text else { return }
            guard let sourceURL = URL(string: urlString) else { return }
            
            self.viewModel.sources.value.append(sourceURL)
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        alertController.addTextField { (textField) in
            textField.placeholder = "Адрес RSS-источника"
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource protocol conformance

extension SourcesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Источники"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.sources.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "source")
        let source = self.viewModel.sources.value[indexPath.row]
        
        cell.textLabel?.text = source.host
        cell.detailTextLabel?.text = source.absoluteString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        self.viewModel.sources.value.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
