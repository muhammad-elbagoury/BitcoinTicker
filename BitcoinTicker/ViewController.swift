//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Muhammad Elbagoury on 01/06/2019.
//  Copyright © 2019 Muhammad Elbagoury. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbols = ["$", "R$", "$", "Â¥", "â‚¬", "Â£", "$", "Rp", "â‚ª", "â‚¹", "Â¥", "$", "kr", "$", "zÅ‚", "lei", "â‚½", "kr", "$", "$", "R"]
    var finalURL = ""

    //IBOutlets
    
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    
    //UIPickerView delegate methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        getPriceData(url: finalURL, symbol: currencySymbols[row])
    }

    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getPriceData(url: String, symbol: String) {
        
        Alamofire.request(url, method: .get).responseJSON { response in
            
            if response.result.isSuccess {

                //print("Sucess! Got the price data")
                let priceJSON: JSON = JSON(response.result.value!)

                self.managePriceData(json: priceJSON, symbol: symbol)

            } else {
                //print("Error: \(String(describing: response.result.error))")
                self.bitcoinPriceLabel.text = "Connection Issues"
            }
        }

    }
//
//    
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func managePriceData(json: JSON, symbol: String) {
        
        if let priceResult = json["last"].double {
        
            bitcoinPriceLabel.text = symbol + " " + String(priceResult)
        }
        
    }
    

}

