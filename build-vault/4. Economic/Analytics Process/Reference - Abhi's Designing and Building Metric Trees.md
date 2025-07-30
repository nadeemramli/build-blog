---
draft: true
title: "Reference - Abhi's Designing and Building Metric Trees"
date: "2025-07-30"
tags: 
---
# Designing and Building Metric Trees

## Why Data?

We're going to start with the question of why. For our purposes here, we're actually not going to start with why metric trees directly—we're going to start with a more fundamental, more existential question for this group here, which is: why data? What's the point of this data stuff anyway? Why are we here on adult spring break for the past couple of days?

Look, my background is I run data teams and I run growth teams. I do this—I've done this for the past couple of decades as a leader that actually builds up those functions, advisor, investor, consultant, etc. Through the process, I've intimately seen hundreds of companies, hundreds of data teams. And my answer to this question is that most of the value of data—90% of the value of data for 90% of companies—is really analytics-specific. It's really just answering these four questions:

1. What happened?
2. Why did it happen?
3. What's going to happen next?
4. What should we do about it?

This is it. And I know this is an AI-focused conference, data science-focused conference as well, but them's the breaks. For most companies, this is where the bulk of the value is actually harvested.

To the extent that a data team can look at itself, can introspect on the work that's happening in that team, can look at the tools and the vendors that team uses, and can draw a straight line—a clear line—to being able to answer these questions, that team is probably creating value and it's creating value efficiently.

To the extent that that team looks at its tools, looks at the work it's doing, and can only draw an opaque line or an indirect line to answering these kinds of questions, that team is probably not creating value, and it's certainly not creating value efficiently.

So if you believe that, as I do, then look, the fundamental question for data teams is: how do we ensure that we are always oriented, restructured, repositioned in the company to be answering these questions—these four questions—easily, quickly, and often? So low latency, low friction, and with high frequency.

This is the fundamental ethos question for data teams to grapple with.

## Organizations as Systems

My answer to that starts by thinking about an organization as just a system. All organizations—non-profit, for-profit, whatever industry you're in—all organizations really are just ways of translating inputs (physical capital, human capital, intellectual capital) running it through the meat grinder of a company and popping out the other side some kind of value-denominated assets, predominantly cash. That's really all a company is. That's really all any kind of organization is.

Now, because we are especially here quantitatively-minded folk, we look at a function that translates inputs into outputs, and we see a function. And when we see that function, we see a formula.

Just as businesses are all really just input-output systems, if I didn't know anything about a set of companies other than their fundamental formula that describes how that company translates inputs and outputs, I'd be able to identify that company. This is really the fingerprint of a company. The unique identifier for a company is how that unique company translates inputs into outputs. And that unique fingerprint is basically, for us, we can think about it as a fundamental formula.

If we peer into that formula, what makes these formulas different from company to company? Those formulas have basically three parts:

1. **Metrics** - business facts about how value in that company is created, how it's captured, or how it's transferred or lost
2. **Relationships** - that tie those metrics together, that tie those business facts together
3. **Weights** - that express the significance of different relationships as they relate to the outputs. Here in metric trees, the strength and confidence of the relationships convey weights, hence why the stronger the relationship (the more we know how it become a driver or bring impact) the better of it will be a growth lever. To quantify the strength or influence of a relationship. For example, in a `Causal` relationship, a higher weight could signify a stronger impact. This lays the groundwork for future quantitative modeling and simulation.

That's all this kind of formula notion is.

If we take a step back, if we understand that formula—if we really could in a vacuum draw out this fundamental formula for a company—we would understand everything about that company. And if we understand everything about that company, then we are able to answer those questions. We are able to answer the descriptive analytics, the predictive, the prescriptive, the inferential, and do those with low latency, low friction, and high frequency.

## The Data Team Mandate

That brings me to kind of how I see the mandate of data teams. When I run data teams, this is how I position data teams. The raison d'être for my data teams and my growth teams is: your job is to help the company define, understand, evolve, and operationalize your growth model.

