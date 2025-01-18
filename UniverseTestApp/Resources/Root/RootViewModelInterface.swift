//
//  RootViewModelInterface.swift
//  UniverseTestApp
//
//  Created by Yuriy on 15.01.2025.
//

import Foundation
import RxCocoa

protocol ViewModelOutput {
    var loading: Driver<Bool> { get }
    var error: Driver<Error> { get }
}

protocol RootViewModelInterface {
    
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
