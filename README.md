# EveryDayQuote
Tool for passive learning; Place your favourite quote and info on the background, and learn whenever you peek it.

# How to use it
Download the release, or clone the directory build it on Godot. Make sure to have a 'Quotes.txt' in the same folder of the executable or project.

## Quote format
Quotes.txt uses the JSON syntax ([wikipedia](https://en.wikipedia.org/wiki/JSON)), being straightforward for adding new entries; For such, do as follow for each entry:

````
[
 {
  "author":
    "The author of the quote 1 here",
  "quote":
    "The quote 1",
  "tags":
    ["tag1", "tag2"]
 },
 {
  "author":
    "The author of the quote 2 here",
  "quote":
    "The quote 2",
  "tags":
    ["tag1", "tag2"]
 }
]
````


New lines and spacing don't matter. But be sure to enclosure all your quotes with '[]' and each with a '{}' so:

````
[
  {"author":"The author of the quote 1 here","quote":"The quote 1","tags":[]},
  {"author":"The author of the quote 2 here","quote":"The quote 2","tags":["tag1"]},
  {"author":"","quote":"The quote 3","tags":["tag1", "tag2", "tag3"]}
]
````

Is also valid.

## Author
Author of the quote, may be blank.

## Quote
Quote, may be blank... but why would you?

## Tags
Tags of the quote, it doesn't add any functionality, just for organization.
