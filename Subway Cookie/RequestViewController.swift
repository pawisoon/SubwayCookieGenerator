//
//  RequestViewController.swift
//  Subway Cookie
//
//  Created by Paul Szydlowski on 03/12/2015.
//  Copyright © 2015 Pawel Szydlowski. All rights reserved.
//

import UIKit
import Foundation



class RequestViewController: UIViewController {
    var code_str: String = ""
    var email_str: String = ""
    var shortDate: String = ""
    var shortHour: String = ""
    var shortMinutes: String = ""
    
    var canStartPinging = false
    
    let api_address = "http://localhost:4567"
    //Properties: 
    
    @IBOutlet weak var Photo: UIImageView!

    
    @IBOutlet weak var acrivity_indicator: UIActivityIndicatorView!

    @IBOutlet weak var progress_bar: UIProgressView!
    
    
    @IBOutlet weak var server_status: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.server_status.setTitle("Checking..", forSegmentAtIndex: 1)
        if !Reachability.isConnectedToNetwork(){
            dispatch_async(dispatch_get_main_queue(), {
                //print("Not connected to the internet.")
                self.server_status.setTitle("No internet.", forSegmentAtIndex: 1)
                self.Photo.image = UIImage(named: "Cancel-50")
                self.progress_bar.setProgress(1.0, animated: false)
            })
            
        }
        else{
            
            self.ping()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ping(){
        self.post(["username":"jameson", "password":"password"], url: api_address+"/status") { (succeeded: Bool, msg: String) -> () in
            print(succeeded)
            
            
            if(succeeded) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.server_status.setTitle("Online", forSegmentAtIndex: 1)
                    self.progress_bar.setProgress(0.33, animated: true)
                    try! self.request_cookie()
                })
                
            }
            else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.server_status.setTitle("Offline", forSegmentAtIndex: 1)
                })
                
            }
            
        }
        
        
    }
    
    func post(params : Dictionary<String, String>, url : String, postCompleted : (succeeded: Bool, msg: String) -> ()) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        
        // or if you think the conversion might actually fail (which is unlikely if you built `params` yourself)
        //
        // do {
        //    request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        // } catch {
        //    //print(error)
        // }
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard data != nil else {
                print("no data found: \(error)")
                dispatch_async(dispatch_get_main_queue(), {
                    self.server_status.setTitle("Offline", forSegmentAtIndex: 1)
                    self.Photo.image = UIImage(named: "Cancel-50")
                    self.progress_bar.setProgress(1.0, animated: false)
                })

                return
            }

            
            
            // this, on the other hand, can quite easily fail if there's a server error, so you definitely
            // want to wrap this in `do`-`try`-`catch`:
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    let success = json["success"] as? Int                                  // Okay, the `json` is here, let's get the value for 'success' out of it
                    print("Success: \(success)")
                    if let success = json["success"] as? Bool {
                        print("Succes: \(success)")
                        postCompleted(succeeded: success, msg: "Logged in.")
                    }
                    return
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)    // No error thrown, but not NSDictionary
                    print("Error could not parse JSON: \(jsonStr)")
                    postCompleted(succeeded: false, msg: "Error")
                }
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                postCompleted(succeeded: false, msg: "Error")
            }
        }
        
        
        task.resume()
    }

    func request_cookie() throws -> String {
        print(code_str, email_str, shortDate,shortHour)
        dispatch_async(dispatch_get_main_queue(), {
            self.acrivity_indicator.startAnimating()
            self.progress_bar.setProgress(0.60, animated: true)
        })
        
        self.post(["username":"jameson", "password":"password","date":shortDate,"hours":shortHour,"mins":shortMinutes,"code":code_str,"email":email_str], url: api_address+"/login") { (succeeded: Bool, msg: String) -> () in
            print(succeeded)
            if(succeeded) {
                print("u got a cookie")
                let alert = UIAlertController(title: "Succes!", message:"Cokie was succesfully generated!", preferredStyle: .Alert)
                
                
                let yesAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
                    print("The user is okay.")
                }
                alert.addAction(yesAction)
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.presentViewController(alert, animated: false, completion: nil)
                    self.Photo.image = UIImage(named: "Ok-50")
                    self.progress_bar.setProgress(1.0, animated: true)
                    self.acrivity_indicator.stopAnimating()
                    self.acrivity_indicator.hidden = true
                })
                


            }
            else {
                print("cant get a cookie")
                let alert = UIAlertController(title: "Oops!", message:"Can't generate cookie now :(", preferredStyle:
                    .Alert)
                let yesAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
                    print("The user is okay.")
                }
                alert.addAction(yesAction)
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.presentViewController(alert, animated: false, completion: nil)
                    self.Photo.image = UIImage(named: "Cancel-50")
                    self.progress_bar.setProgress(1.0, animated: true)
                    self.acrivity_indicator.stopAnimating()
                    self.acrivity_indicator.hidden = true
                })
                
            }
            
            
        
        }
        return "finished"
    }







}
