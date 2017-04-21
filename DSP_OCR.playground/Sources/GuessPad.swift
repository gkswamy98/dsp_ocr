//
//  GuessPad.swift
//  
//
//  Created by Gokul Swamy on 3/27/17.
//
//
import UIKit
import SceneKit
import SpriteKit

public class GuessPad{
    public static func makeGuessPad() -> UIView {
        let subview = SKView(frame: CGRect(x: 0, y: 0, width: 300.0, height: 300.0))
        let drawPad = DrawPad(size: subview.bounds.size)
        subview.presentScene(drawPad)
        let view = SKView(frame: CGRect(x: 0, y: 0, width: 300.0, height: 400.0))
        view.addSubview(subview)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.center = CGPoint(x: 150, y: 350)
        label.textAlignment = .center
        label.text = "?"
        label.font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightMedium)
        label.textColor = UIColor.white
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(label)
        drawPad.label = label
        return view
    }
}
