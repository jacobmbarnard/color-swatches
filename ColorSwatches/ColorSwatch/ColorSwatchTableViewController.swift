import UIKit
import CoreData

class ColorSwatchTableViewController: UITableViewController {
    private let viewModel: ColorSwatchViewModel

    init(context: NSManagedObjectContext) {
        self.viewModel = ColorSwatchViewModel(context: context)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Color Swatches"
        tableView.register(ColorSwatchTableViewCell.self, forCellReuseIdentifier: "ColorSwatchTableViewCell")
        setupBottomToolbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    private func setupBottomToolbar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.style = .prominent
        toolbarItems = [addButton]
    }
        
    
    @objc private func addButtonTapped() {
        let addVC = AddColorSwatchViewController(viewModel: viewModel)
        addVC.onColorSwatchAdded = { [weak self] in
            self?.tableView.reloadData()
        }
        present(UINavigationController(rootViewController: addVC), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSwatches().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorSwatchTableViewCell", for: indexPath) as! ColorSwatchTableViewCell
        let swatch = viewModel.getSwatches()[indexPath.row]
        cell.configure(with: swatch)
        return cell
    }
}
