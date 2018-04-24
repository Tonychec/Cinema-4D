//
//  UIVIewBtn.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//
import UIKit

class ViewBtn: UIView, UIGestureRecognizerDelegate {
    
    var isNeedTransform = true
    var btnState: BtnState! {
        didSet {
            configForState()
        }
    }
    
    var action: (() -> ())?
    private let tap = UITapGestureRecognizer()
    
    func configureBtn(state: BtnState, action: @escaping (() -> ())) {
        self.btnState = state
        self.action = action
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.crop(radius: self.frame.height / 2)
    }
    
    func configForState() {
        switch btnState {
        case .normal:
            self.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
        case .selected:
            self.backgroundColor = #colorLiteral(red: 1, green: 0.8549019608, blue: 0, alpha: 1)
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
        case .genre:
            self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.layer.borderWidth = 1
            self.layer.borderColor = #colorLiteral(red: 1, green: 0.8549019608, blue: 0, alpha: 1)
        default:
            break
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isNeedTransform {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform.identity
                self.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 1
            })
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isNeedTransform {
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }) { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                }) { _ in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.transform = CGAffineTransform.identity
                    }) { _ in
                        self.alpha = 1
                        self.action?()
                    }
                }
            }
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 1
            }) { _ in
                self.action?()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isNeedTransform {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.alpha = 0.5
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 0.5
            })
        }
    }
    
    enum BtnState {
        case normal
        case selected
        case genre
    }
}
