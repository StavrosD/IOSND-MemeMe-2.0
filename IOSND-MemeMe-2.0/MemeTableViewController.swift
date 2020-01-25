//
//  MemeViewController.swift
//  IOSND-MemeMe-2.0
//
//  Created by Dimopoulos Stavros tou Athanasiou on 24/1/20.
//  Copyright © 2020 Dimopoulos Stavros tou Athanasiou. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    var memes:[Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        let meme = memes[indexPath.row]
        var message:String=""
        if meme.topText.count < 10 {
            message = meme.topText
        } else {
            message = String(meme.topText.prefix(10))
        }
        message += " ... "
        if meme.bottomText.count < 10 {
            message += meme.bottomText
        } else {
            message += meme.bottomText.suffix(10)
        }
        cell.memeText.text = message
       
        cell.memeImage.image = meme.memedImage
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let alertController = UIAlertController(title: "Test", message: "testing", preferredStyle: .alert)
        let s=UIAlertAction(title: "OK",style: .cancel, handler: nil)
        alertController.addAction(s)
    present(alertController,animated: true,completion: nil)
        */
        let memeShowVC = storyboard?.instantiateViewController(withIdentifier: "displayMemeVC")  as! MemeViewViewController
        memeShowVC.memeImage = memes[indexPath.row].memedImage
        navigationController?.pushViewController(memeShowVC, animated: true)
        
    }
    @IBOutlet var memeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        memeTableView.dataSource=self
        memeTableView.delegate=self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeTableView!.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
    
    }

    
}
