//
//  MovieDetailViewController.swift
//  Week1_Flicks
//
//  Created by Phillip Pang on 10/16/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailViewController: UIViewController {


    @IBOutlet weak var theImage: UIImageView!
    @IBOutlet weak var theScrollView: UIScrollView!
    @IBOutlet weak var theSubView: UIView!
    @IBOutlet weak var theTitle: UILabel!
    @IBOutlet weak var theReleaseDate: UILabel!
    @IBOutlet weak var theLanguage: UILabel!
    @IBOutlet weak var theOverview: UILabel!

    
    //        cell.thePopularity.text = aMovie?["popularity"] as? String
    //        cell.theOriginalLanguage.text = aMovie?["original_language"] as? String
    //        cell.theReleaseDate.text = aMovie?["release_date"] as? String
    
    
    var anImage:String?
    var aTitle: String?
    var anOverview:String?
    var anPopularity:String?
    var aLanguage:String?
    var aReleaseDate:String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if anImage != nil {
            self.theImage.setImageWith( URL(string: anImage! )!)

        }
        theTitle.text = aTitle
        theReleaseDate.text = aReleaseDate
        theLanguage.text = aLanguage
        theOverview.text = anOverview
        
        //Setup the Scroll area
        theTitle.sizeToFit()
        theReleaseDate.sizeToFit()
        theLanguage.sizeToFit()
        theOverview.sizeToFit()
        theSubView.sizeToFit()
        
        let contentWidth = theScrollView.bounds.width
        let contentHeight = theSubView.bounds.height
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
