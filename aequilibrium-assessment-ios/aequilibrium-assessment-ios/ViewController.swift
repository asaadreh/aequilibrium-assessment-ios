//
//  ViewController.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTransformer))
    }

    @objc func addTransformer(){
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.transformerDetailViewController) else {
            print("Unable to initialize \(ViewControllerIdentifiers.transformerDetailViewController)")
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

