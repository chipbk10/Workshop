
## TDD
- What is TDD?
- Why do we want to use TDD?
- How can we use TDD at work?
- At the end, I’m going to show you an example explaining how we can use TDD for a specific problem

- What is TDD? TDD is a development life cycle in which you write your tests before you actually write your implementation. For people who are not familiar with TDD, they might have a difficult time to adopt this practice. People have to change their habit of writing code. Instead of jumping directly into the implementation, we have to think about the use cases and the test cases first, and then the code will be evolved later.

    - First, we have the red mode, and this red mode says we have to write a failing test. This test will indicate what your code will be doing.
    - Next, you make this test passed by writing the minimum amount of code. Remember, we just write the minimum amount of code, just to make the test passed. Don’t think more than that. We run all the unit tests we wrote before to see if we break anything
    - The final step we have to do is the refactor state, in which we would modify the code to make the code nicer. This is of course when applicable.
    - Then we repeat the whole process over and over again until our software is complete.


- So, now we should ask ourselves what is the benefit of TDD? Is it worth to give it a try?
	- TDD focuses mostly on tests. This idea allows developers to take time to analyse the design or the main requirements of the final products before writing the main code. So TDD increases the quality of code, and mitigate the risk of failure. Once the developer finishes his implementation, all unit-tests are also done, and passed.
	- Developers have less debugging to do. The code is written to pass the failing test, so the developer knows why and where to fix the bug if the test is not passed. That means, developers are notified sooner when something breaks.
	- The code is easier to maintain. In TDD life cycle, we often refactor the code, so naturally we are more likely to produce a cleaner, more readable and manageable code.

- How can we use TDD at work? I will show you an example to solve a specific problem by using TDD.
    - The task is we have to convert a string to an integer. Of course, please don’t use the built-in Swift function to solve this problem.
    - I have prepared an empty project where we will create a file to write a function to solve this problem. Let say, we create a file named “TDD_Demo”, and “TDD_Demo_Test”. To avoid the complain from the compiler, I just return 0 for now.
    - To have a better view, from my experience, I put the implementation file and unit-test file side by side
    - With TDD approach, we have to write the failing test first. We can think of a simple case now. If the input is zero string, then we should return number zero. By accident, our code is still correct, so we will move to next failing test. Ah from my experience, we should commit the code, once a unit-test is passed. So that we can see how the code is evolved.
	- @testable import Workshop
	```
	    // write the failing test
    	// s = "0" -> return 0
    	func test_convert_givenZeroString_shouldReturnZero() {
        
        	// assign
        	let s = "0"
        	let demo = TDD_Demo()
        
       		 // act
        	let actualResult = demo.convert(s)
        
        	// assertion
        	XCTAssertEqual(actualResult, 0)
    	}
   ```
	- so far so good, we will move the next failing test. If the input is an empty string, then we should return nil value. We run the test, and it fails. We come back to the implementation to fix it.
```
	    // s = "" -> return nil
    	func test_convert_givenEmptyString_shouldReturnNil() {
        
        	// assign
	        let s = ""
        	let demo = TDD_Demo()
        
	        // act
        	let actualResult = demo.convert(s)
        
	        // assertion
	        XCTAssertNil(actualResult)
    	}
	
    	func convert(_ s: String) -> Int? {        
        	guard !s.isEmpty else { return nil }
        	return 0
    	}
```
	- now if the input is a valid positive number string, then we should return valid positive number accordingly. Let say s = “42” string, we should return 42. We run the test, and it fails. We come back to the implementation to fix it. We recognised that if we iterate over the string from left to right, each time, we just need to multiple the result by 10 and plus the value. At the end, it would be the expected result.
```
	// s = "42" -> return 42
	func test_convert_givenValidPositiveNumberString_shouldReturnValidPositiveNumber() {
        
        	// assign
	        let s = "42"
        	let demo = TDD_Demo()
        
	        // act
        	let actualResult = demo.convert(s)
        
	        // assertion
        	XCTAssertEqual(actualResult, 42)
    	}

	// convert a string to an Int
	func convert(_ s: String) -> Int? {
        
        	guard !s.isEmpty else { return nil }
        
	        // "42"
        	var result = 0
	        for c in s {
            		result *= 10
	                result += c.toNumber()
        	}
        
	        return result
    	}
```
	- now if the input is a valid negative number string, then we should return valid negative number accordingly. Let say, s = “-42” string, we should return -42. We run the test, and it fails. We come back to the implementation to fix it. We recognised that now the first character of the string might represent the sign of the number. 
```
	    // convert a string to an Int
    	func convert(_ s: String) -> Int? {
        
        	guard !s.isEmpty else { return nil }
        
       	 	let cs = Array(s)
        	guard cs[0].isNumber || cs[0] == "-" else {
            		return nil
        	}
        
        	// "42"
        	var result = 0
        	let sign = cs[0] == "-" ? -1 : 1
        
        	var index = cs[0].isNumber ? 0 : 1
        
        	while index < cs.endIndex {
            
            		result *= 10
            		result += cs[index].toNumber()
            
            		index += 1
        	}
        
        	return sign * result
    	}

	// s = "-42" -> return -42
	func test_convert_givenValidNegativeNumberString_shouldReturnValidNegativeNumber() {
        
        	// assign
        	let s = "-42"
        	let demo = TDD_Demo()
        
        	// act
        	let actualResult = demo.convert(s)
        
        	// assertion
        	XCTAssertEqual(actualResult, -42)
    	}
```
- Now if the input is a valid positive number string with sign, then we should return valid positive number accordingly. Let say, s = “+42”, we should return 42. We run the test, and it fails. We come back to the implementation to fix it. We recognised that we are missing to check the sign “plus” for positive number. The remaining is still correct.

- We can keep thinking of other test cases like what if we have letters in the middle of the string.
- What if we have a very long number string, it might lead to the overflow case. With the negative sign, it might lead to underflow case.

- The cons of TDD is 
    - TDD slows down the development process
    - TDD is difficult to learn
    - TDD is challenging to support and maintain
    - So my advice is you can give it a try with TDD to see if it suits your working style or not. Yeah, it’s up to you to decide.
