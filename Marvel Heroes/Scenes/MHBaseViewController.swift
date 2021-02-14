//
//  MHBaseViewController.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 13/2/21.
//  Copyright © 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

protocol MHBaseDisplayLogic {
    func displayLoading()
    func displayError(error: Error, tapAction: @escaping () -> Void)
    func displayEmptyState(tapAction: @escaping () -> Void)
    func displayCompleted()
}

class MHBaseViewController: UIViewController, MHBaseDisplayLogic {
    let loadingAlert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavbar()
    }

    private func setupNavbar() {
        let imageView = UIImageView(image: UIImage(named: "navbarLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowRadius = 8
        imageView.layer.shadowColor = UIColor(named: "AccentColor")?.cgColor
        imageView.layer.shadowOffset = .init(width: 0, height: 0)
        imageView.layer.shadowOpacity = 1
        navigationItem.titleView = imageView
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
    }
    func hideTitleView() {
        navigationItem.titleView = nil
    }

    func displayLoading() {
        loadingAlert.view.tintColor = UIColor.black
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()

        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true, completion: nil)
    }

    func displayCompleted() {
        dismissLoading()
    }

    func dismissLoading() {
        loadingAlert.dismiss(animated: true)
    }

    func displayError(error: Error, tapAction: @escaping () -> Void) {
        dismissLoading()

        let alert = UIAlertController(title: "⛔️ Error!", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .destructive) { _ in
            assertionFailure(error.localizedDescription)
            tapAction()
        }
        alert.addAction(action)

        present(alert, animated: true)
    }

    func displayEmptyState(tapAction: @escaping () -> Void) {
        dismissLoading()

        let alert = UIAlertController(title: "🌵 🌵 🌵", message: "This seems empty...", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            tapAction()
        })
        alert.addAction(action)

        present(alert, animated: true)
    }
}
