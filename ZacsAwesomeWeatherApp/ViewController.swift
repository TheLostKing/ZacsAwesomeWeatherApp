//
//  ViewController.swift
//  ZacsAwesomeWeatherApp
//
//  Created by Zachary Calderone on 10/8/18.
//  Copyright © 2018 Black Kobold Games. All rights reserved.
//

import UIKit

struct weatherLocation {
    var key: String
    var latitude: String
    var longitude: String
    var url: String{
        get{
            return "https://api.darksky.net/forecast/\(key)/\(latitude),\(longitude)"
        }
    }
}

class ViewController: UIViewController {
    var key = "2bcdb54a6eaee1e12ebdd6fca30b67ca"
    var latitude = "42.1817"
    var longitude = "88.3304"
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var apparentTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipChanceLabel: UILabel!
    @IBOutlet weak var precipTypeLabel: UILabel!
    @IBOutlet weak var precipIntensityLabel: UILabel!
    @IBOutlet weak var precipIntensityErrorLabel: UILabel!
    var cityList: [String:weatherLocation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cityList = ["Lake in the Hills":weatherLocation(key: key, latitude: latitude, longitude: longitude),
                    "Huntley":weatherLocation(key: key, latitude: "42.1681", longitude: "88.4281"),
                    "Crystal Lake":weatherLocation(key: key, latitude: "42.2411", longitude: "88.3162"),
                    "Chicago":weatherLocation(key: key, latitude: "41.8781", longitude: "87.6298")
        ]
        
        setLabels(city: "Lake in the Hills")
        
    }
    
    @IBAction func changeCity(_ sender: UIButton) {
        let city = sender.titleLabel?.text
        setLabels(city: city!)
    }
    
    func setLabels(city: String){
        if let url = NSURL(string: cityList[city]!.url){
            if let data = NSData(contentsOf: url as URL){
                if let data = NSData(contentsOf: url as URL){
                    do {
                        let parsed = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                        
                        let newDict = parsed
                        print(newDict["currently"]!["apparentTemperature"])
                        print(newDict["currently"]!["temperature"])
                        print(newDict["currently"]!["dewPoint"])
                        print(newDict["currently"]!["precipProbability"])
                        
                        self.tempLabel.text = "\(newDict["currently"]!["temperature"]!!)"
                        self.apparentTempLabel.text = "\(newDict["currently"]!["apparentTemperature"]!!)"
                        self.windSpeedLabel.text = "\(newDict["currently"]!["windSpeed"]!!)"
                        self.humidityLabel.text = "\(newDict["currently"]!["humidity"]!!)"
                        self.precipChanceLabel.text = "\(newDict["currently"]!["precipProbability"]!!)"
                        self.precipIntensityLabel.text = "\(newDict["currently"]!["precipIntensity"]!!)"
                        
                        if (newDict["currently"]!["precipType"]!) != nil{
                            self.precipTypeLabel.text = "\(newDict["currently"]!["precipType"]!!)"
                        } else {
                            self.precipTypeLabel.text = "None"
                        }
                        if (newDict["currently"]!["precipIntensityError"]!) != nil{
                            self.precipIntensityErrorLabel.text = "\(newDict["currently"]!["precipIntensityError"]!!)"
                        } else {
                            self.precipIntensityErrorLabel.text = "None"
                        }
                        
                        
                        
                    }
                    catch let error as NSError {
                        print("A JSON parsithng error occurred, here are the details:\n \(error)")
                    }
                }
            }
        }
    }
    
    
    


}

