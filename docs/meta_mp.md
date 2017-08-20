# Summary
These are meta thoughts about multiplayer. 
This means this has to consider everything regarding singleplayer, but adds considerations
about player interactions

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

## Conflict of interest
As long as all agree on the same goal (e.g. return of invest), it is easy to cooperate. 
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
## Keep secret?
Should the players know which goals they get before they are hired? Should goals be made public?
For the game, it probably creates more suspense if it is up to the players to decide what they reveal.
If they don't know before hiring, they can't be forced into telling.
## Responsibility
In reality, decisions may have longterm effects that are only visible after the decision maker
has left the project. But for educational reasons, feedback about your actions should be as imminent
as possible. This also allows other players to react on your behaviour.
## Initiative
Who makes the first step? Moving first requires you to make your plans public, 
and allows anyone else to counter it. On the other hand, moving first also allows to send a message.
Therefore, I recommend that the leader always draws last while voting and while distributing work.
It gives him an advantage in countering badly distributed work, 
but it also makes it more visible what other players would have considered as the right choice.

# Goal types
What are typical goals a worker might have? 
* more money
* improve social safety
* improve your career
* satisfy curiosity
* have fun

He might have these goals for himself, but also for others.
If he knows the goal of someone else, he might decide to counter it.
For example, due to ethical reasons, someone might be interested in reducing unemployment,
and in increasing salary for everyone. To meet these goals, you could follow multiple strategies, for example:
1. __project should have a big project time pot__ (money if you are shareholder)  
1. __project should collect a lot of gain__ (career, if big projects recommend you for other tasks)  
1. __project should have many team members__ (social safety because small projects are more likely to get cancelled)
1. __project should have few rejected requests__ (career, if rejecting requests may hurt your customer or big boss reputation)
1. __project should have a lot of finished requests__ (curiosity/career, if you are able to learn more from each new task than from one big one)
1. __control should be handed to as many team members as possible__ (career/social safety. You believe that work becomes more efficient that way)

All these goals can be countered by work strike, and by accepting bad requests, but since they will hurt all goals,
you will always hurt yourself too. By distributing your work, you can pressure the leader
into following your tasks to finish them.

This means we have 5+4+3+2+1=15 possible goal pairs, 
i.e. each team member is likely to have a unique goal combo.
At first it doesn't look like these goals are in conflict, but let's make a few examples:
* Many team members may work less efficient due to increasing communication cost and low workload
* Accepting many big requests with a lot of gain may hurt efficiency
* Rejecting few requests will hurt your time pot, but may keep many team members busy
* many finished requests may avoid big, worthy tasks that bind a lot of workforce for a long time
* Struggling for control may favor popular choices over efficient ones

## Dual goals
How will dual goals affect your behaviour?
Let's start with one member, and see how behaviour adopts with a growing group

__Player A 1/4__  
few rejected requests will hurt your project pot in the long run, therefore he can not follow both goals.
He dedices to go for efficiency, because it promises a lower risk of becoming broke. He concentrates on
finishing one job after another, and hires a new team member  
__Player B 2/5__  
Accepting big requests and finishing a lot of requests exclude each other.
He will definitely be in favor of expanding the team. He is not interested in efficiency either way,
but in expansion.  
__Player C 2/3__  
Accepting big requests with a lot of team members works well together, but may either spread work thin,
or rise communication cost. This way or another, efficiency is declining. Player B and C may overrule A in order
to accept more requests, even those that are not efficient.
Player A sees how the project pot is shrinking. He suggests to B that accepting jobs is okay, 
as long as they are getting finished, so A can score points with fewer rejects.

This means that most goals actually do NOT favor efficiency, but all of them require a positive project pot,
i.e. that the project keeps running.