### START ###

# learning r
# created by: alj
# created on: 31 july
# edited by: alj
# edited on: 17 august  

# PACKAGES USED: 
### maybe: gitcreds 

# LESSON 2: Git and GitHub in RStudio 
### learning objectives 
### 1. be able to explain the differences in Git and GitHub
### 2. track changes made to local copies of code
### 3. contribute code to a public repo on GitHub

# Git vs. GitHub
# let's start basic: what is the difference between Git and GitHub?
# this is probably the most often asked question!

# Git: version control system
### open-source piece of software that acts like "track changes" 
# GitHub: website where you store and collaborate with others
### GitHub has an instance of Git running on the website, tracking your changes, your collaborator's changes, etc.
# Git was developed for track changes in code, but is used for more! 
### just like we use it for storing information for this class

# in the rest of this lesson, I'm going to use the word "repository" or "repo"
# this is a storage system, like a folder on your computer, where your work is kept 

# we have R and RStudio on our computers, this is important!
# you'll need to have Git installed to take advantage of this version control too
# let's confirm this:
### in RStudio, select Global Options from Tools
### Tools > Global Options
### in that dialog box, click the Git/SVN tab on the left-hand side of the window
### near the top of the pane, there is a field for the Git executable
### if you see something like "C:/Program Files/Git" then you've got it!
### if you see something like "(Not Found)" you need to install
##### link for git: https://git-scm.com/downloads
### if you install Git, SHUTDOWN AND RESTART R
### then repeat the steps above to ensure this is confirmed
### just because you have used GitHub and R, does not mean this is set up
### so check! 

# after installing Git, you'll need to configure it
# you can do this in RStudio or in your preferred command line
# in RStudio, open a new Terminal 
### Tools > Terminal > New Terminal
### personalize and enter:
### git config --global user.name 'Your Name'
### git config --global user.email 'your@email.com'
### you should be already signed up for GitHub, so now we're good to go!

# OOPS! 
# on some versions of MacOS, you'll need to install another program to get RStudio and Git to talk to each other 
# if you see an error with something like: "xcrun"
# then: shut down RStudio, open the Terminal application and run
# xcode-select --install 
# then open RStudio again, and you should be set! 
### i am NOT a Mac user, so here is more about that error: https://apple.stackexchange.com/questions/254380/why-am-i-getting-an-invalid-active-developer-path-when-attempting-to-use-git-a

# with that said, we can't have nice things
# in the olden days, we sent changes from our machine to GitHub with our username and password
# but, we used things like "password" or "UApassword" ... and bad people did bad things to our code
# so now GitHub requires a lot of authentication 
### as an aside, I also think that GitHub was made to be exclusionary... but that's for another time
# for now, we're going to focus on personal access tokens
# but you can check out others here: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github
# so what is a Personal Access Token? 
# essentially, it is a long, random password that is hard to guess
# github gives instructions here: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-token

# a few notes on these instructions
### in step 5, when you click: "generate new token" the website may prompt you for your password
### for this field, use the password that you use to log in to the GitHub website
### in step 6, "give your token a descriptive name", i use the name of my computer
### this way, if i lose my computer, it dies, or someone steals it, i can revoke access
### in step 7, the expiration option: make it a short one - if you're using a public machine or a loaner
### remember, you can always delete the token!
### in step 8, for scopes, check the box that says "repo"

# let's pause here and go through this

# OKAY, now we're going to really get into GitHub
# we have three options:
### 1. start a new repository
### 2. use an existing GitHub repository
### 3. use an existing local repository 

# for this lesson, we're just going to use: 
# Option 1: starting from scratch 
# let's do this first and pretend that we are just starting a project
# we want to use GitHub for collaboration 
# this makes it easiest to start ON GitHub 
# a. so go to GitHub, log in, and create a new repository
### this is usually a big green button "NEW REPO" or "NEW"

# for this lesson, let's call it "practice" in the name field
# and then describe it as "practicing GitHub and RStudio integration" or something similar
# then congratulations! you're using GitHub!! 

# leave the browser open, but now we're actually going to use RStudio - not just watch me take notes in it...
# we want to make a new project, with the new repo we just created 
# b. create a new project (File > New Project)
# c. select the "VERSION CONTROL" option
# d. select the "Git" option 
# e. in the box that opens, just fill in the information for your repo URL
### you can copy this from your repo website, by clicking the "code" button, which gives you a URL to copy
# return to RStudio and paste this in
# f. and then "Create Project" and you're connection! 

# we're going to move forward here
# but, at the end of this file, there are two other ways through existing repos

# before we go too far: a warning
# you have things set up! (yay!)
# your repo is ready to use! (yay!)
# it is connected to RStudio! (yay!)
# the default size on GitHub for a file is 100 MB
# so, before you add any file to Git's history on your local machine 
### before you check the box next to the file name in the Git tab
# make sure the file is less than 100 MB
# if you have files BIGGER than that: list them as .gitignore files 
### .gitignore is a text file in your repository's folder that lists files you don't want Git to keep track of
# another work around is to compress large files and then add that
# you can store files larger, but you have to set up Git Large File Storage (LFS)
# here is documentation on that: https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github
# you'll need to do this before you add any files to the history
# for what it's worth: I've not done this, but just use .gitignore

# collaborate! 
# you have linked RStudio with a GitHub page
# for the purpose of this lesson, you want to consider two Git repos:
### 1. the local repo, which is the files on your computer
### 2. the remote repo, which is the files on the GitHub website 

