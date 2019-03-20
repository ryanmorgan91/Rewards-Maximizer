
import UIKit

class AddEditCardTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryOneCategoryLabel: UILabel!
    @IBOutlet weak var categoryOnePicker: UIPickerView!

    @IBOutlet weak var categoryOnePercentLabel: UILabel!
    
    @IBOutlet weak var categoryOneStepper: UIStepper!
    
   
    let categoryOnePickerCellIndexPath = IndexPath(row: 1, section: 1)
   
    
    var creditCard: CreditCard?
    var selectedPickerOneRow: Int?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var isCategoryOnePickerShown: Bool = false {
        didSet {
            categoryOnePicker.isHidden = !isCategoryOnePickerShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let creditCard = creditCard {
            nameTextField.text = creditCard.name
            let rewardsCategoriesArray = creditCard.rewardsDict.keys.map {( $0 )}
            selectedPickerOneRow = CreditCard.allRewardsCategoriesArray.index(of: rewardsCategoriesArray[0])
            categoryOneStepper.value = creditCard.rewardsDict[rewardsCategoriesArray[0]]!
        }
        
        
       
        categoryOnePicker.delegate = self
        categoryOnePicker.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        categoryOnePicker.selectRow(selectedPickerOneRow ?? 0, inComponent: 0, animated: true)
        categoryOneCategoryLabel.text = CreditCard.RewardsCategory.allCases[categoryOnePicker.selectedRow(inComponent: 0)].rawValue
        
        
        categoryOneCategoryLabel.textColor = tableView.tintColor
        updateCategoryOneLabel()
        updateCategoryOnePercent(number: categoryOneStepper.value as NSNumber)
        updateView()
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (categoryOnePickerCellIndexPath.section, categoryOnePickerCellIndexPath.row):
            if isCategoryOnePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (categoryOnePickerCellIndexPath.section, categoryOnePickerCellIndexPath.row - 1):
            isCategoryOnePickerShown = !isCategoryOnePickerShown
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CreditCard.RewardsCategory.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return CreditCard.RewardsCategory.allCases[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        switch pickerView {
        case categoryOnePicker:
            updateCategoryOneLabel()
            
        default:
            return
        }
    }
    
    func updateCategoryOnePercent(number: NSNumber) {
        categoryOnePercentLabel.text = CreditCard.numberFormatter.string(from: number)
    }
    
    func updateCategoryOneLabel() {
        categoryOneCategoryLabel.text = CreditCard.RewardsCategory.allCases[categoryOnePicker.selectedRow(inComponent: 0)].rawValue
        categoryOneCategoryLabel.textColor = .black
    }

    func updateView() {
        updateSaveButtonState()
        guard let creditCard = creditCard else { return }
        
        nameTextField.text = creditCard.name
         nameTextField.textColor = .black
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let name = nameTextField.text!
        let categoryOneCategory: CreditCard.RewardsCategory = CreditCard.RewardsCategory.allCases[categoryOnePicker.selectedRow(inComponent: 0)]
        let categoryOnePercent = categoryOneStepper.value
        var rewardsDict: [CreditCard.RewardsCategory: Double] = [categoryOneCategory: categoryOnePercent]
      
        creditCard = CreditCard(name: name, rewardsDict: rewardsDict)
        
        
    }
    
    func updateSaveButtonState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    @IBAction func nameEditingChanged(_ sender: UITextField) {
        
        updateSaveButtonState()
    }
    
    
    @IBAction func returnPressed(_ sender: UITextField) {
        
        nameTextField.resignFirstResponder()
        
    }
    
  
    @IBAction func categoryOneStepperValueChanged(_ sender: UIStepper) {
        
        updateCategoryOnePercent(number: categoryOneStepper.value as NSNumber)
    }
    
}
