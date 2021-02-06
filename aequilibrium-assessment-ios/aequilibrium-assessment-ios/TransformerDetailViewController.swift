//
//  TransformerDetailViewController.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import UIKit

class TransformerDetailViewController: UIViewController {

    
    var existingTransformer : Transformer?
    var newTransformerForm : [BaseTableViewCellViewModel]!
    
    
    var delegate : TransformersViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadExistingTransformer()
        
    }
    
    func loadExistingTransformer() {
        guard let transformer = existingTransformer else {
           newTransformerForm = [BaseTableViewCellViewModel(rowType: .header),
                                  NameTableViewCellViewModel(rowType: .setName, placeHolder: "Saadatron"),
                                  AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Strength"),
                                  AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Intelligence"),
                                  AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Speed"),
                                  AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Endurance"),
                                  AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Rank"),
                                  AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Courage"),
                                  AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "FirePower"),
                                  AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Skill"),
                                  TeamTableViewCellViewModel(rowType: .setTeam),
                                  BaseTableViewCellViewModel(rowType: .submit)]
            return
        }
        
        var isDecepticon = Bool()
        if transformer.team == "D"{
            isDecepticon = true
        }
        else {
            isDecepticon = false
        }
        
        
        newTransformerForm = [BaseTableViewCellViewModel(rowType: .header),
                              NameTableViewCellViewModel(rowType: .setName, placeHolder: "Saadatron", name: transformer.name),
                              AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Strength", value: transformer.strength),
                              AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Intelligence", value: transformer.intelligence),
                              AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Speed", value: transformer.speed),
                              AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Endurance", value: transformer.endurance),
                              AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Rank", value: transformer.rank),
                              AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Courage", value: transformer.courage),
                              AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "FirePower", value: transformer.firepower),
                              AttributeTableViewCellViewModel(rowType: .setAttribute, attribute: "Skill", value: transformer.skill),
                              TeamTableViewCellViewModel(rowType: .setTeam, isDecepticon: isDecepticon),
                              BaseTableViewCellViewModel(rowType: .submit)]
    }
    
    
    func createTransformer() {
        let transformer = createTransformerObject()
        
        APIManager.shared.createTransformer(transformer: transformer) { [self] (res) in
            
            switch res{
            case .success(let transformer):
                print(transformer)
                
                self.delegate?.AddTransformer(transformer: transformer)
                self.navigationController?.popToRootViewController(animated: true)
                
            case .failure(let err):
                let alertView = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    
                }))
                present(alertView, animated: true)
            }
        }
        
//        LocalStorageManager.shared.saveTransformer(trans: transformer)
//
//
    }
    
    func createTransformerObject() -> Transformer {
        
        let name = (newTransformerForm[1] as? NameTableViewCellViewModel)?.name ?? ""
        let strength = (newTransformerForm[2] as? AttributeTableViewCellViewModel)?.value ?? 0
        let intelligence = (newTransformerForm[3] as? AttributeTableViewCellViewModel)?.value ?? 0
        let speed = (newTransformerForm[4] as? AttributeTableViewCellViewModel)?.value ?? 0
        let endurance = (newTransformerForm[5] as? AttributeTableViewCellViewModel)?.value ?? 0
        let rank = (newTransformerForm[6] as? AttributeTableViewCellViewModel)?.value ?? 0
        let courage = (newTransformerForm[7] as? AttributeTableViewCellViewModel)?.value ?? 0
        let firepower = (newTransformerForm[8] as? AttributeTableViewCellViewModel)?.value ?? 0
        let skill = (newTransformerForm[9] as? AttributeTableViewCellViewModel)?.value ?? 0
        
        let isDecepticon = (newTransformerForm[10] as? TeamTableViewCellViewModel)?.isDecepticon
        let team = isDecepticon! ? "D" : "A"
        
        let transformer = Transformer(name: name,
                                      strength: strength,
                                      intelligence: intelligence,
                                      speed: speed,
                                      endurance: endurance,
                                      rank: rank,
                                      courage: courage,
                                      firepower: firepower,
                                      skill: skill,
                                      team: team)
        return transformer
    }
}


extension TransformerDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return newTransformerForm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = newTransformerForm[indexPath.row].rowType
        
        switch cellType {
        
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue) as! HeaderTableViewCell
            
            return cell
        case .setAttribute:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue) as! AttributeTableViewCell
            cell.viewModel = newTransformerForm[indexPath.row] as? AttributeTableViewCellViewModel
            return cell
        case .setName:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue) as! NameTableViewCell
            cell.viewModel = newTransformerForm[indexPath.row] as? NameTableViewCellViewModel
            return cell
        case .setTeam:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue) as! TeamTableViewCell
            cell.viewModel = newTransformerForm[indexPath.row] as? TeamTableViewCellViewModel
            return cell
        case .submit:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue) as! SubmitTableViewCell
            cell.delegate = self
            return cell
        }
    }
}

