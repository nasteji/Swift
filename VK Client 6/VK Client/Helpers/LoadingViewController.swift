//
//  LoadingViewController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 24.03.2021.
//

import UIKit

class LoadingViewController: UIViewController {

    lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        return view
    } ()

    func showLoading() {
        view.addSubview(loadingView)
        loadingView.center = view.center
        loadingView.alpha = 0

        UIView.animate(withDuration: 0.5, animations: {
            self.loadingView.alpha = 1
        })
    }
    func hideLoading() {
        UIView.animate(withDuration: 0.5, animations: {
            self.loadingView.alpha = 0
        }, completion: { _ in
            self.loadingView.removeFromSuperview()
        })
    }
}
