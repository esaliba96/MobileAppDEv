//
//  WeatherDetail.swift
//  lab6
//
//  Created by Local Account 436-02 on 4/30/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import UIKit

class WeatherDetail: UIViewController {
    var forecastDay : TextForecast.ForecastDay!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var conditionsText: UILabel!
    @IBOutlet weak var highText: UILabel!
    @IBOutlet weak var lowText: UILabel!
    @IBOutlet weak var maxText: UILabel!
    @IBOutlet weak var avgText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateText?.text = "\(forecastDay.date.weekday) \(String(describing: forecastDay.date.day))/\(String(describing: forecastDay.date.month))/\(String(describing: forecastDay.date.year))"
        conditionsText?.text = "\(forecastDay.conditions)"
        highText?.text = "\(forecastDay.high.celsius)C \(forecastDay.high.fahrenheit)F"
        lowText?.text = "\(forecastDay.low.celsius)C \(forecastDay.low.fahrenheit)F"
        maxText?.text = "\(forecastDay.maxwind.mph) \(forecastDay.maxwind.dir)"
        avgText?.text = "\(forecastDay.avewind.mph) \(forecastDay.avewind.dir)"
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        print("icon url: " + forecastDay.icon_url)
        let request = URLRequest(url : URL(string: (forecastDay?.icon_url)!)!)
        
        let task : URLSessionDataTask = session.dataTask(with: request) {
            (recievedData, response, error) -> Void in
            if let data = recievedData {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage.init(data: data)
                }
            }
        }
        task.resume()

    }
    
}
