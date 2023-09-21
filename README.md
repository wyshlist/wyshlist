testing CI
![Logo](https://github.com/Danrod16/wyshlist/blob/master/app/assets/images/logo.jpg?raw=true)

# Community based wishlists for product managers and tech teams.


Wyshlist is a Rails application that empowers stakeholders by allowing them to contribute and vote on the next product decision. With Wyshlist, users can create wishlists, manage wishlist items, and share them with others. Stakeholders can collaborate, add, edit, and delete items within wishlists, enabling seamless decision-making and prioritization. The app promotes transparency, engagement, and collective decision-making, ensuring that the voice of every stakeholder is heard.



## Features

- Stakeholder Contributions: Wyshlist enables stakeholders to actively contribute to the decision-making process by adding their ideas, suggestions, and wishlist items.

- Voting System: The built-in voting system allows stakeholders to cast their votes on wishlist items, prioritizing them based on popular demand.

- Comments and Discussions: Stakeholders can engage in discussions and provide feedback on wishlist items, fostering open communication and collaboration.

- Public and Private Wishlists: Wyshlist offers the flexibility to create both public and private wishlists. Public wishlists can be shared with a wider audience, while private wishlists allow for more confidential collaboration.

- Roadmap and Backlog: Easily manage and organize wishlist items with the Roadmap and Backlog features. The Roadmap showcases the prioritized items, while the Backlog keeps track of ideas and potential future additions.

- Progress Tracking: Keep stakeholders informed about the progress of wishlist items by marking them as "In Process," "Completed," or "On Hold."

- User Authentication and Permissions: Secure user authentication ensures that only authorized stakeholders can access and contribute to wishlists. Different permission levels can be assigned to control access and editing rights.

## Installation
To run Wyshlist locally, please follow these steps:

**Clone the repository:**

git clone https://github.com/your-username/wyshlist.git
Navigate to the project's directory:

```cd wyshlist```

**Install the required dependencies:**

```bundle install```

**Set up the database:**

```
rails db:create
rails db:migrate
rails db:seed
```

**Start the Rails server:**

```dev```

Access Wyshlist in your web browser by visiting http://localhost:3000.


## How to contribute

**Pull the code**

```git pull origin master```

**Create a new branch**

Before creating a new branch make sure that it is always assigned to an issue.

```gco -b 46-add-button-to-homepage```

46 being the issue number.

***Create pull request***

Always add the issue number with the keyword 'closes', ex -> "closes #46" in the description to close the issue 46 when the PR is merged.
