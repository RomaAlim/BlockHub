//
//  LogInView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 29.04.2024.
//

import UIKit
import SnapKit

protocol LogInViewInput{
//    var output: LogInViewOutput {get set}
}

protocol LogInViewOutput{
    func userSelectLogIn(withLogin login:String, password:String)
}

class LogInView: UIViewController, LogInViewInput {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }




}
