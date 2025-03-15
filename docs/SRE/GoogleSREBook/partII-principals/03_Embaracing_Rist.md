# 03 Embracing Risk

## Recap

### Review

First, the chapter likely starts by explaining that in any system, especially large-scale ones, **failures are inevitable**. So, the approach **isn't to eliminate all risks** but to manage them _effectively_. The concept of an **"error budget"** might come into play here. Error budgets allow for a certain amount of **acceptable failure,** which balances reliability with the need to innovate and deploy new features.

Then, there's probably a discussion on **how to measure risk**. Metrics like Service Level Indicators (SLIs) and Service Level Objectives (SLOs) are essential. **SLIs are the metrics that define what good service looks like (e.g., latency, availability)**, and **SLOs are the targets for those metrics**. **The error budget is the allowable deviation from the SLO**. **_So, if a service meets its SLOs, there's room in the error budget to take risks, like deploying new features._** If the error budget is exhausted, the team focuses on stability until the budget recovers.

The chapter might also talk about **risk tolerance**. Different services have different levels of criticality, so their SLOs and error budgets will vary. For example, a user-facing service might have stricter SLOs than an internal tool. The key is to align the SLOs with business needs and user expectations.

Another point could be about the trade-offs between **reliability** and **feature development**. By setting clear SLOs, teams can decide when to push new releases and when to hold back. This prevents over-engineering for reliability, which can stifle innovation, and under-engineering, which leads to frequent outages.

There might also be a section on **how to handle incidents** when they occur. **Post-mortems are important in SRE culture**, focusing on **learning from failures without blame**. This ties back to managing risk by **continuously improving systems based on past incidents**.

The chapter is specifically about embracing risk, **so maybe it emphasizes that taking calculated risks is necessary for progress**. The error budget policy formalizes this by allowing teams to take risks as long as they stay within their budget. If they exceed the budget, they must prioritize reliability work until the budget is restored.

Also, the chapter might discuss the **importance of communication between SREs and product teams**. By having agreed-upon SLOs, both parties can align on priorities. **Product teams want to _launch features_, SREs ensure _reliability_, and the error budget provides a common framework for decision-making**.

Chapter 3 includes sections like **"Managing Risk"**, **"Defining and Using Error Budgets"**, **"Risk Tolerance"**.

- In **"Managing Risk"** they probably talk about the inevitability of failure and the need for SREs to manage rather than eliminate risk.
- **"Defining and Using Error Budgets"** explains how error budgets work as a tool to balance reliability and development velocity.
- **"Risk Tolerance"** discusses setting appropriate SLOs based on business needs. The summary would tie these together.

So putting it all together, the chapter explains that SREs **embrace risk by quantifying it through SLOs and error budgets**, allowing teams to take calculated risks while maintaining an acceptable level of reliability. **It emphasizes balancing feature development with system stability**, using error budgets as a control mechanism, and fostering a culture that learns from failures without blame.

## Definitions

1. **Inevitability of Failure:**
   Systems, especially at scale, will inevitably experience failures. The goal is not to eliminate all risk but to manage it effectively through structured frameworks.

2. **Service Level Objectives (SLOs) and Error Budgets:**

   - **SLOs** define acceptable reliability targets (e.g., 99.9% uptime).
   - **Error budgets** represent the allowable margin for failure (e.g., 0.1% downtime). Teams can deploy new features while within the budget but must prioritize reliability if the budget is exhausted.
   - This balance ensures innovation without compromising critical system stability.

3. **Risk Tolerance:**

   - SLOs align with business and user needs. Critical services (e.g., user-facing apps) have stricter SLOs, while internal tools may tolerate higher risk.
   - Teams avoid over-engineering for reliability (which stifles innovation) or under-engineering (leading to frequent outages).

4. **Trade-offs Between Reliability and Development:**
   Error budgets guide decisions: teams push releases when budgets are healthy and focus on stability when budgets are depleted. This fosters collaboration between SREs and product teams.

5. **Learning from Failure:**

   - **Post-mortems** analyze incidents without blame, focusing on systemic improvements.
   - Systems are designed to handle failures gracefully (e.g., redundancy, graceful degradation).

6. **Reducing Toil:**
   Automation minimizes repetitive manual tasks, freeing SREs to focus on engineering solutions that mitigate risk and enhance reliability.

**Conclusion:**
The chapter emphasizes embracing risk as a necessary part of progress. By quantifying risk through SLOs and error budgets, teams can innovate while maintaining reliability. A culture of learning from failures and aligning technical goals with business priorities ensures sustainable growth.
