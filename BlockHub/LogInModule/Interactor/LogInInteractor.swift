//
//  LogInInteractor.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 29.04.2024.
//

import UIKit

protocol LogInInteractorInput{
    var output:LogInInteractorOutput {get}
    func LogIn(withLogin login:String, password:String)
}

protocol LogInInteractorOutput{
    func didReceive(error: String)
    func didLogIn(withLogin login:String)
}
final class LogInInteractor{
    
}
