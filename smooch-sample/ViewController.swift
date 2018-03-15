//
//  ViewController.swift
//  smooch-sample
//
//  Created by Danilo Bürger on 15.03.18.
//  Copyright © 2018 Danilo Bürger. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {

    override func loadView() {
        view = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        tabBarItem.title = "Home"

        let button = UIButton(type: .system)
        button.setTitle("Trigger Event", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(trigger), for: .touchUpInside)

        view.addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.center.equalTo(self.view)
        }
    }

    @objc func trigger() {
        // The following would run on the backend
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + Configuration.appToken()
        ]
        let preCreateParameters: Parameters = [
            "userId": Configuration.userId,
        ]
        let messageParameters: Parameters = [
            "text": "Hello World!",
            "role": "appMaker",
            "type": "text"
        ]
        Alamofire.request(
            "https://api.smooch.io/v1/appusers",
            method: .post,
            parameters: preCreateParameters,
            encoding: JSONEncoding.default,
            headers: headers).responseJSON { response in

            debugPrint(response)

            Alamofire.request(
                "https://api.smooch.io/v1/appusers/" + Configuration.userId + "/messages",
                method: .post,
                parameters: messageParameters,
                encoding: JSONEncoding.default,
                headers: headers).responseJSON { response in

                debugPrint(response)
            }
        }
    }

}
