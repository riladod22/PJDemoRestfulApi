//
//  BaseViewMethod.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/10/1.
//

import Foundation

//檢查輸入用的
enum EventResult<T> {
    case success
    case failure(T?)
}
