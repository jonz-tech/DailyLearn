import UIKit
/* https://swift.bootcss.com/02_language_guide/28_Concurrency
 *  在结构体内，swift是支持异步和同步的代码块的。
 * 即使在同一个时间段只有一段代码在执行，异步代码也可以在后续被暂停或恢复。
 * 例如请求数据后，更新UI操作，这个时候你可以先暂停代码，等数据请求回来后恢复更新UI操作。
 * 同步代码段表示多个代码段在同个时间内串行执行。比如4核处理器，可以同时处理4个任务，每个核心都可单独处理一个同步代码。
 * 同步任务和异步任务代码，在多核处理器中能够有效的同时处理多任务情况。
 *    并发会增加系统的复杂性，swift可以通过增加编译检测，来搞明白你的意图。有bug或效率不高的并发，不能保证你的代码会更快和正确。
 * 相反可能令你的代码难以调试。然而swift可以在编译时捕获这类问题。
 *    如果你要写并发代码，意味着你要用到多线程。swift的并发模块是基于多线程模块设计的，但你又不必直接合线程打交道。
 * 当其他异步代码方法暂停或终止后，你的异步方法获取这个线程的使用权，并被安排到线程里执行。但当你的异步方法恢复执行时，swift并不保证你的代码会运行在哪个线程上。
 */

/*
 *
 listPhotos(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    downloadPhoto(named: name) { photo in
        show(photo)
    }
 }
 不通过swift的语法特性，也可以通过block来写异步方法，但它相对来说比较难以读懂。
 */


// #定义和调用异步方法
// # 定义异步方法: 和抛出函数一样，在方法和函数定义完参数后，追加async 表面这是一个异步方法。
func asyncMethodVoidReturn(a : Int) async {
    
}

//如果有返回值，则将async写在 ->之前
func asyncMethod(a : Int) async -> Int {
    return 10
}

// 如果是异步方法，同时也是抛出函数。则把async写在throws前面。
func throwsAsyncMethod() async throws -> Int {
    return 0
}

//当需要再拿到返回值之前，先终止异步方法。你可以用await来暂停代码执行

func callAsyncMethod() async -> Int{
    let leftValue  = 10;
    var asyncValue = await asyncMethod(a:leftValue)
    return leftValue + asyncValue
}


/*
 //异步访问相片集合
 let photoNames = await listPhotos(inGallery: "Summer Vacation")
 //同步排序相册名
 let sortedNames = photoNames.sorted()
 let name = sortedNames[0]
 //异步下载相片
 let photo = await downloadPhoto(named: name)
 //同步刷新UI
 show(photo)
 
 */

// await 暂停点调用，也可以被称为让出线程(yielding the thread)
// 可以调用异步函数或者异步方法的地方：
// 1. 异步函数、方法、属性内的代码，可以调用异步方法。
// 2. 在结构、类或则枚举内有声明 @main 的静态main方法。
// 3. 非结构化的子任务中调用。

// 对于异步函数中的调用，如果嵌套了await和同步代码，可以将同步代码部分的进行封装成一个方法。
// 这样如果在后续的改进中，变成了异步方法,你就会得到编译的报错。

// 模拟异步等待时间：
// 学习并行的过程中，Task.sleep(_:) 方法非常有用。这个方法什么都没有做，只是等待不少于指定的时间（单位纳秒）后返回。下面是使用 sleep() 方法模拟网络请求实现 listPhotos(inGallery:) 的一个版本：


// #异步队列(Asynchronous Sequences): for-await-in
// 上一节中的 listPhotos(inGallery:) 方法会在拿到数组中的所有元素后，以异步的方式一次性返回整个数组。另一种方式是使用异步序列（asynchronous sequence），每次收到一个元素后对其进行处理。下面这段代码展示了如何遍历一个异步序列：
/*
 import Foundation

 let handle = FileHandle.standardInput
 for try await line in handle.bytes.lines {
     print(line)
 }
 
 与普通的 for-in 循环相比，上面的列子在 for 之后添加了 await 关键字。就像在调用异步函数或方法时一样，await 表明代码中有一个可能的悬点。for-await-in 循环会在每次循环开始的时候因为有可能需要等待下一个元素而挂起当前代码的执行。
 
 */

