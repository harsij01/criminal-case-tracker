# Design Document

By Harsini Jegatheesan

Video overview: <URL HERE>

## Scope

### Purpose
The purpose of this database is to manage and track criminal cases,
including the suspects, victims, investigators, evidence, and reports
associated with each case. It is designed to simulate a real-world
law enforcement case management system.

### In Scope
* **Cases** — criminal cases with their type, status, and dates
* **Suspects** — individuals linked to cases with their personal
info and criminal history
* **Victims** — individuals harmed in cases with their statements
* **Investigators** — law enforcement officers assigned to cases
* **Evidence** — physical, digital, and forensic items collected
* **Reports** — incident, progress, forensic, and closing reports

### Out of Scope
* Court proceedings and verdicts beyond case status
* Financial transactions or bail information
* Witness protection details
* Real-time GPS tracking of suspects
* Inter-agency data sharing

## Functional Requirements

### What a user can do
* Add, view, and manage criminal cases and their current status
* Link suspects, victims, and investigators to specific cases
* Track evidence collected for each case and its current status
* File and retrieve reports for any case
* Query repeat offenders, unsolved cases, and case summaries
* View open cases with their lead investigator and suspect count

### Beyond scope
* Users cannot manage court hearings or sentencing
* Users cannot process payments or bail bonds
* Users cannot track real-time locations of suspects
* Users cannot manage classified or confidential clearance levels

## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?
* What's beyond the scope of what a user should be able to do with your database?

## Representation

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?
* What attributes will those entities have?
* Why did you choose the types you did?
* Why did you choose the constraints you did?

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?

## Limitations

In this section you should answer the following questions:

* What are the limitations of your design?
* What might your database not be able to represent very well?
