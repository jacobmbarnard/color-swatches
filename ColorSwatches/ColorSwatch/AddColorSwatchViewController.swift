import UIKit

class AddColorSwatchViewController: UIViewController, UIColorPickerViewControllerDelegate {
    private let nameField = UITextField()
    private let colorPickerButton = UIButton(type: .system)
    private let userRatingTextField = UITextField()
    private let viewModel: ColorSwatchViewModel
    private var selectedColorHex = "#000000"
    
    var onColorSwatchAdded: (() -> Void)?
    
    init(viewModel: ColorSwatchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Swatch"
        view.backgroundColor = .systemBackground
        setupNavigation()
        setupViews()
    }
    
    private func setupNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.prominent, target: self, action: #selector(saveTapped))
    }
    
    private func setupViews() {
        nameField.placeholder = "Swatch Name"
        nameField.borderStyle = .roundedRect
        nameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameField)
        
        colorPickerButton.setTitle("Select Color", for: .normal)
        colorPickerButton.addTarget(self, action: #selector(colorPickerTapped), for: .touchUpInside)
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorPickerButton)
        
        userRatingTextField.placeholder = "Rating (1-10)"
        userRatingTextField.keyboardType = .numberPad
        userRatingTextField.borderStyle = .roundedRect
        userRatingTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userRatingTextField)
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            colorPickerButton.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            colorPickerButton.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            
            userRatingTextField.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: 20),
            userRatingTextField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            userRatingTextField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor)
        ])
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        guard let name = nameField.text, !name.isEmpty,
          let userRatingText = userRatingTextField.text, let userRating = Int(userRatingText), userRating > 0 else {
            let alert = UIAlertController(title: "Incomplete", message: "Please fill in all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        viewModel.addSwatch(swatchName: name, colorHex: selectedColorHex, userRating: userRating)
        onColorSwatchAdded?()
        dismiss(animated: true)
    }
    
    @objc private func colorPickerTapped() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        selectedColorHex = viewController.selectedColor.hexString
        colorPickerButton.setTitle("Selected: \(selectedColorHex)", for: .normal)
    }
}
