//
//  LottieHandler.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/13/23.
//

import UIKit
import Lottie
import Foundation

class LottieHandler {
    
    static let shared = LottieHandler()
    var loattieAnimation: AnimationView?
    
    private init() { }
    
    func initializeLottie(bounds: CGRect, fileName: String) ->  AnimationView {
        self.loattieAnimation = AnimationView(name: fileName)
        self.loattieAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.loattieAnimation!.frame = bounds
        self.loattieAnimation!.contentMode = .scaleAspectFill
        self.loattieAnimation!.loopMode = .playOnce
        return loattieAnimation!
    }
    
    func playLoattieAnimation() {
        self.loattieAnimation?.play(completion: { (_) in
            self.loattieAnimation!.loopMode = .playOnce
        })
    }
    
    func playLoopLoattieAnimation() {
        self.loattieAnimation?.play(completion: { _ in
            self.loattieAnimation?.loopMode = .loop
        })
    }
}
