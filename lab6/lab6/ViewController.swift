//
//  ViewController.swift
//  lab6
//
//  Created by Local Account 436-02 on 4/30/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let apiString3DayForecast = "https://api.wunderground.com/api/06210f961278c558/forecast10day/q/CA/San_Luis_Obispo.json"
    var txtForecast : TextForecast?
 
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (txtForecast?.forecastDays.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastDayCell", for: indexPath) as! ForecastCell
        
        let forecastDay = txtForecast!.forecastDays[indexPath.row]
        
        cell.dateText?.text = "\(forecastDay.date.weekday) \(String(describing: forecastDay.date.day))/\(String(describing: forecastDay.date.month))/\(String(describing: forecastDay.date.year))"
        cell.conditionsText?.text = "\(forecastDay.conditions)"
        cell.highText?.text = "\(forecastDay.high.celsius)C \(forecastDay.high.fahrenheit)F"
        cell.lowText?.text = "\(forecastDay.low.celsius)C \(forecastDay.low.fahrenheit)F"
        cell.maxWindText?.text = "\(String(describing: forecastDay.maxwind.mph)) \(forecastDay.maxwind.dir)"
        cell.avgWindText?.text = "\(String(describing: forecastDay.avewind.mph)) \(forecastDay.avewind.dir)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }   
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        super.viewDidLoad()
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let request = URLRequest(url: URL(string: apiString3DayForecast)!)
        
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let txtForecastService = try decoder.decode(TextForecastService.self, from: data)
                    
                    self.txtForecast = txtForecastService.forecast.simpleforecast
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = txtForecast!.forecastDays[indexPath.row]
                (segue.destination as! WeatherDetail).forecastDay = object
            }
        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

