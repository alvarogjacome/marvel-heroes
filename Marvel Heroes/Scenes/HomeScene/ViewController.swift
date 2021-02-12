//
//  ViewController.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Combine
import UIKit

class ViewController: UIViewController {
    private lazy var cancelBag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        MarvelHeroesAPIClient().getCharacter(id: "1011334")
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancelBag)
    }
}
