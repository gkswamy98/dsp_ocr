//
//  DrawPad.swift
//  
//
//  Created by Gokul Swamy on 3/27/17.
//
//

import UIKit
import PlaygroundSupport
import SceneKit
import SpriteKit

public class DrawPad: SKScene {
    var emitter: SKEmitterNode?
    public var xPoints: [Float] = []
    public var yPoints: [Float] = []
    public var label: UILabel?
    
    public override func didMove(to view: SKView) {
        emitter = SKEmitterNode(fileNamed: "MyParticle.sks")
        emitter?.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        emitter?.targetNode = self
        emitter?.particleBirthRate = 0
        self.addChild(emitter!)
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        xPoints = []
        yPoints = []
        emitter?.particleBirthRate = 100
        let touch = touches.first
        let location = touch?.location(in: view)
        emitter?.position = CGPoint(x: (location?.x)!, y: (view?.bounds.height)! - (location?.y)!)
        xPoints.append(Float((location?.x)!))
        yPoints.append(Float((view?.bounds.height)! - (location?.y)!))
        label?.text = "?"
    }
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: view)
        emitter?.position = CGPoint(x: (location?.x)!, y: (view?.bounds.height)! - (location?.y)!)
        xPoints.append(Float((location?.x)!))
        yPoints.append(Float((view?.bounds.height)! - (location?.y)!))
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        emitter?.particleBirthRate = 0
        makeGuess(x: xPoints, y: yPoints)
    }
    public func makeGuess(x: [Float], y: [Float]){
        label?.text = String(kNN.categorizeSignal(x: x, y: y))
        for i in 0..<x.count{
            print(String(x[i]) + " " + String(y[i]))
        }
    }

}