When companies talk about data strategy, well, this is actually the most important data strategy: how is that data team and how is that company using its data to understand its growth model?

Now I'm using "growth model" here for the first time. The only difference between a growth model and a fundamental formula, as I see it, is that the growth model is what takes that formula and reifies it. So it takes that formula and makes it trackable over time, engageable, interactable, etc. It's what makes that fundamental formula real. And the mandate of a growth team, of a data team rather, is to make that growth model real.

## Enter Metric Trees

Okay, enter metric trees. A metric tree is nothing more than just a logical representation of a growth model. We know the distinction between conceptual and logical and physical models. For a growth model, which again we mentioned was physically reified, for our growth model, the logical precursor is this notion of a metric tree.

This both supports the creation of a growth model, but it also is an ergonomic way to present and consume what that growth model is actually telling you. And a metric tree is really just outputs, inputs, and relationships. And we should recognize that these are basically what we called out as the parts of the fundamental formula too: metrics, relationships, and weights.

So that's basically what a tree is.

## How to Build Metric Trees

Now the question is: okay great, how do we go about building this tree? We're not focused so much on actually reifying the growth model in this conversation, but how do we go about actually constructing this tree for our business or for my specific organizational unit?

There's really four steps to making metric trees. We're going to keep this pretty simple:

### Step 1: Define North Stars

North Stars gets a lot of chatter, a lot of MBA speak around this notion of North Stars. I'm just going to cut right to the chase on how I see the notion of a North Star. These are the most top-level, most high-order metrics in the company. What I like to say is they are the metrics from which all other metrics derive their legitimacy. If another metric does not point to the North Star, it's an illegitimate metric.

There are three types of North Stars:
1. **Customer Value** - A North Star that is denominated in terms of customer value, the footprint of value that a product or service is creating for end customers. Most commonly used in truly product-oriented, technology-denominated, product-led companies. The North Star for a BI tool might be number of views on dashboards. The North Star for ChatGPT in terms of customer value might be number of prompts that are successfully returned. It's a measure of the footprint of customer value with the notion, with the belief that if you take care of customer value, the score takes care of itself.
2. **Financial North Star** - That score that takes care of itself. It's how we measure that score, it's how we keep that score. These are P&L realities—these are capital inflows or capital outflows from the P&L that express how we have captured or expended value in the process of generating what we generate as a company.
3. **Strategic North Stars** - Less common because most companies are not strategic—it's as simple as that. Strategic North Stars are representative of not direct value, not direct financial realities, but steps along the way that define the "why we win" for a company. This could look like strategic market expansion, this could look like moats, this could look like network effects—things that are very indirect from the other two types of North Stars but are still essential for long-term value accretion.

==tagging function==

So our first step is to pick a North Star for our organization, our unit. Metric trees in the wild usually start with dollars, so we're going to start with dollars too. For our example here, we're going to start with simple revenue.

### Step 2 & 3: Input Metrics

Steps two and three were both about input metrics. I said step two was you're going to recursively define inputs, step three is you're going to layer on additional inputs. Why am I distinguishing between inputs in two steps? It's because there are two types of inputs. Output metrics all decompose into two types of input metrics. There are what I call **components** and what I call **inputs**.

**Components** (Step 2) - When I say recursively **decompose your metrics**, that's step two. **Components are just mathematical identities**. They are definitionally true. Revenue is customers times ASP—that is the definition of revenue, it's the definition of customer, it's the definition of ASP. These are how fundamentally these metrics relate to one another. Customers is, at least in our reductive example, leads times win rate. These are how they're fundamentally defined, how they're fundamentally oriented. They will always be true because they're true by definition.

Once you recursively go down this chain, so actually we're defining our North Star, we're recursively going down the chain, when we run out of what I call the metric vocabulary—when we run out of the **metric vocabulary** to continue to decompose—those metrics that are left are our leaf metrics, and we do not proceed.

