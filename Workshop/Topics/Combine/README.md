Combine


This presentation is the request from Alejandro. The purpose is to make the Chapter Time more interactive. And this is also one of my subjectives to do at the end of this year.
The topic today is about Combine framework. Maybe you have studied the Combine native framework for a while, and have memorized a lot lists of publishers, subjects, subscribers, operators, properties wrappers, ObservableObject, and so on. There are tons of things that if we don’t use it in daily life, we will forget them quickly. The learning curve is really steep

However, from my experience, the combine framework is built based on only 3 fundamental components: publisher, subscriber, and subscription. Once we understand these concepts and how they work together, we can go further much easier. The overall picture will be clearer. These components are just protocols, and I will dig into how these protocols communicate between them, and how Apple engineer implements a basic publisher like `Sequence`, `CurrentValueSubject` publisher.

Basically, the publisher sends data, and the subscriber receives, handles data or as we say the subscriber will react accordingly to the data sent from the publisher.
One publisher can send data to many subscribers. And in opposite, 1 subscriber can receive from many publishers.

If we take a look into their protocols, we will see very clearly the relationship.
A subscriber can subscribe to the changes of the publisher via this method.
The subscriber can receive data and react accordingly. The publisher can send a signal to terminate either with success or failure.
Apple provides another protocol named Subject which inherit the Publisher protocol, that allows to actively send data to the subscribers.

Here, we also see the presence of Subscription, and Demand. So what is the subscription. Why does we need them?
The relationship between publisher and subscriber, I can imagine as the seller and the buyer. The seller wants to sell a product, and the buyer wants to buy it.
The subscriber sends a request to subscribe, the publisher agrees, and send back the subscription. The subscription here is like a business contract in which it contains all the rules, both sides have to follow when delivering and receiving a product. For example, in the subscription, we have an item named `Demand`, meaning maximum times the subscriber can receive data. In the life cycle, the publisher & the subscriber can modify this value. It’s like if the product is good, the buyer can continue to buy, but if the product is bad, the buyer can stop the contract and buy products from other sellers. 

And from now on, the Publisher will no longer work directly with the Subscriber, but via Subscription.
The publisher sends values to Subscription, and the Subscription will check the rules and check if he needs to forward this data to the subscriber or not.
When the publisher returns Finish or Failure completion, the Subscription forwards it to the Subscriber, and release all the resources (including the links between Publisher and Subscriber). This is the end of the business. Everything is clean.

In order to understand how this powerful framework works under the hood, we are going to implement a publisher for a class that just holds an integer value, and when it’s changed, we tell its subscribers to react accordingly.
Let’s say we have a sequence running from 0 to 6. We subscribe to this sequence and print it out on the console. The sink function hides all the complex, and make us not really understand what’s going on behind the scene. This publisher doesn’t allow us to specify the demand Value either.
Now, I will implement a similar publisher that does the same. And this implementation is exactly what Apple Engineer implements in the Combine framework.

What's going more from this topic?
We can see the publishers, subscribers, subscriptions everywhere.
Anything can become a publisher
Anything can become a subscriber
Data can be anything
Let's take a look on the example below:

- We can make an UIView in UIKit to become a publisher, and a subscriber at the same time.
- For example: UIView A can publish its background color, and UIView B is a subscriber who receive the background color from UIView A. UIView B update its background color, and send back to UIView A.
- We can make the situation more complex: UIView 1 sends its background color to UIView 2. Next UIView 2 sends the color to UIView 3, etc. UIView N sends back to UIView 1 to make an infinitive circle loop.


