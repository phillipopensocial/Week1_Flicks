//
//  MovieDetailViewController.swift
//  Week1_Flicks
//
//  Created by Phillip Pang on 10/16/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {


    @IBOutlet weak var theImage: UIImageView!
    @IBOutlet weak var theScrollView: UIScrollView!
    @IBOutlet weak var theLabel: UILabel!
    
    var image:UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        theImage.image = image
        
        //Setup the Scroll area
        theLabel.sizeToFit()
        
        let contentWidth = theScrollView.bounds.width
        let contentHeight = theLabel.bounds.height
        theScrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
