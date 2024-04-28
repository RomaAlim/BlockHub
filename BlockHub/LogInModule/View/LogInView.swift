//
//  LogInView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 29.04.2024.
//

import UIKit

protocol LogInViewInput{
    var output: LogInViewOutput {get set}
}

protocol LogInViewOutput{
    func userSelectLogIn(withLogin login:String, password:String)
}

class LogInView: UIViewController, LogInViewInput {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var output: LogInViewOutput
    init(output: LogInViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
