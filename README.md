# CS207 Exercise Project
Team: Erik Cruz, Dylan Schneiderman, Nicki Lee


## Description
Our app will be a workout and nutrition app that allows a user to keep track of their daily workouts and nutritional intake. There won’t be a lot of interaction between the two components other than the combination of consumed calories from the nutrition side and TDE (total daily expenditure) from the workout side.

### Workout Component
- When the app is opened, user will be prompted to enter their gender, height, and weight. These values will get plugged into a BMR calculator to find the user’s basal metabolic rate. This number will be combined with a user’s active calories for the day. This will be fetched with the iOS HealthKit.
- Users can create templates for their workouts. They can add exercises to a template by searching for it through an API call or they can manually enter the name of an exercise, what muscle it targets, etc.
- When a user starts a workout, they can import a template. Users are not locked into the template. They can delete or add exercises as they wish
- When a workout is completed, it is saved in their workout history

### Nutrition Component
- User has a “personal” bank of food that they can add to. This will likely be filled with foods/ingredients that a user will often consume. A user can manually create a food by entering the name of the food and the food's nutritional values (serving size, calories, protein, fat, carbohydrates). A user can also add to their personal food bank by searching for food through some Food/Nutrition API call.
- Nutritional information is tracked throughout the day as a user adds the food they are eating. Information is summed up and a running total is displayed to the user

## Project APIs
- Exercises API (https://api-ninjas.com/api/exercises)
- Food API (basic foods, restaurant items, barcode search) (https://developer.edamam.com/food-database-api?gclid=Cj0KCQiAgaGgBhC8ARIsAAAyLfGAjjRuIn_XgXEEKJNHuDzwtbGJF6o5w7Uj2Ivdf5MsSiyoNpi5bRAaAvNvEALw_wcB)

## iOS Kits
- Health Kit

## Complexity
- A majority of the complexity for the app will come from getting the two API’s working as well as the HealthKit portion
- The form for creating a workout might be complicated. It needs to be able to change instead of being a static form (for example, by adding/deleting a set, adding/deleting an exercise, etc.)

## Other
- One DataStore to save information (templates, completed workouts, personal food bank, and nutritional info of food eaten throughout the day)
