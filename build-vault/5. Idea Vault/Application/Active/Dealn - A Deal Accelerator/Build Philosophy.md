---
draft: false
title: "Dealn: Product, Design and Technical Philosophy"
date: 2025-07-23
tags:
---
## Introduction
-----
What I want to achieve with this essay is that I want to be able to show how a user should be using Dealn and how each component creates objects, and how these objects fundamentally interact with each other, and why it is important for them to interact with each other. So I call this somehow flow, user flows, or user architecture, or data architecture in this sense. So let's go through the apps flow one by one and we try to understand. But before we go to understanding what's going on with the app, we first have to understand what is the philosophy behind the app.

The philosophy behind the app is simple. **To generate a sale, it requires a contract, it requires a dealing process.** And this dealing process has been scattered everywhere. So the way that Dealn be able to create value for people to deal better in their dealing process is that we include all important data that they need for that dealing process and make document creation for that dealing process much easier based on those data that existed within their workspace and context within their projects. So whenever they create documents, it doesn't have to be from scratch. It's actually coming from a past case study or whatever data that you have from the workspace itself.

**In my opinion, for people to close a deal, they have to do three things.**
1. They need to build trust. When you have trust, you are good for a deal. If you look at this framework, you can have part two and part three, but without part one, which is trust, you will never get to have a deal as well.
2. You need to have agreement.
	1. You need to have momentum.

So those are our policies or basically our principles in closing deals. They need to build trust, they need to have agreements, and lastly, they need to have momentum to carry forward whatever it is in the process of dealing, in the process of negotiating, the process of proposing, document signing, and everything. All of that must be smooth and build this smooth experience and momentum to just move forward and just execute, produce the best job that you can, and then fundamentally achieve the end goal of that deal.

So three principles that are important to be our core philosophy or our core principles in developing this app, and I'm going to go through step by step how this app can help us achieve that core philosophy.

## First Principle: Building Trust
----
Building Trust: The first pillar of the core philosophy is trust. So how do we build trust? We build trust through a model that I developed, I call it KIV.
1. KIV
	1. Know: You need to know the person you want to build trust with.
	2. Inside: You need to be "inside their head." You need to understand their motivations, their desires, their internal drive, what's happening with them, what's the real problem that they actually go through. You want to really understand them.
	3. Vibe: You need to be able to build a good relationship. It's not just "I need to know you, I know your problem, let's do something about it." No, you need to have this ability where they think, "I like hanging out with you because I know you, you know me, you understand me, and I like to be around you."

Fundamentally, it's KIV. And the way that we build that KIV in this app is that first, we have Contacts.

#### Contacts & Companies
---
Contacts is simply a place where the user just inputs everything that they know about that person. What's their name? What's their last name? What's the email, the phone number, position, whatever it is that you know about that person. And you also want to know more about them. So what's their company? You can associate the contact object or data to the company. You can connect these people, the LinkedIn URLs, the notes, whatever it is that you want to provide more context to the contacts. It's all about context within contacts.

Once you review and confirm, now you have a contact. And a contact is great for you to know the person that you're trying to build trust with, but you're not yet building trust. You can also capture information about their company: the company name, industry, company size, website, email, phone number, address, and description. These will help you build trust later, by understanding more context of knowing them.

#### Meetings & Conversations
----
To get inside, you need to engage and understand what exactly is happening with this person. It's all about interactions. You can have meetings or you can just hang out, whatever the medium is that you're trying to engage with that person. Most probably and most preferably it's meetings, but it can also be just hanging out at restaurants or places that you like. Whatever it is, you can capture all of that interaction here.

You can schedule meetings and see all of your meetings with that person. You can have your own custom scheduling pages that you can put on your website or LinkedIn, or just send to them via WhatsApp. Through the settings, you can set up everything regarding your meeting schedule pages, your availability, and your time zone. This is for people who have never interacted with you before.

I'm trying to build this understanding that meetings are not supposedly just online meetings. It can also be in-person meetings, a phone call, a webinar, or communication in Discord or Slack. Whatever the medium you use to interact and engage with the person, you can capture it here. You can capture the conversation that you have with them—whether it's a meeting, phone call, video call, email, or chat—you can capture it at the Conversation page. The conversation page is essentially the context of how you're interacting with that person. Whatever you understand internally about that person you're trying to build trust with, you can put it here.

The first two parts of building a relationship, which is knowing and understanding them, can be done in this app. Context is where you put all of the information about the person. Companies is where you put all of the information about their company. And Meetings and Conversation are the points of interaction.

## Gaining Agreement
---
So what happens then? Let's say one day one of your contacts decide to have a project with you. This is an opportunity that you have to capture really fast. You don't need to go back and search your WhatsApp for what's happening with this person. Instead, you can just create a Project.

Within that project, whenever you create a new one, you can input the deal name, the description, the probability for you to win the deal, the project stages, the start date, the deadline, and deal notes. You can associate all information that is related to this project. Which company are you dealing with? What is the primary contact?

