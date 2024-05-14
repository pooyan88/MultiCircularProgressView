//
//  CircleWithMultiColorBorderView.swift
//  Circle with multi color custom view
//
//  Created by Pooyan J on 2/9/1403 AP.
//

import UIKit

class MultiCircularProgressView: UIView {

    struct Config {

        struct Progress {

            let total: Double
            let remain: Double
            let color: UIColor
        }

        var progresses: [Progress]
        var backgroundColor: UIColor = .lightGray
    }

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    private var config: Config?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
}

// MARK: - Setup Functions
extension MultiCircularProgressView {

    func setup(config: Config) {
        self.config = config
        let total = config.progresses.compactMap({$0.total}).reduce(0, +)
        setupTopLabel(total: config.progresses.compactMap({$0.total}).reduce(0, +))
        setupBottomLabel(remain: config.progresses.compactMap({$0.remain}).reduce(0, +), total: total)
        var summedRemains = 0.0
        for progress in config.progresses {
            setupRemainRingLayer(total: total, remain: summedRemains + progress.remain, strokeColor: progress.color)
            summedRemains += progress.remain
        }
        setupBackgroundRing()
    }

    private func setupBackgroundRing() {
        let backgroundRingLayer = CAShapeLayer()
        layer.addSublayer(backgroundRingLayer)
        let path = UIBezierPath(arcCenter: contentView.center,
                                radius: bounds.width / 2,
                                startAngle: getDegree(input: 0),
                                endAngle: getDegree(input: 360), clockwise: true)
        backgroundRingLayer.path = path.cgPath
        backgroundRingLayer.strokeColor = UIColor.systemGray4.cgColor
        backgroundRingLayer.position = .zero
        backgroundRingLayer.lineWidth = 10
        backgroundRingLayer.fillColor = UIColor.clear.cgColor
        let tempLayer = CALayer()
        tempLayer.addSublayer(backgroundRingLayer)
        layer.insertSublayer(tempLayer, at: 0)
    }

    private func setupRemainRingLayer(total: Double, remain: Double, strokeColor: UIColor) {
        let remainRingLayer = CAShapeLayer()
        let path = UIBezierPath(arcCenter: contentView.center,
                                radius: bounds.width / 2,
                                startAngle: getDegree(input: 0),
                                endAngle: getDegree(input: getRemainPercentageDegree(total: total,
                                                                                     remain: remain)),
                                clockwise: true)
        remainRingLayer.path = path.cgPath
        remainRingLayer.strokeColor = strokeColor.cgColor
        remainRingLayer.lineCap = .round
        remainRingLayer.position = .zero
        remainRingLayer.lineWidth = 10
        remainRingLayer.fillColor = UIColor.clear.cgColor
        let tempLayer = CALayer()
        tempLayer.addSublayer(remainRingLayer)
        tempLayer.frame = bounds
        layer.insertSublayer(tempLayer, at: 0)

        remainRingLayer.strokeEnd = getDegree(input: getRemainPercentageDegree(total: total, remain: remain))
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = getDegree(input: 0)
        animation.toValue = getDegree(input: getRemainPercentageDegree(total: total, remain: remain))
        animation.duration = 2
        remainRingLayer.add(animation, forKey: nil)
    }

    private func setupTopLabel(total: Double) {
        topLabel.text = total.description
    }

    private func setupBottomLabel(remain: Double, total: Double) {
        bottomLabel.text = remain.description
    }

    func loadNib() {
        Bundle.main.loadNibNamed("MultiCircularProgressView", owner: self)
        addSubview(contentView)
        contentView.frame = bounds
    }
}

// MARK: - Logic
extension MultiCircularProgressView {

    private func getDegree(input: Double) -> Double {
        return (input - 90) * .pi / 180.0
    }

    private func getRemainPercentageDegree(total: Double, remain: Double) -> Double {
        let remainPercentage = getRemainPercentage(total: total, remain: remain)
        return (remainPercentage * 360) / 100
    }

    private func getRemainPercentage(total: Double, remain: Double) -> Double {
        return (remain / total) * 100
    }
}