**Influences** (Step 3) - We're going to layer on influences. **Influences are contingent relationships**. These are temporally contingent, they're empirically derived, they're not true by definition—they're true as **empirical realities**. Speed to lead, here for those of you who aren't familiar with the B2B model, B2B sales model has this notion of you have inbound leads that come in. Speed to lead is basically how quickly I get at that lead—how quickly does an SDR show up at your doorstep and ask you to sign on the dotted line or talk to an AE.

Speed to lead is an empirical metric. The relationship between speed to lead and win rate has a certain relationship today—it might have a different relationship tomorrow. It looks different across different companies. It is temporally contingent, it's empirically derived, it is not by definition true. It's mediated by other kinds of amorphous and unstable relationships.

So step three is really: great, we have all of these components, now we're going to go hang these influences. We might know influences to be sure—we might absolutely know that speed to lead is an influence. We might not know influences—these might also just be pure hypotheses. But we're going to layer both of these influences and hang them onto our tree as step three.

==tagging function==
### Step 4: Add Metadata

Step four is we're gonna add metadata. I'm a big graph guy. If you look carefully, this is actually just a graph—it's a graph of nodes and edges. When we talk about metadata, we're going to hang metadata on both nodes and edges.

**On edges**, there are two important types of metadata we want to be adding:

- **Strength** - How strong is the relationship between one metric and another?
- **Confidence** - How certain are we about that relationship?

**For nodes**, we're going to be hanging what we would colloquially call slices. Like if I want to understand win rate, I would look at win rate by X, by Y, by Z. What are those X's, Y's, and Z's? How would I reason about what a metric is and how that metric is performing? Those are dimensional concerns, and that dimensional metadata is what we hang on these nodes.

And that is basically it. Fun and profit in four easy steps: we start with North Star, we decompose into inputs, we layer on additional inputs, and we hang that metadata.

## Applications and Use Cases

### 1. Onboarding

Robert E said a lot of things about how to be a 10x analyst. One of those things is domain context. How do you get domain context? I know of no better way to facilitate the transfer of domain context than to first express that tacit context into a metric tree and share that metric tree with folks you onboard.

At a company called Hustle, we would do this. We did this for every data scientist, every data analyst, every data engineer. We cut onboarding time to an hour, and it was so successful that this is how the entire company started onboarding their functions. The marketers would onboard product marketers by understanding, by sharing with them the metric tree for marketing. Same with sales, same with product, same with all these other functions.

### 2. Gateway to Knowledge Repo

At a company called Keep where I was running growth and data, one of our struggles was a struggle that probably many of you are familiar with, which is: we do all of this analysis, we do all this experimentation, we put it into a notebook, and it never sees the light of day. No one ever talks about it again.

The way we went about solving that problem was to actually put all the analyses, all the experimentation behind a metric tree, and to make the metric tree the primary interface. What we did there was we created this dynamic interface for a metric tree. We would expose it to everyone in the company where the color codes represented strength—was this metric red, yellow, green, strong, weak, or kind of a middling relationship?

The dashed lines, the weight that you see on relationships represents confidence. So how certain are we? In this case, we're not so sure. We're very sure that speed to lead is a medium influence. We're not so sure that AE tenure is a strong influence—we have some kind of weak certainty around it, we have some experimentation around it.

Everything that we did on data and growth, every experiment that was done in the company, was behind one of these lines, in one of these nodes. All the analysis, all the experimentation was behind one of these relationships. And it was very transparent: where do we have confidence? Where do we not? Where do we need to go? Where do we need to experiment? Where did we experiment recently?

This led to like 800% improvement in engagement with the artifacts that data science was producing.

### 3. Mission Statement for Data Teams

