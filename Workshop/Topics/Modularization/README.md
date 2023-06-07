# Modularization

## Module

- Today, I want to talk about a topic related to modularisation in OneApp. This presentation is just a personal experience when I develop the enrolment and itsme feature. It’s not about the common rules, or the best practice to be applied in all modules. It’s just a personal experience I gained during the development.

- As we know, modularisation is the process of splitting a big codebase into separate modules. The purpose is to reuse the code, or separate work across different teams, the build time will be faster,  maintainable, testable, the code is more organisable, and etc. The drawback might be, having too many dynamic frameworks or dynamic modules can slow down the launch time of our app.

- Coming back to our app. At the beginning, we developed the BEEnrollment feature inside BEOneApp, then another application also needs the enrolment feature. So, BEEnrollment is extracted out of BEOneApp.
Itsme was originally developed to do the authentication and signing in the enrolment. But later, itsme was used to do the step-up for the transaction in OneApp. Once again, Itsme is extracted out of BEEnrollment.

## API

- Let see all components of a module. First of all, a module should provide an api that helps to interact with other clients. When I design an api, I try to make it short, concise, and do not expose the unnecessary things outside that make the client confused. The api should contains the documentations that describes clearly the functions we provides.
- This interface also allows to construct the module object by injecting dependencies. However, if we have many dependencies to inject, this will make the interface of our api (or the signature of the function) become bulky and ugly. It’s better to put all dependencies in a container, and then inject into our api. That makes our code easy to understand.

- For example, to create Itsme coordinator, I need to inject many dependencies like:
  - navigationController to navigate among screen in the flow
  - apiRequestManager to handle API requests
  - securitySDK: to update user profile info
  - Tracker for analytics,
  - And so on
  - Finally the completion to return the final result

- We can group all dependencies into a container, then the signature will look better, and easy to understand. It sounds like the Itsme coordinator just needs 2 parts: dependencies container and the completion.

- We use delegate or closure to send data back to our clients. Delegates are used to send different types of data, or based on different events that needs to be handled. However, if the data to return is just simple data like Result type success with data or error, using completion closure would be a light way.

## Unit Tests

- When writing unit tests, for me one unit test is to test one thing. 
- The name of the function should reflex clearly what I want to test. The formula I use is: starting the function with `test`, then `functionName`, `givenInput`, and expect to receive `output`.
- For example: 
`func test_authenticate_givenExpiredLoginStatus_shouldReturnTimedoutError()` the reader can understand like: ok, we test authentication function, if we give this function an expired login status, then we will receive a timeout error. This way, we don’t have to read the implementation of the unit test to understand what we are trying to test here. 

## Mock Framework

- Our module will be used by clients or integrated into another module. The client communicates via the APIs to interact with our module. Remember that the client might also contain his sub-components like Unit Tests, Showcase App and UI Tests.
- Therefore we have to write our module such that it’s easy to use and easy to mock in unit-tests, ui-tests, or showcase app of the client.
- So another component appears here. Mock framework is responsible to make our module easy to mock

- For example: if we use INGCommunicationMock, we can mock ApiRequestManager easily. Given an ApiRequest, we can mock the result via this interface.

- Now, let see how we can write a mock framework. To mock an Itsme coordinator, we have to mock all dependencies. It’s quite difficult and takes time to setup mock objects. Another thing is the client should understand the context of Itsme, and set up all mock objects to receive the expected result.

- Normally Itsme start with the main flow, and exit. Now, we introduce a new mock flow that can return the mock result immediately.
- We inject the mock result into the mock flow, and show a dummy ViewController.

## ShowCase App

- The showcase app is very useful to validate our code. We don’t have to publish our module, integrate into the main app. We can test directly in showcase app with our mock data.
- The BEEnrollment contains many screens, and the navigation logic mostly relies on the result of the network api.
- If all the network apis succeed, we will have happy flow
- If some network apis fail, we will have unhappy flows with different error screens.
- Therefore, I design the showcase app such that the user can easily set up the result of all network apis, and our showcase app can cover all cases.
- Demo

## UI Tests

- The UI Tests are developed based on our Showcase App. That’s the only way to do the integration test in our app.
- Here we apply the same principle: single responsibility for each function
- The name of the function should reflex what we want to test
- For example: in happy flow, given all successful services, the authentication should succeed
- In unhappy flow, given a specific failed service, we should show a generic error.

## Code Quality Check

- We use SwiftLint to check the style and coding convention
- I use a separate target for SwiftLint. The reason is I don’t want to run swiftLint every time I build other targets. I only need to run it at some point, as a check, but not every time, especially on the CI, that’s too expensive

- SonarQube is very useful to discover the quality of our code. We can check the quality before asking our colleague to review a PR. SonarQube can discover the code smell, duplication, code coverage percentage, and so on)
- Checkmarx is used to discover the issue regarding the security of a new code

## Script to create a ready built module

- Let’s take a look on a common structure of the sample project. We have meta data folder that contains and then in the main code, we have readme, changelog, and different targets (unit tests, ui tests, showcase app, and so on)
- Imagine, tomorrow we want to create a new module, we wish we have a script to generate for us exactly this structure, and import the common framework like INGCommunication, INGFoundation, and INGStyleKit.
- Steps to build a script like this will be: clone the sample module from repo, rename to the new module, build the module, fetch & resolve the dependencies, and finally we push back to the repo.
- Here is the demo.