// 同步队列协议（Sequence protocol）和异步队列协议 （ASyncSequence protocol）
// 和同步队列一样，你通过遵循异步队列协议，来定义自己的队列类型。


// #同步代码中调用异步方法（Calling Asynchronous Functions in Parallel）
// 统一个代码块中，多个异步方法的调用也是同步进行的。
/*
# 方式一：
# 比如下载三个图片，都会按顺序进行，先执行第一个，挂起，下载完再执行下一个异步代码。
     let firstPhoto = await downloadPhoto(named: photoNames[0])
     let secondPhoto = await downloadPhoto(named: photoNames[1])
     let thirdPhoto = await downloadPhoto(named: photoNames[2])

     let photos = [firstPhoto, secondPhoto, thirdPhoto]
     show(photos)
 
 
 ===================================
 # 方式二
 # 由于下载图片没必要串行执行，可以同个时间下载三个图。 等都下载完，再执行show，所以可以改成以下：
 # 在异步函数调用时，为了让部分代码可以并发执行，可以定义一个常量时，在 let 前添加 async 关键字，然后在每次使用这个常量时添加 await 标记。
 
     async let firstPhoto = downloadPhoto(named: photoNames[0])
     async let secondPhoto = downloadPhoto(named: photoNames[1])
     async let thirdPhoto = downloadPhoto(named: photoNames[2])

# 在这个时间点由于程序需要上面几次异步调用的结果，所以你需要添加 await 关键字来挂起当前代码的执行直到所有图片下载完成。
     let photos = await [firstPhoto, secondPhoto, thirdPhoto]
     show(photos)
 
 
 ==============================================
 下面是关于两种不同方法的一些说法：
 1. 代码中接下来的几行需要依赖异步函数的结果时，需要使用 await 来调用异步函数。这样产生的结果是有序的。
 2. 短时间内并不需要异步函数的结果时，需要使用 async-let 来调用异步函数。这样产生的任务是并发的。
 3. await 和 async-let 都允许其他任务在他们被挂起的时候执行。
 4. 在两种情况下，都需要用 await 标记可能的暂停点，以表明代码这些点，在需要的情况下会被挂起，直到异步函数执行结束。
 */


// #任务(Tasks) 和 任务组(Task Groups)
/**
    任务是程序并发执行的最小单元，所有的异步代码都是某个任务的一部分。async-let 定义的异步代码都会为你创建一个子任务。
 你也可以创建一个任务组，然后把任务添加到这个组中。任务组可以协助你管理任务优先级以及取消任务，也可以让你动态的创建任务。
    任务有层级的概念。每个任务组中的任务，都有相同的父任务，每个任务都可以有自己的子任务。任务与任务组这层直接显示关系，被称为结构化并发(structured concurrency.)。
 你对任务的准确性有一定的责任，但这种显示的父子关系机制，能够让swift协助你处理取消任务，还有在编译时检测到错误。
 
 // 代码例子：可以把单个下载图片的逻辑，做到任务组当中。
 
 await withTaskGroup(of: Data.self) { taskGroup in
     let photoNames = await listPhotos(inGallery: "Summer Vacation")
     for name in photoNames {
         taskGroup.addTask { await downloadPhoto(named: name) }
     }
 }
 */

// #非结构化并发(Unstructured Concurrency)
/*
    与上面的结构化并发不同，swift也支持非结构化并发。与任务组不同，非结构化并发不需要父任务。
 你可以根据你的需要，灵活的管理非结构化任务，但你也需要对它的正确性负责。
    1. 应用于actor类型中的非结构化任务：通过Task.init(priority:operation:)创建一个非结构化的任务，并且让它运行在当前actor上。
    2. 不应用于actor类型的非结构化游离任务(detached task)：如果你的任务运行不需要actor，则可以调用Task.detached(priority:operation:) 。
 
 //非结构化的游离任务例子：
 
 let newPhoto = // ... some photo data ...
 let handle = Task {
     return await add(newPhoto, toGalleryNamed: "Spring Adventures")
 }
 let result = await handle.value
 
 */


