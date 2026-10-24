# NTC_PC16 Week 12: Milestone 2 (Midterms) - Dart Logic Practical Exam

**Student Name:** Bongat, Shaun Cedrick M.
**Course & Section:** BSIT 3,1
**Academic Year:** AY 2026–2027  

## Overview
This terminal assessment artifact is a complete, production-ready Dart console application integrating:
- Core Variables, Operators, & Control Structures
- Defensive Programming with `try/catch`
- Encapsulated OOP Hierarchy with Polymorphism
- Abstract Interfaces (`Maintainable`) and Mixins (`GPSLocatable`)
- Asynchronous execution using `Future`, `async`, and `await`

## How to Run
1. Open [DartPad](https://dartpad.dev).
2. Copy and paste `bin/milestone2_practical.dart`.
3. Click **Run**.

## Written Walkthrough & Reflection
Designing this Public Transit Management application allowed me to systematically connect all foundational Dart concepts learned throughout Weeks 7 to 11 into an industry-aligned architecture. I structured `Vehicle` as an abstract base class to enforce code reusability while encapsulating sensitive financial metrics like `_totalCollectedFare` behind getters and controlled update methods. Polymorphism was intentionally applied through the `calculateFare()` method, allowing derived classes like `TraditionalJeepney` and `ModernElectricJeepney` to independently compute rates based on their unique operational costs. To adhere to clean software design, I separated maintenance requirements using the `Maintainable` abstract interface and attached location services via the `GPSLocatable` mixin without cluttering the main inheritance tree. Defensive programming was implemented inside the execution loop using `try/catch` blocks and explicit conditionals to prevent runtime crashes when handling invalid trip inputs. Finally, I incorporated asynchronous programming using `Future`, `async`, and `await` to model non-blocking network requests, mimicking real-world Flutter mobile applications that fetch server responses without freezing the user interface. This structured walkthrough reflects a commitment to writing readable, robust, and scalable code suitable for production environments.
