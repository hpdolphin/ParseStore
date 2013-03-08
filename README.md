** Quickstart **

* Seed sample products on Parse *

1. Create an app on Parse.
2. Add Parse app ID and Parse REST (important!) key to /Install/install.sh
3. cd into /Install, and run "sh install.sh"
4. Checkpoint: via the data browser, verify a class named "Item" is created on the Parse app. There should be 3 products in this class: T-shirt, hoodie, and mug. There should be an image associated with each product.

* Get your app up and running *

1. Add Parse app ID, Parse client key to /Store/Resources/Development.xcconfig and /Store/Resources/Production.xcconfig
2. Checkpoint: run your app in the simulator; you should see the products via your app. You cannot buy yet.

* Set up your Stripe account *

1. Create a Stripe account.
2. Add Stripe test publishable key to /Store/Resources/Development.xcconfig and /Store/Resources/Production.xcconfig
3. Add Stripe test secret key to /CloudTest/cloud/main.js
4. cd into CloudTest, run "parse add", then select the app you set up
5. run "parse deploy"
6. Checkpoint: verify via the data browser that the cloud code is properly deployed.
7. Checkpoint: run your app in the simulator; test buying using the Stripe test credit card. It should work.

* Set up your Mailgun account (optional) *
1. Create a MailGun account (for receiving an email when purchases are made).
2. Add Mailgun keys to /CloudTest/cloud/main.js
3. Checkpoint: run your app in the simulator; enter your real email address while making the purchase. It should send you an email.

You are done! Congratulations!