# the general process of working with remote repos is
# PULL  > Make changes + save > ADD > COMMIT > PUSH > Repeat

# the steps in CAPS are actual Git commands
# let's talk about these in more detail:
### PULL: this downloads any file updates from the GitHub repo and tries to incorporate them with your local copy
##### this step is often forgotten, but is so important
##### try to always start your sessions with PULL
##### you can pull the latest code from GitHub with the blue Pull button in the Git tab of the (sually) top-right panel in RStudio 
### Make changes: at this point, you can add files, change files, delete files 
##### just remember to SAVE your changes
### ADD: this instructs Git that you would like to make Git aware of any changes made to files in your local repo
##### saving is NOT enough in this case! 
##### after you have made yoru changes and saved them, add them by clicking the "staged" box, next to the file name in the Git tab of RStudio
### COMMIT: the last thing you need to do is record those changes on your local Git Repo 
##### in RStudio, click the "commit" button in the Git tab
##### be sure to write a commit message: informative but brief
##### do not skip this - documentation is better than none!
### PUSH: move the committed changes up to the remote (GitHub) repo!
##### you will need your GitHub ID and password to push changes to the remote repo

# you've got it! 
# so let's test it out! 

# create a new R script
### File > New File > R Script 
# and here is some sample code 
### remember best practices: add your preambles! 
# for example: 

# learning r and git 
# created by: alj
# created on: 2 august 
# edited by: alj
# edited on: 2 august  

# simulate predictor variable
x <- rnorm(n - 100)
# simulate response variable with some noise 
y <- 2 * x + rnorm(n = 100, sd = 0.2)

# plot the data 
plot (x = x, y = y)

# save this file as "simulate-practice-data.R"

# now lets Git! 
# find the Git panel (upper right of RStudio window)
### click the little box to the left of the file we just made
### a check mark should appear in the box (you may have to wait)
### checking the box is ADD described above 
# next we need to COMMIT by pressing the commit button in the Git pane
### in the dialog box that appears, we want to enter a brief + informative message
### for this, type "initial commit" and press the button
# the final step is to send these changes to GitHub with PUSH
### in the Git pane, find the PUSH button, indicated by an upward facing arrow 

# at this point, you might have to enter your GitHub username and password
# be sure to look at what the field is asking for as BOTH dialog boxed will be titled "password" *eyeroll*
# remember for password, you want to add your personal access token - the long string generated at the beginning

# now: if you have used RStudio to talk with GitHub in the past, you may have to force R to ask you for your GitHub credentials
# you can do this with the gitcreds package

install.packages("gitcreds")
library(gitcreds)
gitcreds_set()
# select option 2 and provide credentials at prompts 

# return to your browser with your repo and refresh
# your new file should be shown
# you did it!

# GREAT JOB!
# now a big caveat!
# I NEVER USE GIT THIS WAY!
# this is a way that R people taught me
# so I am teaching to you!
# but, I prefer GitHub Desktop - so let's use that
# everyone should already have that installed 

# open it up + confirm that it is connected with your account
# if this is the case, click on the button at the left which says something like "current repository"
# there is then a button that says "add" 
### find the repo you created and then "clone" it
# now the hard part
### PATHWAYS
# let's pause and find everyone's git folder 
# to have Git and RStudio talk to each other through this method, you need to save the code in the folder
### in my experience of teaching this method, THIS is the hardest part
# you will have a folder that is the name of your repo
# you need to save your code IN THAT FOLDER
# let's take our code from above and make a new file


# create a new R script
### File > New File > R Script 
# and here is some sample code 
### remember best practices: add your preambles! 
# for example: 

# learning r and git 
# created by: alj
# created on: 2 august 
# edited by: alj
# edited on: 2 august  

# simulate predictor variable
x <- rnorm(n - 100)
# simulate response variable with some noise 
y <- 2 * x + rnorm(n = 100, sd = 0.2)

# plot the data 
plot (x = x, y = y)

# save this file as "simulate-practice-data_desktop.R"
### make sure you are saving it in the folder in your git folder

# now look at your GitHub desktop interface
# you should see your new file there!

# whichever you use is a matter of preference ... and maybe advisor preference
# honestly, i like it because i find it easier
# i have used the first method, i have used command line git, ... and desktop is just easier for me, so that's what i use!
# part of this, is figuring out what works for you and what works for your research 

### CONNECTION ALTERNATIVES ### 

# 2. use an existing GitHub repository 
# if you are using a repo that already exists 
# go there on the GitHub website, and click "Clone or download"
# that will open a dialog with the repository URL
# copy that to the clipboard 
# and then follow b - f above 
# we'll practice this later! 

# 3. use an existing local repository 
# imagine you have code on your machine that you want to push to GitHub
# log into GitHub and create a new repo (like in 1)
# then connect your machine through the command line interface
### Tools > Terminal > New Terminal 
### echo "# simulate-data" >> README.md
### git init
### git add README.md
### git commit -m "first commit"
### git remote add origin YOURURL
### git push -u origin main
# make sure to substitute YOUR URL above
# then shut down and restart R studio to complete the integration
# for what it's worth: i haven't done an integration this way, but just in case: now you know!

# okay, I'm going to actually end this now! 

# YOU DID IT! 
# let's review our Lesson 2 learning objectives 
### 1. be able to explain the differences in Git and GitHub
### 2. track changes made to local copies of code
### 3. contribute code to a public repo on GitHub 

# in our next lesson, we'll take these skills and integrate them with Lesson 1 
# but, let me ask again, from today's learning objectives, where do you want more time, energy, information?

### END ###