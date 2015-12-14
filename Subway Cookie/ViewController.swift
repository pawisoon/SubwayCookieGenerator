//
//  ViewController.swift
//  Subway Cookie
//
//  Created by Paul Szydlowski on 02/11/2015.
//  Copyright © 2015 Pawel Szydlowski. All rights reserved.
//

//TODO:
// -queue for cookie requests and live update of the status  -> new screen for this
// setup server
// test
// publish

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate{

    //MARK: Properties
    
    @IBOutlet weak var send_b: UIBarButtonItem!
    @IBOutlet weak var code: UITextField!
    
    @IBOutlet weak var date: UIDatePicker!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var activity_indicator: UIActivityIndicatorView!

    
    enum defaultsKeys {
        static let keyOne = "code"
        static let keyTwo = "email"
    }
    
    
//    @IBAction func sent(sender: AnyObject) {
//        var code_str = code.text!
//        var email_str = email.text!
//        var shortDate: String {
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "dd/MM/yyyy"
//            return dateFormatter.stringFromDate(date.date)
//        }
//        var shortHour: String {
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "HH tt"
//            return dateFormatter.stringFromDate(date.date)
//        }
//        var shortMinutes: String {
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "mm"
//            return dateFormatter.stringFromDate(date.date)
//        }
    
        //print(code_str, email_str, shortDate,shortHour)

//        self.post(["username":"jameson", "password":"password","date":shortDate,"hours":shortHour,"mins":shortMinutes,"code":code_str,"email":email_str], url: "http://localhost:4567/login") { (succeeded: Bool, msg: String) -> () in
//            
//            if(succeeded) {
//                let alert = UIAlertController(title: "Succes!", message:"Cokie was succesfully generated!", preferredStyle: .Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
//                self.presentViewController(alert, animated: false){}
//                
//            }
//            else {
//                let alert = UIAlertController(title: "Oops!", message:"Can't generate cookie now :(", preferredStyle: .Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
//                self.presentViewController(alert, animated: false){}
//                
//                
//            }
//    
//        }
//
//        
//    }
//    
    
//    func post(params : Dictionary<String, String>, url : String, postCompleted : (succeeded: Bool, msg: String) -> ()) {
//        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        
//        let session = NSURLSession.sharedSession()
//        request.HTTPMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
//        
//        // or if you think the conversion might actually fail (which is unlikely if you built `params` yourself)
//        //
//        // do {
//        //    request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//        // } catch {
//        //    //print(error)
//        // }
//        
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            guard data != nil else {
//                //print("no data found: \(error)")
//                return
//            }
//            
//            // this, on the other hand, can quite easily fail if there's a server error, so you definitely
//            // want to wrap this in `do`-`try`-`catch`:
//            
//            do {
//                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
//                    let success = json["success"] as? Int                                  // Okay, the `json` is here, let's get the value for 'success' out of it
//                    //print("Success: \(success)")
//                    if let success = json["success"] as? Bool {
//                        //print("Succes: \(success)")
//                        postCompleted(succeeded: success, msg: "Logged in.")
//                    }
//                    return
//                } else {
//                    //let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)    // No error thrown, but not NSDictionary
//                    ////print("Error could not parse JSON: \(jsonStr)")
//                    postCompleted(succeeded: false, msg: "Error")
//                }
//            } catch let parseError {
//                //print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
//                //let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                ////print("Error could not parse JSON: '\(jsonStr)'")
//                postCompleted(succeeded: false, msg: "Error")
//            }
//        }
//        
//        
//        task.resume()
//    }



    
    @IBAction func save(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue(code.text!, forKey: defaultsKeys.keyOne)
        defaults.setValue(email.text!, forKey: defaultsKeys.keyTwo)
        
        defaults.synchronize()
        
        let alert = UIAlertController(title: "Data saved!", message:"", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        self.presentViewController(alert, animated: false){}
        
        
        
    }
    
    func restoreData(){
        let defaults = NSUserDefaults.standardUserDefaults()
        if let saved_code = defaults.stringForKey(defaultsKeys.keyOne) {
            if saved_code.isEmpty != true{
                code.text = saved_code
            }
        }
        
        if let saved_email = defaults.stringForKey(defaultsKeys.keyTwo) {
            if saved_email.isEmpty != true{
                email.text = saved_email
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        send_b.enabled = false
        code.delegate = self
        email.delegate = self
        checkValidFields()
        restoreData()
        if !Reachability.isConnectedToNetwork(){
            //print("Not connected to the internet.")
            let alert = UIAlertController(title: "Oops!", message: "No internet connection", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default){ _ in})
            self.presentViewController(alert, animated: true){}
        }
        checkValidFields()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //disable save button while editing
        send_b.enabled = false
        
    }
    
    func checkValidFields(){
        let code_text = code.text ?? ""
        let email_text = email.text ?? ""
        if(!code_text.isEmpty && !email_text.isEmpty){
            send_b.enabled = true
        }
        //print(!code_text.isEmpty)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidFields()
    }
    
    //hide keyboard on click
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var requestVC: RequestViewController = segue.destinationViewController as! RequestViewController
        
        var shortDate: String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.stringFromDate(date.date)
        }
        var shortHour: String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH tt"
            return dateFormatter.stringFromDate(date.date)
        }
        var shortMinutes: String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "mm"
            return dateFormatter.stringFromDate(date.date)
        }
        
        requestVC.code_str = code.text!
        requestVC.email_str = email.text!
        requestVC.shortDate = shortDate
        requestVC.shortHour = shortHour
        requestVC.shortMinutes = shortMinutes
        
    }

}

