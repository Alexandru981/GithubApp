//
//  ViewController.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 13/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didSucceed(notif:)),
                                               name: .GHOAuthSuccessful,
                                               object: nil)
    }

    
    @IBAction func didTapLogin(_ sender: Any) {
        
        guard let url = URL(string: "https://github.com/login/oauth/authorize?scope=repo&client_id=\(kClientID)") else {
            return
        }
        
        guard UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func didSucceed(notif: Notification) {
        guard let code = notif.userInfo?["code"] as? String else { return }
        
        print(code)
        print("YES")
    }
}

