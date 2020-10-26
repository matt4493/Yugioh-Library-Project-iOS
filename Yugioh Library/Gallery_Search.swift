//
//  Gallery_Search.swift
//  Yugioh Library
//
//  Created by Matt on 5/18/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation
import Haneke
import UIKit
//import Kingfisher

class Gallery_Search: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionview: UICollectionView!
    
    @IBOutlet weak var mainButton:UIBarButtonItem!
    
    
    @IBOutlet var menu_title: UINavigationItem!
    
    var images_cache = [String:UIImage]()
    var images = [String]()
    let link = "http://www.kaleidosblog.com/tutorial/get_images.php"
    
    var returnedSets = [String]()
    var returnedCardTypes = NSMutableArray()
    
    var set_image_url = ""
    
    var placeholderImage = UIImage(imageLiteral: "ic_error")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            mainButton.target = revealViewController()
            mainButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        var storyboard: UIStoryboard
        
        // instantiate the `UIWindow`
        //[self.window, setRootViewController,:someController];
        // self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        
        // Get the model name based in the extension.
        let modelName = UIDevice.current.modelName
        if (modelName.contains("5.5") != false){
            //5.5" screen
            //layout.itemSize = CGSizeMake(142,202)
            print("rgrgt")
        }
        else if (modelName.contains("9.7") != false) {
            //9.7" screen
            layout.itemSize = CGSize(width: 165,height: 301)
        }
        else if (modelName.contains("Simulator") != false) {
            
        }
        
        
        
        
        
        self.collectionview.setCollectionViewLayout(layout, animated: true)
        
        self.getSets()
        
        collectionview.delegate = self
        collectionview.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return returnedSets.count
    }
    
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:GalleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCell
        
        var set_name = returnedSets[indexPath.row]
        
        cell.tag = indexPath.row
        
        Gallery_Search.process_AND_return_card_URLS(set_name) {
            returnedURL in
            self.set_image_url = returnedURL
            
            //print("FUNC = \(card_image_url)")
            var check_comma = self.set_image_url.replacingOccurrences(of: "%252C", with: "%2C")
            let check_special = check_comma.replacingOccurrences(of: "", with: "")
            let check_doubleAPOST = check_special.replacingOccurrences(of: "%27%27", with: "_")
            var check_apost = check_doubleAPOST.replacingOccurrences(of: "%27", with: "'")
            //var set_image = "http://static.api3.studiobebop.net/ygo_data/set_images/Shining_Victories.jpg"
            var final_URL = check_apost
            
            //print("Apost Replaced = \(check_apost)")
            
            let cache = Shared.imageCache
            
            
            //check_apost = check_apost.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            //print("Encoded URL = \(check_apost)")
            let finished_URL = URL(string: final_URL)
            
            
            /*var image2 = KingfisherManager.sharedManager.retrieveImageWithURL(check_apost, optionsInfo: .None, progressBlock: nil), completionHandler: { imageURL in
             print("\(card_name): Finished")
             })*/
            
            /*if ImageCache.defaultCache.cachedImageExistsforURL(finished_URL!) == true {
                //print("image is already cached.")
                
                if cell.tag == indexPath.row{
                    cell.collection_image.image = UIImage(imageLiteral: "ic_error")
                    KingfisherManager.sharedManager.retrieveImageWithURL(finished_URL!, optionsInfo: .None, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                        cell.collection_image.image = image
                        print("Set Name\(set_name): Retrieved cached image")
                    })
                }
                
            }else{
                if cell.tag == indexPath.row{
                    cell.collection_image.kf_setImageWithURL(finished_URL!, placeholderImage: self.placeholderImage, optionsInfo: .None, completionHandler: { image, error, cacheType, imageURL in
                        print("Downloading Image: \(set_name): Finished")
                    })
                }
                
            }*/
            
            // haneke - Retrieve images from network & cache
            let fetcher_net = NetworkFetcher<UIImage>(URL: finished_URL!)
            let fetcher_disk = DiskFetcher<UIImage>(path: check_apost)
            cache.fetch(fetcher: fetcher_disk).onSuccess { image in
                //cell.card_imageIV.hnk_fetcher.cancelFetch()
                //print("Found image cache for : \(set_name)")
                if cell.tag == indexPath.row{
                    cell.collection_image.image = image
                }
            }.onFailure{ image in
                    //print("Unavailable to find image cache, fetching from network")
                    cache.fetch(fetcher: fetcher_net).onSuccess { image in
                    //print("Successfully downloaded image for : \(set_name)")
                        if cell.tag == indexPath.row{
                            cell.collection_image.image = image
                        }
                        cache.fetch(fetcher: fetcher_disk).onSuccess { image in
                            //print("Successfully stored image in cache for : \(set_name)")
                            }.onFailure { image in
                             //print("Failed to store image in cache for : \(set_name). A network request will be created on next fetch for the image.")
                        }
                }
            }
        }
        
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell:GalleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCell
        
        let set_name = returnedSets[indexPath.row]
        
        let alertController = UIAlertController(title: "Chosen Booster Set", message:
            set_name, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,
            handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    internal func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getSets()
    }

    
    func getSets()
    {
        returnedSets = [String]()
        //print("SIMPLE SEARCH - ALL NAMES - String Array PULL Test 1")
        returnedSets = Card_Adapter.getInstance().getAlllPackNames()
        //print("SIMPLE SEARCH - ALL NAMES - String Array PULL Test 2")
        collectionview.reloadData()
        
        //construct_image_url("", passed_SetNumber: "")
        //print("SIMPLE SEARCH - ALL NAMES - String Array PULL Test 3")
        
        //self.process_AND_return_card_URLS()
    }
    
    class func process_AND_return_card_URLS(_ passed_CardName: String, completionHandler: @escaping (_ returnedURL: String) -> ()) {
        
        let replace_spaces = passed_CardName.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.literal, range: nil)
        //let replace_special_characters = replace_spaces.stringByReplacingOccurrencesOfString("%C3%9C", withString: "Ü")
        if passed_CardName.contains("Beast Machine King"){
            completionHandler("http://static.api3.studiobebop.net/ygo_data/card_images/Beast_Machine_King_Barbaros_Ür.jpg")
        }else {
            let url = URL(string: "http://yugiohprices.com/api/set_image/" + "\(replace_spaces)")
            //print("http://yugiohprices.com/api/card_image/\(replace_spaces)")
            
            let request = NSMutableURLRequest(url: url!)
            var card_image_url = ""
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                if let response = response, let data = data {
                    //print(response)
                    //print("Response URL = " + response.URL!.absoluteString)
                    //print("URL = \(response.URL!.absoluteString)")
                    completionHandler(returnedURL: response.URL!.absoluteString)
                } else {
                    print(error)
                }
            }) 
            
            task.resume()
        }
        
    }
}
