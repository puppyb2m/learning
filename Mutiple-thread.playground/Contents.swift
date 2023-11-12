import UIKit


// case 1: run block concurrent but syncronize in main thread
// queue finished, then next line

// case 2 run concurrent and async in mainthread
// run the nex line first then all the task in queue

// case 3: when queue is finished, will run completion block
let barrierQueue = OperationQueue()
barrierQueue.maxConcurrentOperationCount = 3

let op11 = BlockOperation(block: {
  for i in 0..<5{
    print("✅ task \(i)")
  }
})

let op12 = BlockOperation(block: {
  for i in 0..<5{
    print("😼 task \(i)")
  }
})

let op13 = BlockOperation(block: {
  for i in 0..<5{
    print("🙅‍♂️ task \(i)")
  }
})

barrierQueue.addOperation(op11)
barrierQueue.addOperation(op12)
barrierQueue.addBarrierBlock {
  for i in 0..<5{
    print("🈲️ task \(i)")
  }
}
//op11.add
barrierQueue.addOperation(op13)


// Sync & Async & Serial & Concurrent
// Case 1: Serial+Sync
func SerialSyncTask(){
  let queue = DispatchQueue.init(label: "case1")

  queue.sync {
    print("Taks 1 start ")

    for i in 0..<5{
      print("Task 1 working on : \(i)")
    }

    print("Taks 1 end ")
  }

  queue.sync {
    print("Taks 2 start ")
    print("Taks 2 end ")
  }
}

// Case 2: Serial+Sync
func SerialAsyncTask(){
  let queue = DispatchQueue.init(label: "case1")

  queue.async {
    print("Taks 1 start ")

    for i in 0..<5{
      print("Task 1 working on : \(i)")
    }

    print("Taks 1 end ")
  }

  queue.async {
    print("Taks 2 start ")
    print("Taks 2 end ")
  }
}

// Case 3: Serial+Sync
func ConcurrentSyncTask(){
  let queue = DispatchQueue.init(label: "case1", attributes: .concurrent)

  queue.sync {
    print("Taks 1 start ")

    for i in 0..<5{
      print("Task 1 working on : \(i)")
    }

    print("Taks 1 end ")
  }

  queue.sync {
    print("Taks 2 start ")
    print("Taks 2 end ")
  }
}

// Case 4: Serial+Sync
func ConcurrentAsyncTask(){
  let queue = DispatchQueue.init(label: "case1", attributes: .concurrent)

  queue.async {
    print("Taks 1 start ")

    for i in 0..<5{
      print("Task 1 working on : \(i)")
    }

    print("Taks 1 end ")
  }

  queue.async {
    print("Taks 2 start ")
    print("Taks 2 end ")
  }
}

// case 1: 1 0~5 1 finish  2 2 finish
//SerialSyncTask()

// case 2: 1 0~5 1 finish  2 2 finish
// Only one thread, only task one is finished, task two will be in this thread.
// Only one task will be on thread at one time. Even it's Async but no taks for it to do
//SerialAsyncTask()

// case 3: 1 0~5 1 finish  2 2 finish
//If you are submitting some synchronous tasks to a concurrent queue, means the queue can execute tasks simultaneously but tasks are synchronous(it will wait for other tasks to finish), that’s why the operation will be performed in an orderly manner.
//ConcurrentSyncTask()

// case 4: 1 2 2 finish 0~5 1 finish
//ConcurrentAsyncTask()

// GCD
DispatchQueue.global(qos: .default).async {
  print("abc")
}

// Operation
let queue = OperationQueue()
queue.maxConcurrentOperationCount = 2

let op1 = BlockOperation(block: {
  print(" this is op 1")
})

let op2 = BlockOperation(block: {
  print(" this is op 2")
})

let op3 = BlockOperation(block: {
  print(" this is op 3")
})

let op4 = BlockOperation(block: {
  print(" this is op 4")
})

let op5 = BlockOperation(block: {
  print(" this is op 5")
})


op4.queuePriority = .veryHigh
//op2.queuePriority = .veryLow
//op1.addDependency(op2)

queue.addOperation(op1)
queue.addOperation(op2)
queue.addOperation(op3)
queue.addOperation(op4)
queue.waitUntilAllOperationsAreFinished()

