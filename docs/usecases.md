# Overview

The excel project grew organically overtime since the year 2000.
Since we are using this basic application, to learn and teach
how to create an application in different languages or environment
we are documenting the different Use Cases that make up the
requirements.

## Feature List

1. Provide a way define a Session.
1. Provide a way to define and store a list of words.
1. Provide a way to define and store a list of emails address to distribute bingo cards.
1. Create a method to randomly select 25 words for the bingo card from the word list.
1. Create a method to add a FREESPOT into a random place in the list of words
1. Create a bingo card presentation of the 24 words selected and the FREESPOT.
1. Create a method to email the bingo card presentation to the list of email
   addressed collected.

## Base Data Model

In order for this application to work on many different environment
we have defined the different persistence Entities using JSON Schema.

```todo: create schema.json files and link them here.```

```todo: update Excel version to create a sheet that for email and update vbs```

The major Entities of Buzzword Bingo are:

1. All environments Entities:
   1. Word list - the schema  to describe a word set that can be use in multiple games.
2. Multi-user Environment Entities:
   1. User - This is dependant of the environment and how authentication
   is handled.
   1. User Profile - Detail about the User that is not provide by an
   environment.
   1. Session - A game based on a word list that can be shared with
   other Users.
3. Temporary Entities:
   1. Bingo Card Data - is a Schema of the data that make up a bingo card.

## Base Product Use Cases

### Define Word List

todo

### Define User in Game

todo

### Create Bingo Card

As a user we would like to be able to create a bingo card
based on a Word List for a set of people that
would like to participate in a bingo game so we can
make meetings fun and keep people engaged.

## Expanded Use Case

### Word List Sets

As an User of buzzword bingo we would like to be able to define
different set of word list that can allow quick creation
of bingo cords based on a different set of words associated to
a phrase.
