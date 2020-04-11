//
//  GradientNode.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 13/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SpriteKit

class GradientNode: SKShapeNode {
    init(colors: [UIColor], size: CGSize) {
        assert(!colors.isEmpty)
        super.init()

        let shape = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: -size.height / 2), size: size), cornerRadius: 10)
        shape.position = .zero
        shape.fillColor = .black

        let node = SKNode()
        let colorWidth = size.width / CGFloat(colors.count)
        for i in 0..<colors.count {
            let colorNode = SKSpriteNode(color: colors[i], size: CGSize(width: colorWidth, height: size.height))
            colorNode.position = CGPoint(x: CGFloat(i) * colorWidth + (colorWidth / 2), y: 0)
            node.addChild(colorNode)
        }
        
        let cropNode = SKCropNode()
        cropNode.maskNode = shape
        cropNode.addChild(node)
        addChild(cropNode)
//        parent!
//        addChild(shape)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
