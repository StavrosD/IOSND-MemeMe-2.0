//
//  MemeViewViewController.swift
//  IOSND-MemeMe-2.0
//
//  Created by Dimopoulos Stavros tou Athanasiou on 24/1/20.
//  Copyright © 2020 Dimopoulos Stavros tou Athanasiou. All rights reserved.
//

import UIKit

class MemeViewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = memeImage
        tabBarController?.tabBar.isHidden=true
        
    }
    var memeImage:UIImage? = nil
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        tabBarController?.tabBar.isHidden=false
        self.unwind(for: unwindSegue, towards: subsequentVC)
        
    }
}
