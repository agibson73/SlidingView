//
//  ViewController.swift
//  SlidingView
//
//  Created by Alex Gibson on 7/19/17.
//  Copyright © 2017 AG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func showSliderDidPress(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showSlidingMenu", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //handle and set delegate
        if segue.identifier == "showSlidingMenu" {
            if let dvc = segue.destination as? SlidingViewController {
                //dvc defines context must be checked in storyboard maybe > iOS 9 but cannot remember
                dvc.delegate = self
            }
        }
    }

}

extension ViewController : SlidingViewControllerDelegate{
    func button1DidPress(button: UIButton) {
        //let's prove it has fired and I prefer to use self.
        print("Fired")
        if self.view.backgroundColor == .white {
            self.view.backgroundColor = .green
        }else {
            self.view.backgroundColor = .white
        }
    }
}

