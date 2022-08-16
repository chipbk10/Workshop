
## How to test untestable code?

-First, let ask ourself, what makes code easy to test?
-**There are 3 characteristics**:

- The code has unified input and output. It means, if it’s given a specific input, the output must be as we expected.
- Next, let’s try to keep our state local. In the Apple community, there’s been a really big use of the singleton pattern, mostly Apple is using the singleton pattern a lot in their api’s. Singleton can be convenient to use, but it can lead you down a dangerous path of sharing global state. A very common source of bugs that I see in the apps that I work on is related to sharing the global state, and is used in many places in app.
- Finally, the last characteristic is dependencies injection. It would be difficult to do unit-test without mentioning dependency injection. We gonna talk about it later in the example.

- **How to write test code that contains singleton class?**
- It’s very difficult to write unit-tests for code that uses singletons because it’s generally tightly coupled with the singleton instance, which makes it hard to control the creation of singleton or mock it. To write testable code, we must separate object creation from the business logic. Dependency Injection comes to rescue

- **How to write test to detect memory leak?**
- Managing memory and avoiding leaks is a crucial part of building any kind of program. It’s easy to make a mistake that causes memory to be leaked (like create a retained cycle in code)
- For example, you are familiar with the delegate pattern. When the delegate is not written with weak, it might create a relationship strong-strong with the host class, and might be never released.

  - create a strong reference to delegate object, then assign it as the delegate
  - re-assign the strong reference to a new object, which should cause the original object to be released.
