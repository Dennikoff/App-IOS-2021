//
//  BalloonEmitterView.swift
//  womanOnly
//
//  Created by Ilya Buldin on 14.12.2021.
//

import SwiftUI
import SpriteKit

struct BalloonEmitterView: View {
    
    let numberPerDay: String
    let packPrice: String
    let numberInPack: String
    let finishSmokingDate: String
    
    func scene(for size: CGSize) -> SKScene {
        let scene = GameScene()
        scene.size = size
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                VStack {
                    Spacer()
                    Image("smoking_man")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 500)
                        .offset(x: -120, y: -30)
                }
            }
            ZStack {
                GeometryReader { gp in
                    SpriteView(scene: scene(for: gp.size), options: .allowsTransparency)
                }
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Сигарет в день: ")
                                .font(.system(size: 27, weight: .medium, design: .default))
                                .foregroundColor(Color(UIColor.secondaryLabel))
                            Text(numberPerDay)
                                .font(.system(size: 27, weight: .bold, design: .default))
                        }
                        HStack {
                            Text("Стоимость пачки: ")
                                .font(.system(size: 27, weight: .medium, design: .default))
                                .foregroundColor(Color(UIColor.secondaryLabel))
                            Text(packPrice)
                                .font(.system(size: 27, weight: .bold, design: .default))
                        }
                        HStack {
                            Text("Количество в пачке: ")
                                .font(.system(size: 27, weight: .medium, design: .default))
                                .foregroundColor(Color(UIColor.secondaryLabel))
                            Text(numberInPack)
                                .font(.system(size: 27, weight: .bold, design: .default))
                        }
                        VStack(alignment: .leading) {
                            Text("Закончил курить: ")
                                .font(.system(size: 27, weight: .medium, design: .default))
                                .foregroundColor(Color(UIColor.secondaryLabel))
                            Text(finishSmokingDate)
                                .font(.system(size: 27, weight: .bold, design: .default))
                        }
                        
                    }
                    
                    .multilineTextAlignment(.leading)
                    .padding(.top, 80)
                    .padding(.trailing, 40)
                    
                    
                    Spacer()
                    
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct BalloonEmitterView_Previews: PreviewProvider {
    static var previews: some View {
        BalloonEmitterView(numberPerDay: "5", packPrice: "250", numberInPack: "20", finishSmokingDate: "01-11-2021")
        
    }
}

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity.dy = 0.25
        backgroundColor = .clear
        
        let wait = SKAction.wait(forDuration: 0.2, withRange: 0.1)
        let spawn = SKAction.run { [weak self] in
            self?.addNode(at: CGPoint(x: 330, y: 150))
        }
        
        let sequence = SKAction.sequence([wait, spawn])
        self.run(SKAction.repeatForever(sequence))
    }
    
    override func update(_ currentTime: TimeInterval) {
        enumerateChildNodes(withName: "1") { (node, _) in
            if !node.frame.intersects(self.frame) {
                node.removeFromParent()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        addNode(at: location)
    }
    
    func addNode(at location: CGPoint) {
        let isRareColor = Int.random(in: 0...5) == 4
        let radius = CGFloat.random(in: 1...7) * 5
        let box = SKShapeNode(circleOfRadius: radius)
        let startPoint = CGPoint(x: 0.5, y: 0.5)
        let endPoint = CGPoint(x: 1, y: 1)
        let color = isRareColor ? .purple : UIColor.black
        let rect = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        let randomMove = CGVector(dx: CGFloat.random(in: -2...2) * radius * 10, dy: 5)
        let image: UIImage = UIImage.gradientImage(withBounds: rect, startPoint: startPoint, endPoint: endPoint, colors: [UIColor.black.cgColor, UIColor.gray.cgColor])
        let gradientTexture = SKTexture(image: image)
        
        box.fillTexture = gradientTexture
        box.isAntialiased = true
        box.fillColor = .white
        box.strokeColor = .clear
        box.position = location
        box.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        box.physicsBody?.restitution = 1
        box.physicsBody?.friction = 0
        box.physicsBody?.mass = 0.2
        box.name = "1"
        addChild(box)
        box.physicsBody?.applyForce(randomMove)
        
    }
}

extension UIImage {
    static func gradientImage(withBounds: CGRect, startPoint: CGPoint, endPoint: CGPoint , colors: [CGColor]) -> UIImage {
        
        // Configure the gradient layer based on input
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        gradientLayer.frame = withBounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        // Render the image using the gradient layer
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
