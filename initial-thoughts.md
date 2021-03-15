# Thinking out loud

As a fan of comics and graphic novels [SuperHero Db API](https://superheroapi.com/index.html) is a nice dataset to explore, it covers lots of different publishers, a ton of different characters, at least one image per character.

## Initial questions

• What data is available through the api? How is it structured?
• What different ways do people like to consume content?
• How can we expose the data to appeal to different use cases?
• What interesting things could we do with it?
• What user interfaces make sense?
• What technical challenges do I want to explore?

## Initial answers

### Data
• Heroes are exposed by Id, there's no API to return available ids
 - This means they'll either have to be hardcoded into the app or I'd need to supplement their API with an external API of my own. To get started, I'll go hardcoded and revisit the configurable solution further down the line.

• There are are 2 APIs of interest `/search/{name}` and `/id`

• Character data for both endpoints is exposed as an object or array of objects with a complete hierarchy including:
	- Name
	– Biography
	- Appearance
	- Work
	- Connections
	- Image

• Though there are endpoints to query these subtypes individually, because we can't request a minimal set of data up front, we'd just be needlessly throwing away the full hierarchy if we didn't use it.

• The data in the subtypes use a mix of strategies for empty data including `'null'` and `'-'` so we may need some explicit data cleansing.

• Data that could be useful for comparison like `powerstats` is exposed as strings rather than numeric types so we may want to transform this.

• Data isn't referential, so while `connections` may feature other heroes, there are no direct references by Id for example.

### UX considerations

Rule one of UX club is... you are not your users.
While users are unique, user profiles are a useful way to get a snapshot of different needs, in this case I'll look at exposing the data in different ways for different use cases.
• AS A USER trying to find a specific character I WANT TO search for a detail I know SO THAT I can find them
• AS A USER browsing super heroes I WANT TO be able to visually scan through characters SO THAT I can read up on characters I find interesting
• AS A USER trying to keep track of my favourite characters I WANT TO be able to collect characters SO THAT I can jump straight to them to check their details 

These use cases can appeal to different types of users, here I'm aiming to address researchers, explorers, and curators.

### What interesting things could we do with it?

• Comprehensive search
 - Only know a specific detail like "They've got a HQ in New York", or "She's got red eyes"?
 	- Let's add a search that queries more than just name

• Visual browsing
	- A picture tells a thousand words, literally. Our brains are physically wired to rapidly extract meaning from a single image, is there a savage beast waiting in that bush? Would I be run over if I step out into this road?
		- Let's lean on character visuals for browsing so we can allow rapid visual filtering

• Gotta catch them all
	- Let's make it easy to collect characters
	- Make those collections easy to get to

### What user interfaces make sense?

• Let's check the design zeitgeist and see if there are any good patterns that will work well for us.

### Technical considerations

• I've been using SwiftUI commercially for more than a year and personally since the first beta but there have been a lot of changes in that time so I want to ensure I'm making use of those.

• Use SwiftUI Previews heavily for the design process.

• Add SwiftLint, to keep the app consistent.

• The API requires a Facebook Auth API key, let's ensure this is read from a configuration and kept out of source control.

• Though I find REDUX solves so many problems and works so well with reactive + declarative UI, I want to hold off on using it until I find I need it. If all you have is a hammer... everything looks like a nail. I want to ensure I keep my toolbox full of options.

### Other considerations

• I want to keep the scope as small as possible, iterating all the way.
• I have limited time to build this out, prototype-first, polish later.
