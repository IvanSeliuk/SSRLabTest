//
//  LoadingViewController.swift
//  SSRLabTest
//
//  Created by Иван Селюк on 14.07.22.
//

import UIKit
enum segment {
    case x, y, h
}

class LoadingViewController: UIViewController {
    let textLabel = UILabel()
    lazy var shadowView: UIView = {
        let viewLabel = UIView()
        viewLabel.frame = view.bounds
        viewLabel.alpha = 0.90
        viewLabel.backgroundColor = UIColor(named: "ColorDark")
        return viewLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        rightShadow()
        setupTextLabelLayout()
    }
    
    func setupUI() {
        view.addSubview(shadowView)
        view.bringSubviewToFront(shadowView)
        view.backgroundColor = UIColor(named: "ColorLight")
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "SSRLab"
        textLabel.textColor = UIColor(named: "ColorText")
        textLabel.font = UIFont(name: "MarkerFelt-Wide", size: 60)
        textLabel.alpha = 0
        textLabel.layer.shadowColor = UIColor.black.cgColor
        textLabel.layer.shadowRadius = 5
        textLabel.layer.shadowOpacity = 1
        textLabel.layer.shadowOffset = CGSize(width: 10, height: 0)
    }
    
    private func setupTextLabelLayout() {
        view.addConstraints([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
    
    func calcTrig(segment: segment, size: CGFloat, angle: CGFloat) -> [segment: CGFloat] {
        switch segment {
        case .x:
            let x = size
            let y = tan(angle * .pi/180) * x
            let h = x / cos(angle * .pi/180)
            return [ .x : x, .y : y, .h : h]
        case .y:
            let y = size
            let x = y / tan(angle * .pi/180)
            let h = y / sin(angle * .pi/180)
            return [ .x : x, .y : y, .h : h]
        case .h:
            let h = size
            let x = cos(angle * .pi/180) * h
            let y = sin(angle * .pi/180) * h
            return [ .x : x, .y : y, .h : h]
        }
    }
    
    func rightShadow() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
            self.textLabel.alpha = 0.75
            self.shadowView.alpha = 0.6
        } completion: { success in
            self.rightHalfBottomShadow()
        }
    }
    
    func rightHalfBottomShadow() {
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear) {
            self.textLabel.alpha = 1
            let trig = self.calcTrig(segment: .h, size: 10, angle: 22.5)
            let x = trig[.x]
            let y = trig[.y]
            guard let x = x, let y = y else { return }
            self.textLabel.layer.shadowOffset = CGSize(width: x, height: y)
            self.shadowView.alpha = 0.5
        } completion: { success in
            self.rightBottomShadow()
        }
    }
    
    func rightBottomShadow() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
            let trig = self.calcTrig(segment: .h, size: 10, angle: 45)
            let x = trig[.x]
            let y = trig[.y]
            guard let x = x, let y = y else { return }
            self.textLabel.layer.shadowOffset = CGSize(width: x, height: y)
            self.shadowView.alpha = 0.4
        } completion: { success in
            self.halfRightBottomShadow()
        }
    }
    
    func halfRightBottomShadow() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
            let trig = self.calcTrig(segment: .h, size: 10, angle: 67.5)
            let x = trig[.x]
            let y = trig[.y]
            self.textLabel.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.2
        } completion: { success in
            self.bottomShadow()
        }
    }
    
    func bottomShadow() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
            let trig = self.calcTrig(segment: .h, size: 10, angle: 90)
            let x = trig[.x]
            let y = trig[.y]
            guard let x = x, let y = y else { return }
            self.textLabel.layer.shadowOffset = CGSize(width: x, height: y)
            self.shadowView.alpha = 0.3
        } completion: { success in
            self.halfLeftBottomShadow()
        }
    }
    
    func halfLeftBottomShadow() {
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear) {
            let trig = self.calcTrig(segment: .h, size: 10, angle: 112.5)
            let x = trig[.x]
            let y = trig[.y]
            guard let x = x, let y = y else { return }
            self.textLabel.layer.shadowOffset = CGSize(width: x, height: y)
            self.shadowView.alpha = 0.5
        } completion: { success in
            self.leftBottomShadow()
        }
    }
    
    func leftBottomShadow() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
            let trig = self.calcTrig(segment: .h, size: 10, angle: 135)
            let x = trig[.x]
            let y = trig[.y]
            guard let x = x, let y = y else { return }
            self.textLabel.layer.shadowOffset = CGSize(width: x, height: y)
            self.textLabel.alpha = 0.75
            self.shadowView.alpha = 0.7
        } completion: { success in
            self.lastShadow()
        }
    }
    
    func lastShadow() {
        UIView.animate(withDuration: 1.8, delay: 0, options: .curveEaseOut) {
            let trig = self.calcTrig(segment: .h, size: 10, angle: 157.5)
            let x = trig[.x]
            let y = trig[.y]
            guard let x = x, let y = y else { return }
            self.textLabel.layer.shadowOffset = CGSize(width: x, height: y)
            self.textLabel.alpha = 0
            self.shadowView.alpha = 1.0
        } completion: { success in
            guard let vc = GoogleMapViewController.getInstanceController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
}

