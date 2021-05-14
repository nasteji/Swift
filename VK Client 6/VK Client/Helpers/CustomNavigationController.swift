//
//  CustomNavigationController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 31.03.2021.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard operation != .none else { return nil }
        switch operation {
        case .push:
            interactiveTransition.viewController = toVC
        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
        default:
            return nil
        }
        
        return Animator(isDismissing: operation == .pop)
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }

    
}
