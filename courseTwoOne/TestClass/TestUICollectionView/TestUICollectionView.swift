//
//  TestUICollectionView.swift
//  courseTwoOne
//
//  Created by Andrey Vensko on 6.02.22.
//

import UIKit

class TestUICollectionView: UIViewController {


    override func loadView() {
        super.loadView()

        let uiLabe = UILabel()
        uiLabe.text = "Hello gays"
        view.addSubview(uiLabe)

        uiLabe.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiLabe.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiLabe.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
        
    }



    override func viewDidLoad() {
        super.viewDidLoad()


    }
}
