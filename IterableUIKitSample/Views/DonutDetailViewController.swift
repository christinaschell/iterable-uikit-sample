//
//  DonutDetailViewController.swift
//  IterableUIKitSample
//
//  Created by Christina Schell on 7/7/21.
//

import UIKit

class DonutDetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var donutTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    var donut: Donut!
    
    override func viewDidLoad() {
        image.image = UIImage(named: donut.image)
        donutTitle.text = donut.name
        price.text = "$\(String(format: "%.2f", donut.price))"
        super.viewDidLoad()
    }
    
    @IBAction func orderNow(_ sender: Any) {
        print("order now")
    }
    
}
