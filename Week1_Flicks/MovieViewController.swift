//
//  ViewController.swift
//  Week1_Flicks
//
//  Created by Phillip Pang on 10/15/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit
import AFNetworking


class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchCancelButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var theMovies: NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 123

        
        retrieveData()
    }

    func retrieveData() {
        
        //Making a call to MovieDB
        
        // Configuration:     'https://api.themoviedb.org/3/configuration?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed'
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let offset = 0
        let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        //let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&offset=\(offset)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    
                    
                    //Looping the
                    self.theMovies = responseDictionary.value( forKeyPath: "results") as? NSArray
                    
                    print(url)
                    print("\n\nFound Reponse data from API!")
                     for aMovie in  self.theMovies!{
                     let aMovieDetail = aMovie as! NSDictionary
                     print("Movie: \(aMovieDetail["title"])")

                     }

                    
                    //reload the table
                    self.tableView.reloadData()
                    
                }
                
                
                
            }
            
        });
        task.resume()
        
        
    }
    
    
    //Setup Screen refresh
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.retrieveData()
        refreshControl.endRefreshing()
        
        print("\nScreen Refreshed")
    }


 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.MovieCellClass", for: indexPath) as! MovieCell
        
        //Extract
        let aMovie = self.theMovies![indexPath.row ] as? NSDictionary
        
        //Setup the data
        cell.theTitle.text = aMovie?["title"] as? String
        cell.theOverview.text = aMovie?["overview"] as? String
        
        if let anImagePath = (aMovie?["backdrop_path"] as? String) {
            let anImagePrePath = "https://image.tmdb.org/t/p/w185/"
            let anImageFinalPath = anImagePrePath + anImagePath
            cell.theImage.setImageWith( URL(string: anImageFinalPath )!)
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
        
        NSLog("\nReturn Movie Count: \(theMovies?.count)")
        return  (theMovies?.count) ?? 0

        
    }    

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

