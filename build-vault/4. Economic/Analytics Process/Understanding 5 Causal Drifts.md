---
draft: true
title: "Understanding 5 Causal Drifts"
date: "2025-08-02"
tags: 
---
The first step to achieve forecast is to understand cause and effect of metrics/variables in our business architecture.

Imagine this, if forecast is so simple, everyone could take a list of historical data, set a goal, profile some, figure out some patterns, apply linear regression to it and tada, you got a new forecast. 
Then new data comes in and you did the same.

The problem here is not forecasting, the problem here is that, now you have forecast, so what?

Forecasting using an outcome data, is like predicting whether a team will win at halftime by only looking at the scoreboard.

It tells you the current trajectory but gives you zero insight into _why_ the score is what it is, or what plays to call next to change the final result.

Using only historical outcome data is like trying to drive a car forward by looking exclusively in the rearview mirror. You can see the path you've already traveled (your historical data), and you might be able to guess where you'll end up if you continue in a straight line, but you can't see the curve in the road ahead.

The forecast becomes a **passive prediction**, not an active strategic tool. A simple twist to this, is simply understand what happened and why is that happening. It is simple theory, but not in praxis. There's too many moving factor in a business. We don't really understand why things happened the way it happened. 

An example of forecast differences:

- **Using past simple data**: without understanding why
    - **Simple Forecast:** "Based on last quarter's sales data, we forecast a 10% drop in sales next quarter."
        - **The "So What?" Moment:** Management is left asking, "Okay... so what do we do? Why is it dropping?" The forecast is an alarm bell with no instructions.
- **Using past data:** with understand why it happen.
    - **Causal Forecast:** "Our forecast shows a 10% drop in sales, which based of data our **sales driven primarily marketing leads and it's conversion rate.** As of now by trend, by a 20% decrease in marketing leads and a 5% drop in our sales conversion rate. Our model shows that every \$10,000 in marketing spend generates approximately 50 new leads."
        - **The Actionable Insight:** The "so what" is immediately clear. The forecast isn't just a number; it's a diagnostic tool. The business now knows which **levers** to pull. To counter the drop, they can analyze and address the slump in marketing leads or invest in training to improve the sales conversion rate.
- **Using past data with understanding why it happen:** and understanding how it happened
	- **Causal Forecast:** "Our forecast shows a 10% drop in sales, which driven primarily marketing leads and it's conversion rate. As of now by trend, by a 20% decrease in marketing leads and a 5% drop in our sales conversion rate. Based of evidence and experimentation, we are confident that marketing leads is dropping due to raising CAC, we also understood that CAC is primarily a factor of Ads Content Production Quantity and Ads Optimization, as of now we produced the same value of ads Content Production Quantity, but result is dropping, either we had Influence Drift here or Ads wasn't optimized properly. The drop is 5% in our sales conversion rate might be due to, our new landing page, or Speed-to-Lead problem, based of data our average Speed-to-Lead remained the same, and even slightly better, but our conversion rate dropping, maybe our optimization in Speed-to-Lead has cause us bad service.
        - **The Actionable Insight:** The "so what" is immediately clear. The forecast isn't just a number; it's a diagnostic tool. The business now knows which **levers** to pull. To counter the drop, they can analyze and address the slump in marketing leads or invest in training to improve the sales conversion rate.
- 

### Answering the "So What?"

The value of a forecast is unlocked when it moves from simply predicting an outcome to explaining _how_ that outcome is created. This is the shift from correlation to **causation**.

- **Simple Forecast:** "Based on last quarter's sales data, we forecast a 10% drop in sales next quarter."
    - **The "So What?" Moment:** Management is left asking, "Okay... so what do we do? Why is it dropping?" The forecast is an alarm bell with no instructions.
- **Causal Forecast:** "Our forecast shows a 10% drop in sales, driven primarily by a 20% decrease in marketing leads and a 5% drop in our sales conversion rate. Our model shows that every \$10,000 in marketing spend generates approximately 50 new leads."
    - **The Actionable Insight:** The "so what" is immediately clear. The forecast isn't just a number; it's a diagnostic tool. The business now knows which **levers** to pull. To counter the drop, they can analyze and address the slump in marketing leads or invest in training to improve the sales conversion rate.

Forecasting becomes truly powerful when it models the cause-and-effect relationships within your business, turning a passive prediction into a dynamic simulation for strategic decision-making. You're no longer just predicting the score; you're coaching the team on how to win the game.