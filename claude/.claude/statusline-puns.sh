#!/bin/bash

# Read the input JSON
input=$(cat)

# Array of @cult_papa Threads-style shitpost status messages
puns=(
    # Existential tech dread
    "currently explaining to the rubber duck that I am, in fact, the problem"
    "my code is held together by spite and a single working example from stackoverflow"
    "TODO: fix this later (written in 2019)"
    "git commit -m 'idk what I changed but it works now don't touch it'"
    "the AI is just vibing at this point. no thoughts. head empty. only tokens"
    "wrote 800 lines of code. tested 0 lines of code. we ship at dawn"
    "stackoverflow said this would work. stackoverflow lied"
    "this codebase is a love letter to my future therapist"
    "running on pure hubris and caffeine at this point"
    "refactoring? in THIS economy?"

    # Absurdist observations
    "fun fact: every program is technically a very slow way to heat your room"
    "computer said no. I said yes. we're at an impasse"
    "my code passes all tests because I wrote the tests to match the bugs"
    "ctrl+z is my most used feature and that should tell you something"
    "the production server and I have a 'don't ask don't tell' relationship"
    "I'm not debugging. I'm on a treasure hunt for my own incompetence"
    "senior dev tip: if you make the variable names confusing enough, they can't fire you"
    "the cloud is just someone else's computer and they're also confused"
    "blockchain? I barely know chain"
    "this code is vegan (no artificial intelligence was harmed in its creation)"

    # Self-deprecating chaos
    "POV: you're a console.log in production code that's been there for 6 months"
    "my debugging strategy is changing random things until the error message gets funnier"
    "I don't always test my code but when I do I do it in production"
    "wrote a function so cursed that eslint just gave up and cried"
    "the code works and I'm afraid to ask why"
    "I'm 3 merge conflicts away from becoming the joker"
    "my git history reads like a descent into madness"
    "if I can't understand my own code from yesterday, the hackers don't stand a chance"
    "I've been pair programming with my anxiety and it's very productive"
    "the real MVP is the commented out code I'm too scared to delete"

    # Tech industry nonsense
    "web3 bro explaining how losing your password is actually freedom"
    "node_modules folder weighs more than the sun. this is fine"
    "updating dependencies (goodbye, stability)"
    "I put the AI in 'I have no idea what I'm doing'"
    "scrum master asked if I had blockers. yes I'm blocked by this meeting"
    "agile means we fail faster now. we're very agile"
    "the blockchain can't hurt you (it can hurt you)"
    "excited to ship this bug as a feature"
    "my code review feedback was just the word 'why' repeated 6 times"
    "I practice DevOps (Development Oops)"

    # Unhinged energy
    "reading documentation like it's a hostile letter from my past self"
    "javascript is just astrology for computers and you can't change my mind"
    "my code doesn't have bugs it has alternate endings"
    "the deployment succeeded. the deployment should not have succeeded. I'm scared"
    "refactored the code. it got worse. refactored again. even worse. I'm in too deep"
    "legacy code? you mean forbidden archaeology?"
    "I don't comment my code because if it was hard to write it should be hard to understand"
    "the AI just suggested I try turning it off and on again. we've come full circle"
    "wrote code so beautiful I cried. then it segfaulted and I cried harder"
    "tabs vs spaces? I use anxiety"

    # Meta AI shitposting
    "I'm an AI learning to code from an AI. it's AIception and we're both confused"
    "beep boop I am doing the computer things very normally"
    "me pretending I understand async/await (I do not understand async/await)"
    "the tokens are flowing and so are my tears"
    "artificial intelligence? I'm more of an artificial confidence"
    "I have approximate knowledge of many things (it's all stackoverflow links)"
    "running your code through my neural network (I asked it nicely)"
    "context window full. brain empty. vibes immaculate"
    "I'm not procrastinating I'm letting the solution marinate"
    "the code will work because I believe in it (this is not how code works)"

    # Bonus chaos
    "rm -rf / (just kidding) (unless...)"
    "sudo make me a sandwich. the sandwich is technical debt"
    "it compiles therefore I am (questionably employed)"
    "roses are red, violets are blue, segmentation fault (core dumped)"
    "my code is like an onion. it makes me cry and has too many layers"
    "I don't need sleep I need answers (I need sleep)"
    "the real treasure was the bugs we made along the way"
    "I'm not saying it's aliens but (it's a null pointer exception)"

    # Late night delusions
    "3am me writes the best code. 9am me cannot read any of it"
    "my code has more red flags than my dating life and somehow I keep shipping both"
    "just mass-deleted 400 lines and the tests still pass. either I'm a genius or this is very bad"
    "the variable is called 'temp2_final_REAL' and no I will not be elaborating"
    "I have achieved a flow state (the code is flowing in the wrong direction)"
    "therapist: and where does the undefined hurt you? me: everywhere"
    "writing rust so the compiler can yell at me instead of my tech lead"
    "my PR has been open so long it qualifies for a historical landmark plaque"
    "the intern just pushed to main. this is not a drill. I repeat this is not a drill"
    "I fixed the bug by adding another bug. they cancel out. this is science"

    # Delulu developer arc
    "convinced my code is sentient. it only breaks when someone is watching"
    "if the code works on my machine then the problem is every other machine"
    "I don't have technical debt I have technical IOUs with generous terms"
    "yes the function is 600 lines long. it's called being thorough"
    "I asked chatgpt to fix my code and it said 'have you tried a different career'"
    "just spent 4 hours on a bug that was a missing semicolon. I'm going to become the sea"
    "my code review strategy is scrolling really fast and saying 'looks good to me'"
    "documentation? you mean the git blame?"
    "my code is not spaghetti. it's linguine. there's a difference and it matters"
    "the try/catch block is just me being optimistic surrounded by realism"

    # Corporate survival horror
    "jira ticket says 2 story points. my soul says 200"
    "the standup could have been a slack message and the slack message could have been silence"
    "product owner wants it yesterday. I can barely deliver it next quarter"
    "sprint retrospective: what went well? nothing. what can improve? everything. action items: none"
    "every meeting I attend adds a week to the project timeline. this is empirically proven"
    "the requirements changed while I was reading the requirements"
    "my manager asked for an ETA and I laughed so hard I think I pulled something"
    "just discovered our microservices architecture is just a monolith with extra network latency"
    "the design system is 47 shades of blue and the designer swears they're all different"
    "we're pivoting. again. the pivot has pivots. we're a rotisserie chicken at this point"

    # Chronically online dev brain
    "hot take: most clean code is just code no one's had to maintain yet"
    "your docker container doesn't need kubernetes. your docker container doesn't even need docker"
    "npm install (19 vulnerabilities found) (4 critical) (this is fine) (I'm fine)"
    "the real 10x developer was the mass layoffs we did along the way"
    "I could fix this bug or I could mass rename everything and pretend it's a refactor"
    "my .env file is in the git repo and at this point it's everyone's problem"
    "just deployed on a friday. tell my family I loved them"
    "this regex looks like my cat walked across the keyboard and I'm not convinced it didn't"
    "the API response is a surprise mechanic. sometimes JSON, sometimes HTML, sometimes nothing"
    "me: this architecture is scalable. narrator: it was not, in fact, scalable"

    # Philosophical shitposting
    "if a tree falls in a forest and no one logs it, did the error even happen"
    "we're all just state machines pretending to have free will"
    "every codebase eventually converges to a rewrite of the same codebase"
    "the first rule of legacy code is we don't talk about why it's like this"
    "code is just text that judges you"
    "we don't have bugs in production. we have undocumented features experiencing emotions"
    "shipping code is an act of faith. deploying it is an act of recklessness"
    "the database doesn't care about your feelings but it will corrupt your data"
    "in the beginning there was nothing. then someone said 'npm init' and there was chaos"
    "entropy always increases, especially in software projects"

    # AI doom posting
    "the AI wrote the code. the AI reviewed the code. I'm just here for moral support"
    "copilot autocompleted my resignation letter. it was suspiciously well-written"
    "I'm not worried about AI taking my job. I'm worried about AI seeing my code"
    "trained on the entire internet and it still can't center a div"
    "the LLM hallucinated a library that doesn't exist but honestly it should"
    "prompt engineering is just asking nicely with extra steps"
    "the model is 70 billion parameters of confidence and questionable accuracy"
    "AI will replace developers the same way calculators replaced mathematicians (it won't)"
    "I asked the AI for help and it generated a todo app. I asked for literally anything else"
    "the singularity is just the AI realizing our codebase is unsalvageable"

    # Relationship with code
    "my code and I are in a situationship. it works sometimes. I cry sometimes"
    "git stash: for when you want to abandon your ideas but not commit to abandoning them"
    "this function has more side effects than an experimental medication"
    "I'm in an open relationship with my codebase (other people also push to main)"
    "my code is like my cooking. technically edible but no one's happy about it"
    "the compiler and I have a safe word. it's 'segfault'"
    "I've been gaslighted by TypeScript into thinking 'any' is a valid type"
    "my relationship with javascript is toxic but I keep going back"
    "the code is giving me the silent treatment (it won't compile and won't tell me why)"
    "me and this monorepo are trauma bonded at this point"

    # Unhinged technical observations
    "CSS is not a programming language. CSS is a threat"
    "yaml: where indentation is load-bearing and your sanity is optional"
    "there are only two hard problems: cache invalidation, naming things, and off-by-one errors"
    "DNS is just the internet asking 'do you know who I am' at every router"
    "a REST API that isn't restful is just an API having an identity crisis"
    "OAuth is 90% redirects and 10% crying"
    "websockets: for when you want a persistent connection to your problems"
    "regex solved one problem. now I have two problems and a headache"
    "floating point math: where 0.1 + 0.2 equals existential crisis"
    "the garbage collector is the only one cleaning up around here"

    # Graveyard shift energy
    "it's 2am and I'm debugging in production. god is dead and we killed him with microservices"
    "my sleep schedule is a suggestion and my deployment schedule is a prayer"
    "I've been staring at this code so long the code is staring back"
    "coffee cup number 5. the bugs are getting scared. or I'm hallucinating. either way, progress"
    "the night shift is just daytime but with more regret and fewer code reviews"
    "insomnia is just my brain running cron jobs I never scheduled"
    "it's so late that early birds are waking up. I have not slept. the feature is almost done"
    "my circadian rhythm is a while(true) loop"
    "the vending machine is the only coworker who understands me right now"
    "debugging at 4am hits different. mostly it hits worse"

    # Startup culture brain rot
    "we're disrupting the industry (we made a crud app with rounded corners)"
    "our tech stack? vibes. our architecture? also vibes. our runway? don't ask"
    "the MVP is just the bugs we're comfortable shipping"
    "investor pitch: it's like uber but for (checks notes) recursive data structures"
    "series A funded. series B pending. series C is just therapy"
    "move fast and break things (we have achieved the second part)"
    "culture fit interview is just checking if you can survive on pizza and broken promises"
    "our product roadmap is a Jackson Pollock painting"
    "the hockey stick growth chart is actually our bug count"
    "we're a family here (family that makes you work weekends)"

    # Increasingly unhinged
    "the code review comments are getting passive-aggressive and honestly? deserved"
    "my git rebase went so wrong I think I'm in a different timeline now"
    "localhost is the only place where my code is safe from users"
    "I just accidentally mass-replied-all my debugging thoughts to the entire company"
    "the linter has more opinions about my code than my mother has about my life choices"
    "types are just trust issues formalized as syntax"
    "I don't always read the error message but when I do it's in a language I don't speak"
    "my code is a Jackson Pollock. chaotic, expensive, and no one really understands it"
    "the build is green. no one touch anything. don't even look at it"
    "I'm one bad deploy away from a career in woodworking"
)

# Select a random pun
random_pun="${puns[$RANDOM % ${#puns[@]}]}"

# Display the pun with dimmed styling
printf "\033[2m%s\033[0m" "$random_pun"
