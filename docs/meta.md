# Summary

This page is meant as a guidance how to develop the game, and its core principles.
The basic idea behind this game is that software project management often focusses on raw work force,
and assumes that all other effects are neglible.
But what if they are not? For now, this game incorporates two factors (aging and communication cost)
that both may influence project success harder than customer satisfaction in certain scenarios


# Meta thoughts about gameplay

* Do __NOT__ predefine roles. The only fix role is the customer, because we need at least some driving force for the game. All other roles should be created by the players as a result of the system, not vice versa
* __DO__ think in relations and interactions instead of discrete states
* __DO__ use only one resource (Time). 
* __DO__ keep other scenarios in mind, and design for openness. A development team is just one special team. It might be interesting to apply the same ruleset to slightly different working environments
* Do __NOT__ use extensive texts. Not only to reduce translation effort, but to keep the concept as abstract as possible

# Costs (time)
Additional resources like money, action points make the game more complicated, 
probably without adding any value to key game mechanics. 
Also, time is much more intuitive than abstract values.

## Effort / gain
This is the classical approach: gain minus effort equals yield.

## Aging
In reality, you cannot wait forever to fulfill a request. Either your customer gets unsatisfied,
or the request loses significance. Working for a very long time on a single request with little to no effort
will probably not pay off. Finishing fast is a value of its own.
Balancing aging cost vs. effort is the key, not necessarily gain.
Small jobs with little effort and very high aging cost are still simple, because you can rush through them with one single big effort

## Communication cost
Big teams seem to struggle more than small teams, but why exactly? Communication channels add up
exponentially, unless teams are able to minimize their interdependencies somehow. 
You can counter communication costs with small teams.

# Request size
If all requests (i.e. tasks) were always the same size, extrapolating progress would be very simple.
However, in reality it takes some experience to cut tasks in similar size. Also, long running tasks
have their very own risk involved, because their gain is so far in the future.
For the sake of gameplay, I recommend small, medium and large task clusters, so the players are able to understand
that different sizes may require different actions.

# Request types
There are different request types, which require different strategies to approach. 
This is important, because this means there will be no single best strategy for all requests available.
The system is only metastable.

## Stallmate / Cash Cow
These requests are easy to do, but will gain you next to nothing.
In a benign scenario, these make up most of the requests.
Profitable for small teams.
-> low effort, low gain, low aging

## Emergency
These requests will be barely profitable in the short run, and highly unprofitable in the long run.
Favorable for small to medium teams.
-> low effort, low gain, high aging.

## Joker
A joker scenario that basically gifts you resources.
Especially profitable for small to medium teams.
 -> low effort, high gain, low aging

## Opportunity
These scenarios are very profitable, but only for a limited time
Profitable for large teams
-> low effort, high gain, high aging

## Bad bank
This scenario is expensive to kill, but will take little invest to maintain.
Low loss with medium to large teams.
-> high effort, low gain, low aging

## Hot potato
The worst of all requests: expensive, low gain, and gets even more expensive quick.
Drop it fast.
Medium losses for big teams, high losses for small to medium teams
-> high effort, low gain, high aging

## job creation scheme
Binds a lot of resources for a long time, but is able to pay off if done properly
Profitable for large to medium teams
-> high effort, high gain, low aging

## Money pit
Is impossible to do, even with high work load, due to outrunning aging costs.
Unprofitable for all teams
-> high effort, high gain, high aging


# Player moves
Each action should have immediate or longterm consequences. Balancing those is part of the game.

## Hire
Personal costs are probably the highest cost factor in most modern software projects, therefore
increasing a project size should be hurtful for the player. Also, hiring is a very longterm decision.
To reflect this, firing is not an option, and hiring costs (due to special training or similar) should be expensive.
To balance this, we need a small starting pot, and a high hiring/gain ratio. On the downside, this means
that we require a lot of rounds until hiring strategy may kick in.

## Accept request
Accepting a request is a bet on your future: if you can fulfill it, your customer will be happy and pay you well.
However, if you fail a request, the customer starts to distrust you. Also, taking too long to fulfill
a request will take a toll, too, because the customer's needs will probably change over time.

## Decline request
Sometimes you accept bad requests, either because you were unaware about the consequences, or because of
strategic thoughts.
Declining a request may cost you, because your customer will always be dissatisfied. 
But it may cost you less than dragging on a dead horse. On the other hand, there might be rare cases
where declining a bad request may be cheaper than keeping it and doing nothing on it.

## Assign work
On the one hand, a team member without a task is a wasted team member. 
A task without assignment will lose its value. However, letting your team jump between multiple tasks will
lower efficiency due to context switches.