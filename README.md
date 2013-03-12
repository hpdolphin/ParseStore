# Quickstart 

## Seed sample products on Parse 

1. Create a new app on Parse named ParseStore
2. Add the new Parse Application ID and REST API key to Install/install.sh (Very important that you use the REST API key here)
3. Using Terminal, cd into the provided Install folder, and run "sh install.sh"
4. Checkpoint: via the data browser, verify a class named "Item" is created on the Parse app. There should be 3 products in this class: T-shirt, hoodie, and mug. There should be an image associated with each product.

## Get your app up and running 

1. Add the Parse Application ID and Parse Client API key to /Store/Resources/Development.xcconfig and /Store/Resources/Distribution.xcconfig
2. In XCode, choose Clean from the Product menu.
3. Checkpoint: run your app in the simulator; you should see the products via your app. You cannot buy yet.

## Set up your Stripe account 

1. Create a Stripe account.
2. Add Stripe test publishable key to /Store/Resources/Development.xcconfig and /Store/Resources/Distribution.xcconfig
3. Add Stripe test secret key to /CloudTest/cloud/main.js
4. Using Terminal, cd into the provided CloudTest folder, and run "parse add", then select the ParseStore app you set up
5. run "parse deploy"
6. In XCode, choose Clean from the Product menu. 
7. Checkpoint: verify via the data browser that the cloud code is properly deployed.
8. Checkpoint: run your app in the simulator; test buying using the Stripe test credit card. It should work.

## Set up your Mailgun account (optional) 

1. Create a MailGun account (for sending email when purchases are made).
2. Add Mailgun keys to /CloudTest/cloud/main.js
3. Deploy the updated code with "parse deploy"
4. Checkpoint: run your app in the simulator; enter your real email address while making the purchase. It should send you an email.

## You are done! Congratulations!