Once you successfully create that project, everything regarding that contact—whether you had a meeting last two months or six months, and all of the conversation that you captured with that person—is now in your system. Whenever you create a project and associate it with the companies and contacts, everything regarding that person is now in your project context.

If you go to your Project Settings, you can see all of the contacts relevant to the project, your timeline (you can see you've actually been engaging with this guy for the last two years), meetings, conversations, and any files or documents.

Fundamentally, in a project, there are three things to get your head around:
1. Overview: 
	1. This shows what's happening with the project. I love the recent activity feature, which tells you what's happening. You can add a simple note, a simple task, or just a checklist. The overview is to ensure the project moves forward or to get a quick summary.
2. Notebook: 
	1. This is where you can see all of your meetings, conversations, notes, and whatever information you need to give context to this project workspace. You can add sources like notes, websites, or PDFs regarding that specific company. You can chat through this workspace to understand more about your project. The sources for this notebook will entirely depend on the association you create. It will have all information regarding the contacts, companies, meetings, and conversations. It becomes your assistant for the project. You can simply just ask, "I want to create a new project proposition for this company. What can I do?" From all the sources and context you provide, it can give you the best starting point to develop your documents, proposals, or invoices.
3. Deal Portals:
	1. This is where you move to build that document you needed to get that agreement.


#### Building Momentum
---
Deal Portals is what I like the most. Inside Deal Portals, you have Portals, where you can see all your portals, and you have Integrations. The idea with Deal Portals is almost like Typeform. It's technically just a multi-page funnel that allows you to fundamentally create this whole experience and workflow for people to close a deal with you.

You can create your own documents from scratch—contracts, headlines, basically your own page in the Deal Portal—and you can send it to them with just one link for them to go through all of the processes to close the deal with you. Sometimes you need integrations for that to get done, so you'll probably connect the Deal Portal to your Google Sheets, your CRM, or whatever tools you use in your marketing tech stack.

Lastly, you have Workflows, which are specific to Deal Portals only. When you create a Deal Portal, you're expecting some behavior. You're sending the portal to your contact, and you're probably expecting a signature or a payment. You can create workflows to remind the client if there's no signature in the next three days after they open it. If the client opens the deal portal, you can have it send you notifications, send them notifications, send everyone notifications.

## What is a Deal Portal?
----
A Deal Portal is simply a multi-page portal. You can pretty much build anything with it. You can build a client portal, documents from scratch like proposals, then contracts, then invoices, and then an onboarding process. You can build a workflow process, for example, if you have a client focused on services, you can create a workflow for them to request tasks or jobs from you. It's up to your creativity, but of course, we have templates and best practices.


#### Contextual-Driven
------
One of the things I want to achieve with Deal Portals is the ability to create documents from scratch that you can duplicate and clone for every new client. You don't have to go into these Deal Portals and change all the document information. Instead, whenever you create a new project and associate it with the right contacts and companies, your Deal Portal will have the correct context to create its own documents. When you duplicate, you don't just duplicate; you duplicate with the right context. You simply just duplicate, assign it to a new project, and that Deal Portal will automatically create documents, invoices, and proposals based on that project's context.

Inside the Deal Portal, you can create a blank canvas, use a document builder for proposals and invoices (we have lots of templates), use form builders, or embed a page. All of this will be seen as a multi-page funnel which you then save and share with your client. They will get a branded, white-label subdomain with your specific URL for that deal portal. They can go through it, and whatever steps they take, we will capture it for you and tell you exactly what they're doing. So if they've already read your proposal but did nothing, you know your proposal probably isn't working that well, and you can do something about it.

#### Enabling optimized Deal Flow
----
I've been working with sales teams for quite some time, and I realized that most of the time, what gets lost in translation is that they send out a sales pitch and nothing comes back. Through Deal Portal, you can actually do something with that. You have data to tell you exactly where you messed up during your sales process. Is it during profiling? During the conversation? Or is it that when you sent the Deal Portal, they didn't even open it? Was it too late? That's why we create projects, so you can reduce that lateness. You have a verbal agreement, and right away you have your Deal Portal ready.

So, is it because your proposal is too long? We should be able to see that it's too long and people don't read it. Let's do something about it. A Deal Portal allows the sales process to be much, much smoother and allows you to create a much better experience for your user to onboard and deal with you.


## Tooling & Utilities
----
Of course, we're going to have all of these great things for you marketers or you salespeople who like to see some data. You have analytics. You can manage your workflows and see all of our templates. You can also see all of your projects that have been done before in the archive. So whenever you hire someone and onboard them, you can give them these archived items to refer to.

Lastly, you can create your own custom reports. If you want to see your deals pipeline, your total contact growth, your growth trend, or your project status overall, you can check it in Reports. But the Deal Portal was not meant for just creating documents. It was meant for you to create a portal between you and your potential prospect. If you send an invoice and you want to ensure that people are coming back to the invoice every month, you can create workflows for that. You don't need an invoice app; you don't need all these other project management apps to close deals. Everything is embedded in the Deal Portal.