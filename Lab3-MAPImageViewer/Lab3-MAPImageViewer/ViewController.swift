//
//  ViewController.swift
//  Lab3-MAPImageViewer
//
//  Created by Jorge Bejarano on 2020-03-05.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    //@IBOutlet weak var nextBtn: UIButton!
    
    //@IBOutlet weak var prevBtn: UIButton!
    
    @IBOutlet weak var imageViewer: UIImageView!
    
    @IBOutlet weak var numberOfLabel: UILabel!
    lazy var currentObj = urlArrayMAP.init()
    
    
    /*func imageLoad(links : URL){
        let images = URL(links)
    }*/
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageViewer.image = image
            }
        }
    }
    
    @IBAction func prevIsPressed(_ sender: Any) {
        if currentObj.cnt == 0 {
            numberOfLabel.text = "can't go back"
        }
        else {
            currentObj.cnt-=1
            numberOfLabel.text = String(currentObj.cnt + 1) + " out of 4"
            setImage(from: currentObj.urls[currentObj.cnt])
            
        }
        
    }
    
    @IBAction func nextIsPressed(_ sender: Any) {
        if currentObj.cnt == 4 {
            numberOfLabel.text = "can't go next"
        }
        else {
            setImage(from: currentObj.urls[currentObj.cnt])
            currentObj.cnt+=1
            numberOfLabel.text = String(currentObj.cnt) + " out of 4"
            //numberOfLabel.text = "out of 4"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        let data = try? Data(contentsOf: url!)
        imageView.image = UIImage(data: data!)
        
        
        let url = URL(string: image.url)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data!)
            }
        }*/
        
        //setImage(from: urls[0])
        
        
    }


}

