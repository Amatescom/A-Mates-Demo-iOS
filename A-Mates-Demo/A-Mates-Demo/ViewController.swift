//
//  ViewController.swift
//  A-Mates-Demo
//
//  Created by Mikalai Kuts on 05/10/2023.
//

import UIKit
import AMatesiOS

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AMates.show()
    }
}