// # 取消任务
/*
取消任务用了合作取消模型来设计。根据运行过程中的任务状态，系统都会在某个恰当的时间点，调用取消检测机制，并且返回取消状态。通常有以下几个：
    1. 抛出错误：例如 CancellationError
    2. 返回nil或者一个空集合类型
    3. 返回完成一半的工作
 
 检测任务是否取消的操作：
    1. 通过调用Task.checkCancellation()来检测任务是否取消。如果任务已取消，会返回CancellationError ;
    2. 通过调用Task.isCancelled，并根据它的返回值进行相关处理，进而确认取消状态。
 例如下载网络图片过程中，如果需要取消下载一半的任务并且关闭网络连接状态，则可以用上述方法设计。
 
 取消任务操作：
    调用Task.cancel()
 */

// actors引用类型:
// 使用关键字actor声明类型,定义: actor ActorClassName { }
/*
    对于不需要共享资源的异步操作，为了让它们高效安全的并发执行，你可以使用任务来分割成多个独立并发单元。
 但对于需要共享资源的任务，你需要用到actor类型来保证它的并发安全性。
    与类一样，actor也是引用类型。所以要和类一样，将它和值类型区分开来。与类不一样，actor对象在同一时间，只允许一个任务来访问它的可变状态(成员属性)。
 
 */

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
// 由于max可以被多个任务读写，并且进入暂停态，且actor类型同一时间只能有一个任务能访问到这个可变属性。
// 所以在读max属性时，需要用await声明。
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)

// actor类型内部的属性读写，无需使用await。例如添加更新属性
extension TemperatureLogger {
    func update(with measurement: Int){
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}

//阻止不同的任务同时和同一个 actor 实例交互可以防止以下事件序列的发生（读到错误值）：
/*
 1. 你的代码调用 update(with:) 方法，并且先更新了 measurements 数组。
 2. 在你的代码更新 max 前，其他地方的代码读取了最大值和温度列表的值。
 3. 你的代码更新了 max 完成调用。
 
 你可以用 Swift 中的 actor 以防止这种问题的发生，因为 actor 在同一时刻只允许有一个任务能访问它的状态，而且只有在被 await 标记为悬点的地方代码才会被打断。因为 update(with:) 方法没有任何悬点，没有其他任何代码可以在更新的过程中访问到数据
 */

// 如果不使用await访问actor属性，则会编译报错。
// print(logger.max)  // 报错

/*
    不添加 await 关键字的情况下访问 logger.max 会失败，因为 actor 的属性是它隔离的本地状态的一部分。Swift 可以保证只有 actor 内部的代码可以访问 actor 的内部状态。这个保证也被称为 actor isolation。
 */


/*
    任务和actor类型让你安全的将程序分成若干块并发进行。在任务内部或者actor实例中，如果包含了可变状态，例如变量或者属性。
 这被称为并发域(a concurrency domain)。由于并发数据是可变类型，所以对于并发中的数据，它应当是不能被共享并发访问的。
    但有部分可变域中的数据，其实是可以共享的。这部分数据被称为发送类型(Sendable types)。例如它可以在调用actor类型方法时，作为参数传入。也可以作为任务的返回值。对于简单值类型来说，在共享域中共享数据都是安全的。对于并发域中的其他类型数据，如果共享的数据含有可变类型。则有可能会在不同任务调用过程中，有不可预知的错误结果。
 
 */

// #Sendable 类型
/// The Sendable protocol indicates that value of the given type can
/// be safely used in concurrent code.
public protocol Sendable {}

/*
    1. 对于值类型数据来说，可变属性都是由Sendable数据Sendable data)组成的。例如结构中的存储属性，都是sendable或者由sendable值组成的枚举类型。
    2. 类型不包含可变属性，但它的不可变属性时由sendable组成的。例如只有只读属性的结构或者类。
    3. 部分类型对于可变属性，已经做了安全保证。例如类标记了 @MainActor 或者类在被访问时，现在特殊线程提供了序列化操作，然后提供访问值。
 */

//以下类型都是sendable类型：

// 1. 只有sendable属性
// 2. 结构没有被标记为public或者 @usableFromInline。
struct TemperatureReading: Sendable {
    var measurement: Int
}

// 隐式的遵循sendable类型
struct TemperatureReading2 {
    var measurement: Int
}


// 只有sendable属性
extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}

let alogger = TemperatureLogger(label: "Tea kettle", measurement: 85)
let reading = TemperatureReading(measurement: 45)
await alogger.addReading(from: reading)

// 事实上是所有 actor 都遵守了 Actor协议，而该协议继承自 Sendable