That lends naturally into the next utterly transformational use case, which is as a mission statement for data teams. When I run data teams, I have data and growth teams. I have them look at this and tell them that their mandate is oriented purely towards the levers. Their mandate as a data team is to turn those unsolid lines solid—to use experimentation, analysis to turn those low-confidence relationships into high-confidence relationships. And your mandate as a data person is to turn—is to light up the board, to light up the tree with more levers.

Because ultimately, data's responsibility is to identify growth levers, and operators' responsibility is to pull those growth levers. This is a completely transformational, utterly transformational way to position a data team. If you actually position your data team like this, you will never again have conversations about: does my data team create value? How much value does my data team create? How should I measure the value? Because the value is the process, and the process is: identify levers that operators can pull. And if operators are able to pull levers effectively, you've done your job.

To turn metric tree to growth model: A metrics tree can be transformed into a growth model by ==using it to identify key drivers of growth and then formulating hypotheses to improve those drivers==. The tree visually maps out the relationships between different metrics, allowing you to pinpoint which metrics have the biggest impact on your overall business goal (the "North Star"). By analyzing the tree, you can identify areas for improvement and develop targeted strategies to drive growth. By understanding relationships between metrics, and understand it's impact, we can identify our key drivers, which then operators can double down on that. 

----

Compartment function
### 4. Dashboarding

When I joined Flexport, there were 2,700 dashboards, and there were 600 people in the company. So that's several dashboards per person. The way we cut that down to 51 dashboards was by building a metric tree first and by partitioning dashboards based on limbs of the tree. You start by understanding the structure of your business, and you start breaking out the limbs of your tree, and you start partitioning those into dashboards. And those dashboards now have inherent structure.

And they have relative structure. The structure of the dashboard internally makes sense, but they also make sense from one dashboard to another, because these dashboards now have this logical hierarchy to them that's derived from the tree. And we were able to cut from 2,700 to 51 in a matter of a couple months as a result.

### 5. Business Reviews

Katie Bauer was up here earlier today, and she was talking about business reviews. Look, I've run business reviews at dozens of companies. I know of no more effective way to run a business review than off of a metric tree. We anchor on the metric tree, we look at what's red, and we only drill on the reds. And it's very transparent when customers is down, where we need to be focusing our investigation: leads, win rate, in this case speed to lead.

---


### 6. Root Cause Analysis

The natural complement to that is root cause analysis. Katie talked about a lot of the failure points of business reviews, and some of these are that these teams are inundated with questions, they're inundated with these async offline root cause analyses. But look, root cause analysis is trivial. Root cause analysis can actually be automated because any deviation in an output metric is really just a function of either dimensional shift or input shift.

And if we've actually hung the dimensions, we've actually specified the ontology, if we've actually specified the relationships here, if we take that time to do that upfront, root cause analysis is now cakewalk. Root cause analysis is now automated. And that's possible, and that's what we were able to do at Flexport, for instance.

### 7. Forecasting

The flip side of root cause analysis is forecasting. If you can go down the tree to do root cause analysis, you can just go up the tree to do forecasting. And forecasting is now just a matter of taking those inputs, understanding what the drivers are of those inputs, simulating changes in those inputs, and then you end up with forecasting. Utterly transformational.

## The SOMA Standard

I'm very excited about the possibility of what metric trees can do, and so one of the things that I've been really focused on is: how do we make it easy?

For the past six months, I've been working on a variety of ways to try and make this easier, try and lower the activation energy required to be able to actually make this work in companies.

There's a lot to talk about here, again, around how you reify the growth model. We are just going to talk about solving two of the problems that stand in the way of people being able to implement this effectively, and those are both around metrics:

**Problem #1**: What should my metrics be in the first place? Because your stakeholders probably don't know. You may not know. How do you actually go about constructing a tree and what do you hang on the tree?

**Problem #2**: Great, I have metrics, but now how do I actually produce those metrics? Because if I'm going to do all this automated root cause analysis and forecasting, I have to go beyond a logical model and I have to go to something physical that actually persists these metrics.

