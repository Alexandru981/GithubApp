//
//  LoginViewController.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import UIKit

// This is a interface for the LoginViewController. The interactor will know about this protocol instead
// of the actual view controller. This alows for easier testing and substitution of the view.
protocol LoginView: class {
    func present(error: Error)
}

class LoginViewController: UIViewController {

    var interactor: LoginInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK: - Actions
    
    @IBAction func didTapLogin(_ sender: Any) {
        self.interactor.logIn()
    }
}

extension LoginViewController: LoginView {
    
    func present(error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
