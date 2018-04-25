//
//  Thread.swift
//  Cinema4D
//
//  Created by Nomad on 4/24/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import Foundation

func main(_ dispatch: @escaping (() -> ())) {
    DispatchQueue.main.async {
        dispatch()
    }
}

func background(_ dispatch: @escaping (() -> ())) {
    DispatchQueue.global(qos: .background).async {
        dispatch()
    }
}
