
- **What is the race condition?**
- Concurrency means running more than one task at the same time. There is always one common challenge when we write concurrency code is how we manage the access to the shared resources. In other words, how we can protect the shared resources when many different threads are trying to alter them.
- For example, we have to implement a BankAccount object, in which we can transfer money from one account to another account. But we are not able to transfer more money than the balance we have. Let say, you have 100 euros in your account, and you have to transfer 50 euros to a friend. No problem, 50euros < 100 euros, the transaction can be executed. There is no problem if only one transaction is executed at a time. Unfortunately, at the same time, your wife also transfers 70 euros to this friend. If our code is not written in a correct way, the result might be, the balance remains -20 euros, and your friend gets 120 euros. It’s not correct because the balance is negative number, the bank is losing 20 euros.

- **So, how does it happen in code?** 
    - Imagine we have a struct `BankAccount`, and we write a method to transfer money like this. First of all, we should guarantee that we never transfer the amount of money that exceeds the current balance. Then we need some time to process like preparing data, fetching data from database, and need to check some conditions before performing actual transaction. Depending on the real time condition, this process might take maximum 2 seconds. Finally we will update the balance. There is nothing wrong with this code. But let look at the situation when 2 threads access this code at the same time.
    - When the husband thread is still busy in step2 to prepare data, the wife thread has overcome the checking condition, and catch up with the husband thread. Finally, husband and wife threads are altering the value of the balance at the same time.

- **Why do we need to avoid race condition?**
    - The race condition issue might be hard to detect, it might lead to unpredictable result or the app crashed. Once we know the issue, it might be difficult to fix.

- **How to avoid race condition in Swift?**
    - First of all, we can write unit tests to detect race condition. More situations we imagine before writing the concurrency code, more stable your code will be.
    - Second, I will show you some techniques we can avoid race condition.

- **Example**: Implement a bank account like mentioned above.
- **Unit Test**:
    - we can write a unit test for the scenario of husband & wife in the previous example. In this case, we expect that only one transaction is successful.
- **Lock**
	- NSLock: is the traditional way to prevent race conditions in Objective-C. We use `NSLock` to lock the critical section in our code.
    - Once a thread accessed this critical section, it will block other threads. Other threads must wait until the lock is released.
- **Semaphore**
    - Semaphore’s value represents the number of concurrent threads can have access to particular section of code
    - In this case, we just need to assign the value of semaphore to 1, it will solve our problem.
- **Serial Queue**:
    - put the code execution in a serial queue, it guarantees only one thread can access the resource at a time. it means the code is executed sequentially.
- **Concurrent Queue**:
    - it guarantees when it's time to execute the task, there is only one task in the concurrent queue
- **Actor**
    - Swift Actors are new in Swift 5.5, and are part of the big concurrency changes now.
    - Swift Actors can limit the access to its properties, thus it will help to avoid the race condition.
    - How it works? it will be a small exercise for you to investigate.
