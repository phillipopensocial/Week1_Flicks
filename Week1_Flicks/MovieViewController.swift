//
//  ViewController.swift
//  Week1_Flicks
//
//  Created by Phillip Pang on 10/15/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD


class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var theUpdateLabel: UILabel!
    @IBOutlet weak var theNetworkMsgView: UIView!
    
    var theMovies: NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Hide the Network message view
        self.theNetworkMsgView.isHidden = true
        self.theNetworkMsgView.isHidden = false
  //      self.theNetworkMsgView.isHidden = true


        
        //Setup Refresh Control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        self.tableView.insertSubview(refreshControl, at: 0)

        
        //Setup Table
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 100
        //tableView.rowHeight = UITableViewAutomaticDimension

        
        retrieveData(refreshControl:nil)
    }

    func retrieveData(refreshControl : UIRefreshControl?) {
        
        print ("\nRetrieveData: Begin")
        
        //Making a call to MovieDB
        
        // Configuration:     'https://api.themoviedb.org/3/configuration?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed'
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        //let offset = 0
        let url = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&page=1")
        //let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&offset=\(offset)")
        let request = URLRequest(url: url!)
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 1.0;
        let session = URLSession(
            configuration: sessionConfig,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )

        
        
        //Show the HUD
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = "Loading..."
        
        
        //Start the Async fetching
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    
                    
                    //Looping the
                    self.theMovies = responseDictionary.value( forKeyPath: "results") as? NSArray
                    
                    print(url)
                    print("\n\nRetrieveData: Found Reponse data from API!")
                     for aMovie in  self.theMovies!{
                     let aMovieDetail = aMovie as! NSDictionary
                     print("Movie: \(aMovieDetail["title"])")

                     }

                    
                    //reload the table
                    self.tableView.reloadData()
                    
                    //Update the timestamp
                    let now = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    formatter.timeZone = TimeZone(secondsFromGMT: 0)
                    self.theUpdateLabel.text = "Update: " + formatter.string(from: now)

                    
                    //Stop Refresh Control
                    if( refreshControl != nil ) {
                        refreshControl?.endRefreshing()
                    }
                
                    //Delay
                    sleep(1)
                    progressHUD.hide(animated: true)
                }
                
                
            }else{
                
                //Notify of error
                print("\nsleep started")
                progressHUD.hide(animated: true)
                self.theNetworkMsgView.isHidden = false
                sleep(3)
                print("\nsleep ended")
                self.theNetworkMsgView.isHidden = true

            }
            
        });
        task.resume()
        
        print ("\nRetrieveData: Ended")
    }

    
    
    //Setup Screen refresh
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        NSLog("\nRefreshControlAction Called")
        self.retrieveData(refreshControl: refreshControl)


    }


 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.MovieCellClass", for: indexPath) as! MovieCell
        
        //Extract
        let aMovie = self.theMovies![indexPath.row ] as? NSDictionary
        
        //Setup the data
        cell.theTitle.text = aMovie?["title"] as? String
        cell.theOverview.text = aMovie?["overview"] as? String
        cell.theLanguage = aMovie?["original_language"] as? String
        cell.theReleaseDate = aMovie?["release_date"] as? String
        
        
        if let anImagePath = (aMovie?["backdrop_path"] as? String) {
            let anImagePrePath = "https://image.tmdb.org/t/p/w185"
            let anImageFinalPath = anImagePrePath + anImagePath
            cell.theImage.setImageWith( URL(string: anImageFinalPath )!)
            
            //Setup the large backdrop image
            cell.pathForBackdropImage = "https://image.tmdb.org/t/p/w780" + anImagePath
        }
        
        return cell
 
/*
         [0]	(null)	"genre_ids" : 3 elements
         [1]	(null)	"adult" : (no summary)
         [2]	(null)	"id" : Int64(333484)
         [3]	(null)	"original_title" : "The Magnificent Seven"
         [4]	(null)	"backdrop_path" : "/T3LrH6bnV74llVbFpQsCBrGaU9.jpg"
         [5]	(null)	"vote_average" : Double(4.59)
         [6]	(null)	"popularity" : Double(27.313)
         [7]	(null)	"poster_path" : "/z6BP8yLwck8mN9dtdYKkZ4XGa3D.jpg"
         [8]	(null)	"overview" : "A big screen remake of John Sturges\' classic western The Magnificent Seven, itself a remake of Akira Kurosawa\'s Seven Samurai. Seven gun men in the old west gradually come together to help a poor village against savage thieves."
         [9]	(null)	"title" : "The Magnificent Seven"
         [10]	(null)	"original_language" : "en"
         [11]	(null)	"vote_count" : Int64(532)
         [12]	(null)	"release_date" : "2016-09-14"	
         [13]	(null)	"video" : (no summary)
*/
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print ("\nReturn Movie Count: \(theMovies?.count)")
        return  (theMovies?.count) ?? 0

        
    }    


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Get rid of the gray bar
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let dvc = segue.destination as! MovieDetailViewController
        let indexPath = tableView.indexPathForSelectedRow
    
        let aMovieCell = self.tableView.cellForRow(at: indexPath!) as? MovieCell
        
        print ("\n\nPrepare for seque: \(aMovieCell?.theImage.image)")

        
        //Passing content
        dvc.aTitle = aMovieCell?.theTitle.text
        dvc.anOverview = aMovieCell?.theOverview.text
        dvc.aReleaseDate = aMovieCell?.theReleaseDate
        dvc.aLanguage = aMovieCell?.theLanguage
        //dvc.image = aMovieCell?.theImage.image
        dvc.anImage = aMovieCell?.pathForBackdropImage
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

