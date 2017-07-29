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

# Participants

## The Customer
The customer is the driving force behind all work. Without him, there is neither need nor pressure
to work. Indirectly, the customer influences how the team is assembled and organized.

## Project leader
Every team needs someone that holds power. Even though it is possible to share power across
many people, usually one person interacts with the customer and "owns" the project.

# Cooperation
Even though the project leader can usually enforce a specific behaviour in his team 
(after all, he/she hired it in the first place), in reality a developer often has a lot
of influence on their coworkers and their own work, and it is really hard to push him into cooperative behaviour.
There has to be some intrinsic value in working together. On the other hand, differing goals
may negate the positive effects of cooperation, and it may be more useful (even for the majority)
not to forfeit control over your own work.
So, how to simulate this in a game?
In this game, the leader is voted into control. The more team members vote for him, the bigger
the working bonus (due to higher effectivity), 
but of course the leader's decision may not be in your own interest.

# Conflict of interest
As long as anyone agree on the same goal (e.g. return of invest), it is easy to cooperate. 
If anyone has completely different goals
(e.g. one wants to gain as much as possible, the other one wants to ruin the project),
conflicts will end up as two opposing forces that are unable to cooperate.
As soon as you have similar goals, you have a shifting equilibrium - which is probably the
most interesting state.
Therefore, even though it is possible to create opposing goals, in reality you would rarely
encounter them in the same team, and for the sake of the game we should only create goals
that have at least something in common.
However, if everyone has just one goal, there is natural optimum where the system will settle on.
If everyone has at least two goals, there are multiple optimums, which you may switch, depending on the
current situation.


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

## Reject request
Sometimes you accept bad requests, either because you were unaware about the consequences, or because of
strategic thoughts.
Declining a request may cost you, because your customer will always be dissatisfied. 
But it may cost you less than dragging on a dead horse. On the other hand, there might be rare cases
where declining a bad request may be cheaper than keeping it and doing nothing on it.

## Assign work
On the one hand, a team member without a task is a wasted team member. 
A task without assignment will lose its value. However, letting your team jump between multiple tasks will
lower efficiency due to context switches.

# Goal types
What are typical goals a worker might have? 
* more money
* improve social safety
* improve your career
* satisfy curiosity
* have fun

He might have these goals for himself, but also for others. 
For example, due to ethical reasons, someone might be interested in reducing unemployment,
and in increasing salary for everyone. To meet these goals, you could follow multiple strategies, for example:
1. project should have a big project time pot (money if you are shareholder)
1. project should have a lot of accepted requests (career if you can count the experience from all requests towards your resumée)
1. project should have many team members (social safety because small projects are more likely to get cancelled)
1. project should have few rejected requests (career, if rejecting requests may hurt your customer or big boss reputation)
1. project should have a lot of finished requests (curiosity/career, if you are able to learn more from each new task than from one big one)
1. control should be handed to as many team members as possible (career/social safety. You believe that work becomes more efficient that way)

This means we have 5+4+3+2+1=15 possible goal pairs, 
i.e. each team member is likely to have a unique goal combo.
At first it doesn't look like these goals are in conflict, but let's make a few examples:
* Many team members may work less efficient due to increasing communication cost and low workload
* Accepting many requests may hurt the time pot due to aging costs
* Rejecting few requests will hurt your time pot, but may keep many team members busy
* many finished requests may avoid big, worthy tasks that bind a lot of workforce for a long time
* Struggling for control may favor popular choices over efficient ones

How will dual goals affect your behaviour?
Let's start with one member, and see how behaviour adopts with a growing group

__Player A 1/4__  
few rejected requests will hurt your project pot in the long run, therefore he can not follow both goals.
He dedices to go for efficiency, because it promises a lower risk of becoming broke. He concentrates on
finishing one job after another, and hires a new team member  
__Player B 2/5__  
Accepting a lot of requests and finishing a lot of requests play well together, but both require small jobs.
He may veto accepting big jobs. He is not able to gain control (yet), 
but will definitely be in favor of expanding the team.  
__Player C 2/3__  
Accepting a lot of requests with a lot of team members works well together, but may either spread work thin,
or rise communication cost. This way or another, efficiency is declining. Player B and C may overrule A in order
to accept more small requests, even those that are not efficient.
Player A sees how the project pot is shrinking. He suggests to B that accepting jobs is okay, 
as long as they are getting finished, so A can score points with fewer rejects.


