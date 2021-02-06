//
//  ViewController.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import UIKit
import Kingfisher

class TransformersViewController: UIViewController {

    var transformers = [Transformer]()
    
    @IBOutlet weak var fightButton: UIButton!
    @IBOutlet weak var footerLabelForTable: UILabel!
    @IBOutlet weak var transformersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToTransformerDetail))
        getAccessToken()
        transformers = LocalStorageManager.shared.loadData() ?? [Transformer]()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if transformers.isEmpty {
            footerLabelForTable.isHidden = false
        }
        else{
            footerLabelForTable.isHidden = true
        }
        
        if transformers.filter({$0.team == "A"}).count > 0 && transformers.filter({$0.team == "D"}).count > 0 {
            print("fight button should be enabled")
            fightButton.isEnabled = true
            fightButton.alpha = 1
        }
        else{
            print("fight button should be disabled")
            fightButton.isEnabled = false
            fightButton.alpha = 0.5
        }
    }

    @objc func goToTransformerDetail(){
        guard let storyBoard = storyboard else {
            return
        }
        guard let vc = storyBoard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.transformerDetailViewController) as? TransformerDetailViewController else {
            print("Unable to initialize \(ViewControllerIdentifiers.transformerDetailViewController)")
            return
        }
        
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func AddTransformer(transformer: Transformer) {
        transformers.append(transformer)
        LocalStorageManager.shared.saveData(transformers: transformers)
        
        transformersTableView.insertRows(at: [IndexPath(row: transformers.count - 1, section: 0)], with: .automatic)
        
    }
    
    func getAccessToken() {
        
        guard let _ = UserDefaults.standard.string(forKey: UserDefaultsKey.accessToken) else {
            print("Access Token not present")
            APIManager.shared.getAccessToken { (res) in
            
            }
            return
        }
        print("Access Token present, no need to get it")
    }
    
    func editTransformerDetail(transformer: Transformer){
        guard let storyBoard = storyboard else {
            return
        }
        guard let vc = storyBoard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.transformerDetailViewController) as? TransformerDetailViewController else {
            print("Unable to initialize \(ViewControllerIdentifiers.transformerDetailViewController)")
            return
        }
        vc.existingTransformer = transformer
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func fightButtonTapped(_ sender: UIButton) {
        
        print("Tapped")
    }
    
}

extension TransformersViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transformerCell") as! TransformerTableViewCell
        cell.nameLabel.text = transformers[indexPath.row].name
        cell.ratingLabel.text = String(transformers[indexPath.row].overallRating)
        let url = URL(string: transformers[indexPath.row].team_icon ?? "")
        cell.teamLogoImageView.kf.setImage(with: url)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            let alert = UIAlertController(title: "Delete Transformer?", message: "Are you sure you want to delete this transformer?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes",
                                          style: .default,
                                          handler: { [weak self] (_) in
                                            
                                            guard let strongSelf = self,
                                                  let id = strongSelf.transformers[indexPath.row].id else {
                                                return
                                            }
                                           
                                            APIManager.shared.deleteTransformer(transformerId: id) { (Result) in
                                                switch Result{
                                                case .success(let success):
                                                    if success{
                                                        //Todo: remove at index
                                                        strongSelf.transformers.remove(at: indexPath.row)
                                                        LocalStorageManager.shared.saveData(transformers: strongSelf.transformers)
                                                        print("Here")
                                                        strongSelf.transformersTableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
                                                        
                                                    }
                                                case .failure(let err):
                                                print(err)
                                                }
                                                
                                            }
//
                                          }))
            alert.addAction(UIAlertAction(title: "No",
                                          style: .cancel,
                                          handler: { _ in
                                            alert.dismiss(animated: true)
                                          }))
            self.present(alert, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        editTransformerDetail(transformer: transformers[indexPath.row])
    }
    
}

