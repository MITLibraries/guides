# Pair programming

One of the ways that we collaborate is by - when appropriate - pairing together
on a problem.

## When to pair (and when not to)

Pair programming can achieve a variety of goals successfully, but it is not a
universal solution to every communication need.

Our teams have had success with pairing in a variety of contexts:

* Asking a colleague for help with a coding problem
* Brainstorming on possible ways to implement a feature

Some tasks for which pairing seems ill-suited are:

* Getting approval for a proposed change (changes to code should be managed the
code review process, and while pairing to discuss the proposed changes may be
useful, it is not a required component).
* Sharing an overview of recent work (this sort of "talking at people"
communication may be better suited for a presentation, rather than the "talking
with people" that is a primary feature of pair programming).

## Goals

At the beginning of a pairing session, it is helpful for both participants to
clarify the goals of the session. These can be established during scheduling,
but should be at least reviewed when the session starts, before any code is
changed.

## Mechanics

### Preparation

The initiator of the pairing session should prepare appropriately beforehand.
Over-preparation (which then can delay the session being scheduled, and the
result being achieved) is as much to be avoided as under-preparation (which can
then waste time as the pair struggle to achieve focus on the needed work).

If asking for help debugging, it is helpful to collect the same type of
information that would be included in a bug report (what is the expected
behavior, what is the actual behavior, and what have you already tried
changing).

The need for preparation does _not_ mean that pairing must be scheduled in
advance. Clear communication during a project between team members can, and has,
resulted in effective ad hoc pairing sessions.

### Roles during the session

There are typically two different roles in a pairing session, sometimes referred
to as a "driver" and "navigator". Only one person typically makes changes (the
"driver"). The other participant does so via speaking with the driver.

This separation of roles can have several benefits. The driver is free to focus
on concerns like code syntax and other formal issues. The navigator is free to
consider larger architectural concerns, as well as any subsequent steps needed
to achieve the session's goals.

Participants are free to change roles as often as desired. Some short debugging
sessions may not need a change of role, but for brainstorming sessions where
multiple options are being explored this can give both people a chance to do
each job.

Regardless of role, the participants in a pairing session should be speaking
together, rather than working in isolation. The biggest benefit of pair
programming is the discussion between the pair; it would be a mistake for both
parties to work independently, sacrificing discussion in the name of two people
typing next to each other.

### Duration

Pairing sessions typically last no more than an hour, and at times are even
shorter depending on their goals.

### Remote or in-person

When we pair with a remote partner, the easiest process is for the driving
partner to share their screen, while the navigating partner watches. On some
occasions, it can be helpful to have a shared writing session via an IDE like VS
Code - but this is not required.

For pairing in person, meeting in a conference room may work better than sitting
at a desk together. Conference rooms give freedom to talk without disturbing
others, and also feature large monitors which both participants can see easily.

### Be mindful of power differences

While pairing, people with higher levels of power (via factors such as position,
seniority, the codebase being examined, race, gender, or other dimension of
privilege) should be mindful of levelling this inequality.

Pair programming should not be used to provide anyone a typing assistant; while
at any moment either partner may provide assistance to the other, the overall
result of the session should involve valuable contributions from each person.

## Readings

- ["Pairing: when, why, how" presentation by Anna Headley](https://docs.google.com/presentation/d/1-PhkB_uSPHrz4-eWI6R9AzLo1fGVWqcxMMdUlAWOvng/edit#slide=id.p)
- ["You must try, and then you must ask" article by Matt Ringel](https://blogs.akamai.com/2013/10/you-must-try-and-then-you-must-ask.html)
- [A twitter thread on power differentials in pair programming by Sarah Mei](https://twitter.com/sarahmei/status/991001357455835136)
