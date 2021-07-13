//
//  MainViewController.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 10.07.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var lastResult: UILabel!
    
    var results: ((Date, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? GameViewController else { return }
        destinationVC.results = { [weak self] (date, result) in
            guard let self = self else { return }
            self.results?(date, result)
            self.lastResult.text = "Правильных ответов: \(result)"
        }
        
    }

}


