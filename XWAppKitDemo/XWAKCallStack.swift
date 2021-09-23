//
//  XWAKCallStack.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2021/5/7.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import MachO
import Darwin

enum XWAKCallStackType {
    case all
    case main
    case current
}

struct ThreadInfo {
    var cpuUsage: Double
    var userTime: integer_t
}

func StackOfThread(_ thread: thread_t) -> String {
    var threadInfoSt = ThreadInfo(cpuUsage: 0, userTime: 0)
    var threadInfo = thread_basic_info()
    var threadInfoCount: mach_msg_type_number_t = UInt32.max
    let kerr = withUnsafeMutablePointer(to: &threadInfo) {
        $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
            thread_info(thread, thread_flavor_t(THREAD_BASIC_INFO), $0, &threadInfoCount)
        }
    }
    if kerr == KERN_SUCCESS {
        threadInfoSt.cpuUsage = Double(threadInfo.cpu_usage / 10)
        threadInfoSt.userTime = threadInfo.system_time.microseconds
    }
//    __darwin_mcontext64
    var machineContext: mcontext_t
    var state_count: mach_msg_type_number_t = 0
    
    var reStr = "Stack of thread: \(thread):\n CPU used: \(threadInfoSt.cpuUsage) percent\n user time: \(threadInfoSt.userTime) second\n"
//    thread_get_state(thread, 0, &machineContext.pointee.__ss, &state_count)
    return reStr
    
    
}

class XWAKCallStack: NSObject {
    class func callStack(with type: XWAKCallStackType) {
        _ = loadAll()
    }
    
    private class func loadAll() -> String {
        var threads: thread_act_array_t?
        var thread_count: mach_msg_type_number_t = 0
        if task_threads(mach_task_self_, &threads, &thread_count) != KERN_SUCCESS {
            return "faile get all threads"
        }
        var reStr = "Call \(thread_count) threads:\n"
        for i in 0..<thread_count {
            reStr += StackOfThread(threads![Int(i)])
        }
        var memStr = ""
        var taskBasicInfo = mach_task_basic_info()
        let MACH_TASK_BASIC_INFO_COUNT = MemoryLayout<mach_task_basic_info>.stride / MemoryLayout<integer_t>.stride
        var count = mach_msg_type_number_t(MACH_TASK_BASIC_INFO_COUNT)
        
        let tt = withUnsafeMutablePointer(to: &taskBasicInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: MACH_TASK_BASIC_INFO_COUNT) {
                task_info(mach_task_self_,
                          task_flavor_t(MACH_TASK_BASIC_INFO),
                          $0,
                          &count)
            }
        }
        if tt == KERN_SUCCESS {
            memStr = "used \(taskBasicInfo.resident_size / (1024 * 1024)) MB \n"
            print(memStr)
        }
        defer {
            let size = MemoryLayout<thread_t>.size * Int(thread_count)
            vm_deallocate(mach_task_self_, vm_address_t(bitPattern: threads), vm_size_t(size))
        }
        return reStr
    }
}
