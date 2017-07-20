//
//  SlidingViewController.swift
//  SlidingView
//
//  Created by Alex Gibson on 7/19/17.
//  Copyright © 2017 AG. All rights reserved.
//

import UIKit

protocol SlidingViewControllerDelegate : class {
    func button1DidPress(button:UIButton)
}

class SlidingViewController: UIViewController {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    weak var delegate : SlidingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //reset setup
        let _ = self.stackView.arrangedSubviews.map({$0.transform = .identity})
        self.menuView.transform = .identity
        
        //animation setup
        let _ = self.stackView.arrangedSubviews.map({$0.transform = CGAffineTransform(translationX: 0, y: self.stackView.bounds.height) })
        
        self.overlayView.alpha = 0
        
        self.menuView.transform = CGAffineTransform(translationX: 0, y: self.menuView.bounds.height)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presentAnimation()
    }
    
    func presentAnimation() {
        
        UIView.animate(withDuration: 0.25, animations: {
            [weak self] in
            guard let vc = self else{return}
            vc.overlayView.alpha = 1
            
            }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut, animations: { 
            [weak self] in
            guard let vc = self else{return}
            vc.menuView.transform = .identity
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.35, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            [weak self] in
            guard let vc = self else{return}
            let _ = vc.stackView.arrangedSubviews.map({$0.transform = .identity})
            }, completion: nil)
    }

    @IBAction func dismissDidPress(_ sender: Any) {
        UIView.animate(withDuration: 0.25, animations: {
            [weak self] in
            guard let vc = self else{return}
            vc.menuView.transform = CGAffineTransform(translationX: 0, y: vc.menuView.bounds.height)
            }, completion: {
                finished in
                self.dismiss(animated: false, completion: nil)
        })
        
        UIView.animate(withDuration: 0.25, delay: 0.15, options: .curveEaseInOut, animations: {
            [weak self] in
            guard let vc = self else{return}
            vc.overlayView.alpha = 0
            }, completion: nil)
        
    }

    
    @IBAction func button1DidPress(_ sender: UIButton) {
        delegate?.button1DidPress(button: sender)
    }
    
    

}
