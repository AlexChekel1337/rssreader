import UIKit

class FeedSourceItemCell: UITableViewCell {
    
    //MARK: Properties
    
    public var itemTitleLabel = UILabel()
    public var itemDesctiptionLabel = UILabel()
    public var itemLinkLabel = UILabel()
    
    //MARK: Initialization and setup
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.itemTitleLabel.textColor = UIColor.black
        self.itemTitleLabel.font = UIFont.systemFont(ofSize: 19.0, weight: .medium)
        self.itemTitleLabel.numberOfLines = 0
        self.itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.itemTitleLabel)
        
        self.itemDesctiptionLabel.textColor = UIColor.black
        self.itemDesctiptionLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        self.itemDesctiptionLabel.numberOfLines = 0
        self.itemDesctiptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.itemDesctiptionLabel)
        
        self.itemLinkLabel.textColor = UIColor.lightGray
        self.itemLinkLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        self.itemLinkLabel.numberOfLines = 1
        self.itemLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.itemLinkLabel)
        
        NSLayoutConstraint.activate([
            self.itemTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.itemTitleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.itemTitleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.itemTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.itemDesctiptionLabel.topAnchor.constraint(equalTo: self.itemTitleLabel.bottomAnchor, constant: 8),
            self.itemDesctiptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.itemDesctiptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.itemDesctiptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.itemLinkLabel.topAnchor.constraint(equalTo: self.itemDesctiptionLabel.bottomAnchor, constant: 8),
            self.itemLinkLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.itemLinkLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.itemLinkLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            self.itemLinkLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
    }
    
    //MARK: Selection handling

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
