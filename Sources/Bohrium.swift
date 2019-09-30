//
//  Bohrium.swift
//  Budget
//
//  Created by Bas van Kuijck on 26-11-15.
//  Copyright © 2015 basvk.nl. All rights reserved.
//

import Foundation
import CoreFoundation

/// The Benchmark module provides methods to measure and report the time used to execute Swift code.

public class Timer {
    
    /**
     Creates a new Bohrium instance with an optional name
     
     - author: Bas van Kuijck <bas@e-sites.nl>
     - date: 18-08-2016
     
     - parameter name: `String`. The name of the timer, will be printed in every `tick` and `stop`
     - parameter autoStart: `Bool`. (Default = `true`). Should the benchmark timer automatically be started?
     
     - returns: `Bohrium`
     */
    
    public init(name: String = "Timer", autoStart: Bool = true) {
        self.name = name
        if autoStart {
            start()
        }
    }
    
    /**
     Starts measurement
     
     - warning: This method can only be called once
     
     - author: Bas van Kuijck <bas@e-sites.nl>
     - date: 18-08-2016
     */
    public func start() {
        if _start != nil {
            fatalError("start() already called")
        }
        _start = CFAbsoluteTimeGetCurrent()
        _last = CFAbsoluteTimeGetCurrent()
        print("[Bohrium] 🔫 Start %@", _prefixName)
    }
    
    public var name: String = ""
    
    private var _prefixName: String {
        return "'\(name)' "
    }
    
    private var _start: CFAbsoluteTime?
    private var _last: CFAbsoluteTime?
    private var _onTick: ((String?) -> Void)?
    private var _onStop: ((String?) -> Void)?

    public func onTick(_ closure: @escaping ((String?) -> Void)) {
        _onTick = closure
    }

    public func onStop(_ closure: @escaping ((String?) -> Void)) {
        _onStop = closure
    }
    
    public var totalTime: CFTimeInterval {
        guard let start = _start else {
            return 0
        }
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    public var lapTime: CFTimeInterval {
        guard let last = _last else {
            return 0
        }
        return CFAbsoluteTimeGetCurrent() - last
    }
    
    private func _wrap(description: String?) -> String {
        guard let description = description else {
            return ""
        }
        return "\"\(description)\" "
    }
    
    /**
     Measures the time interval between the `start()` and this current tick.
     
     - warning: `start()` should have been called
     
     **Example:**
     
     ```
     2016-08-18 08:42:35.270 Project [t:m] [ TIM ] ⏲ 'AVPlayer' at 0.237: "loaded AVURLAsset"
     
     ```
     
     - author: Bas van Kuijck <bas@e-sites.nl>
     - date: 18-08-2016
     
     - parameter description: `String?`
     */
    public func tick(_ description:String? = nil) {
        if _start == nil || _last == nil {
            fatalError("start() not called")
        }
        
        print("[Bohrium] ⏱ %@at %.3f: %@(+ %.3f)", _prefixName, totalTime, _wrap(description: description), lapTime)
        _onTick?(description)
        _last = CFAbsoluteTimeGetCurrent()
    }
    
    /**
     Stops the benchmark timer and prints the time interval
     
     - warning: `start()` should have been called
     
     **Example:**
     
     ```
     2016-08-18 08:42:35.270 Project [t:m] [ TIM ] 🏁 'AVPlayer' at 0.237
     
     ```
     
     - author: Bas van Kuijck <bas@e-sites.nl>
     - date: 18-08-2016
     
     - parameter description: `String?`
     */
    public func stop(_ description: String? = nil) {
        if _start == nil || _last == nil {
            fatalError("start() not called")
        }
        
        print("[Bohrium] 🏁 %@at %.3f: %@(+ %.3f)", _prefixName, totalTime, _wrap(description: description), lapTime)
        _onStop?(description)
        _start = nil
        _last = nil
    }
}
