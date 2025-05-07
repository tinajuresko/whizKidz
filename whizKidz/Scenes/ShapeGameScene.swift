//
//  ShapeGameScene.swift
//  whizKidz
//
//  Created by Tina Jureško on 24.02.2025..
//

import Foundation
import SpriteKit

class ShapeGameScene: SKScene {
    var targetShape: String = ""
    var instructionLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    var timeElapsed: TimeInterval = 0
    var lastUpdateTime: TimeInterval = 0
    var speedFactor: CGFloat = 1.0
    var spawnDuration: TimeInterval = 1.0
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        targetShape = ["circle", "square", "triangle", "rectangle", "hexagon", "star"].randomElement() ?? "circle"
        instructionLabel.text = "Select: \(targetShape.capitalized)"

        let spawnAction = SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(createShape),
                SKAction.wait(forDuration: spawnDuration)
            ])
        )
        run(spawnAction)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        
        instructionLabel.fontSize = 30
        instructionLabel.fontColor = .white
        instructionLabel.position = CGPoint(x: size.width / 2, y: size.height - 100)

        addChild(instructionLabel)



    }
    
    func createShape() {
        let shapes = ["circle", "square", "triangle", "rectangle", "hexagon", "star"]
        let randomShape = shapes.randomElement()!
        
        let shapeNode: SKShapeNode
        
        switch randomShape {
            case "circle":
                shapeNode = SKShapeNode(circleOfRadius: 40)
            case "square":
                shapeNode = SKShapeNode(rectOf: CGSize(width: 80, height: 80))
            case "triangle":
                let path = UIBezierPath()
                path.move(to: CGPoint(x: -40, y: -40))
                path.addLine(to: CGPoint(x: 40, y: -40))
                path.addLine(to: CGPoint(x: 0, y: 40))
                path.close()
                shapeNode = SKShapeNode(path: path.cgPath)
            case "rectangle":
                shapeNode = SKShapeNode(rectOf: CGSize(width: 100, height: 50))
            case "hexagon":
                let hexagonPath = UIBezierPath()
                let sideLength: CGFloat = 40
                for i in 0..<6 {
                    let angle = CGFloat(i) * (.pi / 3)
                    let point = CGPoint(x: sideLength * cos(angle), y: sideLength * sin(angle))
                    if i == 0 {
                        hexagonPath.move(to: point)
                    } else {
                        hexagonPath.addLine(to: point)
                    }
                }
                hexagonPath.close()
                shapeNode = SKShapeNode(path: hexagonPath.cgPath)
            case "star":
                let starPath = UIBezierPath()
                let starPoints: [CGPoint] = [
                    CGPoint(x: 0, y: 50),
                    CGPoint(x: 14, y: 14),
                    CGPoint(x: 47, y: 15),
                    CGPoint(x: 23, y: -5),
                    CGPoint(x: 29, y: -40),
                    CGPoint(x: 0, y: -20),
                    CGPoint(x: -29, y: -40),
                    CGPoint(x: -23, y: -5),
                    CGPoint(x: -47, y: 15),
                    CGPoint(x: -14, y: 14)
                ]
                starPath.move(to: starPoints[0])
                for point in starPoints.dropFirst() {
                    starPath.addLine(to: point)
                }
                starPath.close()
                shapeNode = SKShapeNode(path: starPath.cgPath)
            default:
                return
        }
        
        shapeNode.fillColor = .random()
        shapeNode.name = randomShape
        shapeNode.position = CGPoint(x: CGFloat.random(in: 50...size.width - 50), y: size.height)
        
        shapeNode.physicsBody = SKPhysicsBody(polygonFrom: shapeNode.path!)
        shapeNode.physicsBody?.affectedByGravity = true
        shapeNode.physicsBody?.categoryBitMask = 1 //for interactions
        
        shapeNode.physicsBody?.linearDamping = 0
        shapeNode.physicsBody?.angularDamping = 0
        shapeNode.physicsBody?.velocity = CGVector(dx: 0, dy: -speedFactor * 20)
            
        
        addChild(shapeNode)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        timeElapsed += deltaTime
        
        if timeElapsed >= 30 {
            timeElapsed = 0
            speedFactor += 0.1
            if spawnDuration > 0.3 {
                spawnDuration -= 0.1
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = nodes(at: location).first
        
        if touchedNode?.name == "playAgainButton" {
            restartGame()
        }else if let shapeNode = touchedNode as? SKShapeNode {
            if let name = shapeNode.name {
                if name == targetShape {
                    let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
                    let scaleDown = SKAction.scale(to: 0, duration: 0.2)
                    let remove = SKAction.removeFromParent()
                    
                    let sequence = SKAction.sequence([scaleUp, scaleDown, remove])
                    shapeNode.run(sequence)
                    
                    targetShape = ["circle", "square", "triangle", "rectangle", "hexagon", "star"].randomElement() ?? "circle"
                    instructionLabel.text = "Select: \(targetShape.capitalized)"
                } else {
                    gameOver()
                }
            }
        }
    }
    
    func gameOver() {
        let gameOverLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        gameOverLabel.text = "Game Over!"
        gameOverLabel.name = "gameOverLabel"
        gameOverLabel.fontSize = 50
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameOverLabel)
        
        showPlayAgainButton()

        //isUserInteractionEnabled = false
    }

    func showPlayAgainButton() {
        let playAgainButton = SKLabelNode(fontNamed: "AvenirNext-Bold")
        playAgainButton.text = "Play Again"
        playAgainButton.fontSize = 40
        playAgainButton.fontColor = .white
        playAgainButton.position = CGPoint(x: size.width / 2, y: size.height / 2 - 100)
        playAgainButton.name = "playAgainButton"
        
        addChild(playAgainButton)
    }
    
    func restartGame() {
        timeElapsed = 0
        lastUpdateTime = 0
        speedFactor = 1.0
        spawnDuration = 1.0
        
        children.forEach { child in
            if child is SKShapeNode || child.name == "gameOverLabel" || child.name == "playAgainButton" {
                child.removeFromParent()
            }
        }
        
        targetShape = ["circle", "square", "triangle", "rectangle", "hexagon", "star"].randomElement() ?? "circle"
        instructionLabel.text = "Select: \(targetShape.capitalized)"
        
        let spawnAction = SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(createShape),
                SKAction.wait(forDuration: spawnDuration)
            ])
        )
        run(spawnAction)
        
        isUserInteractionEnabled = true
    }
}

extension SKColor {
    static func random() -> SKColor {
        return SKColor(
            red: CGFloat.random(in: 0.2...1),
            green: CGFloat.random(in: 0.2...1),
            blue: CGFloat.random(in: 0.2...1),
            alpha: 1.0
        )
    }
}