So how do we solve this metric problem on both sides? How do we understand what metrics to have, and how do we actually produce those metrics?

The way I think about solving that problem and trying to enable more companies right now is by recognizing that **businesses aren't snowflakes**. This is a fundamental thesis of mine that, by and large, everything that we're talking about—about this metric tree—by and large, that metric tree and the variance in the metric tree is explained by business model.

For the purposes of metrics, and this is a broader statement too, for the purposes of analytics, internal-facing data science, all metrics, all dashboards—90% can be standardized based on: are you B2B? Are you B2C? Are you e-commerce? Are you marketplace? Because B2B is B2B, B2B SaaS is B2B SaaS, inherently.

In recognition of this, one of the things that I've been working on is what I call **SOMA**. SOMA is Standard Operating Metrics and Analytics. This is a project I've been working on for a couple of months now where, for each of a set of business models, starting with B2B SaaS, which is what we're looking at here, identifying what are the spanning set of metrics that matter to B2B SaaS.

In the case of B2B SaaS, for this business model, we've identified about 250. And for those metrics, looking across decades of experience, looking across hundreds of other companies that we're talking to, what is the key metadata that is necessary for this metric? How is the metric defined? What are the related metrics? What are the dimensions that we should generally slice by? What are the periods we should look at when we're producing this metric?

So this is step one: can we understand what the metrics are for a given business model, and can we understand what their interrelationships are? Because if we can standardize what the metrics are, I can also tell you what the relationships are, because I've done the trees many, many times. So can we standardize what these metrics are and what the relationships are—what those nodes and edges are?

This is a completely open source project. I have no interest in commercially activating this project. This is something I'm—depending on, I think there's going to be online people that are watching this too—depending on when you watch this, it'll be in some state of development. But right now, currently, it's on somastandard.com, which I think points to a GitHub page right now. I'll point it to this website later this evening.

We are starting by releasing just growth accounting metrics, which is a set of about 20 to 30 metrics, and slowly will expand from there to represent the full corpus of first B2B SaaS metrics, and then other metrics across other business models as well.

Now that solves only one problem—that solves the "how do I build a tree, what metrics do I put on the tree" problem. There is another problem too, which is: how do I actually construct those metrics in a low-friction way?

Part of the SOMA standard project is also to automate the construction of those metrics. We've defined the metrics; we'll also automate the construction of those metrics through DBT scripts, provided that you can map your data.

So what we also have here is this notion of activities. In the SOMA standard, we envision a business as basically just a set of activities. Instead of thinking about a business as a bunch of tables, we should actually envision businesses as basically a ledger of things that happen in the business—things that the company does and things that customers do in the business.

What we are specifying in the standard is: if you raise these events, if you raise this ledger of activities that a business does, we'll take it from there, and we'll automate the generation of these metrics. So this is a work in progress, something I'm very excited about, again completely community-driven, open source, to try and make it easier for more data teams to get at that real mandate of how do we build these growth models.


---
### . Strategic Purpose & Data Team Mission

This entire component is designed to fulfill a strategic mission, as you outlined.

- **Mission Alignment:** The Metrimap becomes the data team's living "mission statement." Their mandate is clear and visible to the entire organization:
    
    1. **Solidify Lines:** Turn dotted/dashed lines (low/medium confidence) into solid lines (high confidence) by conducting experiments and analyses, which are then attached as evidence.
        
    2. **Light Up the Board:** Discover and validate new, high-impact `Causal` relationships ("levers") that operators can then pull to drive growth.
        
- **Value Demonstration:** This system makes the value of the data team tangible. Their output is not a series of disconnected reports that get lost, but the direct improvement and validation of the company's "map of reality." The progress of turning the map from a collection of hypotheses into a validated causal model _is_ the measure of the data team's success.

Relevant for [[5. Idea Vault/Application/Active/Metrimap - Easy Workflow/PRD|PRD]]