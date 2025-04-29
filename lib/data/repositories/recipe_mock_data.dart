import 'dart:convert';

import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';

final List<Recipe> recipeData = [
  Recipe(
    title: "Sesame Chicken",
    category: "Main Courses",
    difficulty: "Not too tricky",
    description:
        "Crispy, golden-brown chicken bites coated in a sweet and savory sesame sauce—this takeout favorite is surprisingly easy to make at home. With a perfect balance of crunch and flavor, it’s a guaranteed crowd-pleaser!",
    notes: "",
    tags: ["comfort food", "chicken", "Friday night", "high protein"],
    imagesJson: jsonEncode({
      "titleImg": "https://www.dinneratthezoo.com/wp-content/uploads/2015/04/sesame-chicken-2.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 20,
    cookingTime: 20,
  )
    ..directions.addAll([
      CookingDirection(description: "Place the eggs, salt and pepper in a bowl. Stir to combine"),
      CookingDirection(
          description: "Place the flour and 1/2 cup of cornstarch in a shallow bowl or on a plate. Stir to combine."),
      CookingDirection(
          description:
              "Dip each piece of chicken into the egg mixture, then into the flour. Repeat the process with all of the chicken."),
      CookingDirection(description: "Heat 3 inches of oil in a deep pan to 350 degrees F"),
      CookingDirection(
          description:
              "Add 7-8 pieces of chicken to the pan. Cook for 5 minutes or until crispy and golden brown. Repeat the process with the remaining chicken"),
      CookingDirection(description: "Drain the chicken on paper towels"),
      CookingDirection(
          description:
              "While the chicken is cooking, combine the honey, soy sauce, ketchup, brown sugar, rice vinegar, sesame oil and 2 tsps of cornstarch in a bowl."),
    ])
    ..ingredients.addAll([
      ListItem(amount: 1.5, unit: "lbs", description: "chicken breast"),
      ListItem(amount: 2, description: "eggs beaten"),
      ListItem(description: "salt and pepper to taste"),
      ListItem(amount: 0.5, unit: "cup", description: "all purpose flour"),
      ListItem(amount: 0.5, unit: "cup", description: "cornstarch"),
      ListItem(description: "oil for frying"),
      ListItem(amount: 1, unit: "tsp", description: "vegetable oil"),
      ListItem(amount: 1, unit: "tsp", description: "minced fresh garlic"),
      ListItem(amount: 0.25, unit: "cup", description: "honey"),
      ListItem(amount: 0.25, unit: "cup", description: "soy sauce (reduced sodium if possible)"),
      ListItem(amount: 2, unit: "tbsp", description: "ketchup"),
      ListItem(amount: 3, unit: "tbsp", description: "brown sugar"),
      ListItem(amount: 2, unit: "tbsp", description: "rice vinegar"),
      ListItem(amount: 1, unit: "tbsp", description: "toasted sesame oil"),
      ListItem(amount: 2, unit: "tsps", description: "cornstarch"),
      ListItem(amount: 2, unit: "tbsp", description: "sesame seeds"),
      ListItem(amount: 2, unit: "tbsp", description: "sliced green onions"),
    ]),
  Recipe(
    title: "Shiitake Mushroom Stir Fry",
    category: "Main Courses",
    difficulty: "Not too tricky",
    description:
        "A rich umami-packed dish featuring tender shiitake mushrooms stir-fried with garlic, soy sauce, and fresh vegetables. This quick and healthy meal is bursting with deep, earthy flavors and pairs perfectly with rice or noodles.",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg":
          "https://www.allrecipes.com/thmb/V1qC6HgDjow3A_ZzGwjTCLdaTnw=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/8722745_Shiitake-Mushroom-Stir-Fry_Maura-Rawlette_4x3-cd3973ee9d5140168f34d1d4910dc1e6.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 15,
    cookingTime: 20,
  ),
  Recipe(
    title: "3-Ingredient-Pizza",
    category: "Appetizers",
    difficulty: "Easy",
    description:
        "Who knew homemade pizza could be this easy? With just three simple ingredients, you’ll have a crispy, cheesy, and absolutely delicious pizza ready in minutes. Perfect for busy days or last-minute cravings!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg":
          "https://www.allrecipes.com/thmb/kMqfMSgj0TcccOtpfJFWA5DXmiM=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/ALR-8660871-3-ingredient-pizza-appetizer-VAT-4x3-2-239e0af95224490695d435f58d2cb71e.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 15,
    cookingTime: 22,
  ),
  Recipe(
    title: "Bruschetta",
    category: "Appetizers",
    difficulty: "Easy",
    description:
        "Crispy toasted baguette slices topped with juicy, marinated tomatoes, fresh basil, and a drizzle of olive oil—this classic Italian appetizer is light, refreshing, and bursting with flavor. A must-try for any gathering!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg":
          "https://www.allrecipes.com/thmb/68eDhLkdA8VEDy6iWkq6EDsG5V0=/0x512/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/54165-balsamic-bruschetta-DDMFS-4x3-e2b55b5ca39b4c1783e524a2461634ea.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 15,
    cookingTime: 5,
  )
    ..directions.addAll([
      CookingDirection(description: "Preheat oven to 400°F (200°C)."),
      CookingDirection(
        description: "Slice baguette and brush with olive oil.",
      ),
      CookingDirection(
        description: "Toast in oven until golden brown.",
      ),
      CookingDirection(
        description: "Mix diced tomatoes, basil, garlic, olive oil, salt, and pepper.",
      ),
      CookingDirection(
        description: "Top toasted bread with tomato mixture and serve.",
      ),
    ])
    ..ingredients.addAll([
      ListItem(amount: 1, description: "baguette"),
      ListItem(amount: 4, description: "ripe tomatoes"),
      ListItem(amount: 2, unit: "cloves", description: "garlic"),
      ListItem(description: "Fresh basil leaves"),
      ListItem(description: "Olive oil"),
      ListItem(description: "Salt and pepper"),
    ]),
  Recipe(
    title: "Caesar Salad",
    category: "Salads",
    difficulty: "Easy",
    description:
        "A crisp and refreshing salad made with crunchy romaine lettuce, crunchy croutons, and a creamy, garlicky Caesar dressing. Topped with Parmesan cheese, this classic dish is simple yet incredibly satisfying.",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://www.sonachgefuehl.de/wp-content/uploads/2019/05/Caesar_Salad_01.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 10,
    cookingTime: 0,
  )
    ..directions.addAll([
      CookingDirection(description: "Chop romaine lettuce and place in a bowl."),
      CookingDirection(description: "Add croutons and Parmesan cheese."),
      CookingDirection(description: "Drizzle with Caesar dressing and toss gently."),
      CookingDirection(description: "Serve immediately."),
    ])
    ..ingredients.addAll([
      ListItem(amount: 1, unit: "head", description: "romaine lettuce"),
      ListItem(amount: 0.5, unit: "cup", description: "croutons"),
      ListItem(amount: 0.25, unit: "cup", description: "grated Parmesan cheese"),
      ListItem(description: "Caesar dressing"),
    ]),
  Recipe(
    title: "Chocolate Brownies",
    category: "Sweet Stuff",
    difficulty: "Not too tricky",
    description:
        "Fudgy, rich, and irresistibly chocolatey—these homemade brownies are the perfect indulgence. With a crackly top and gooey center, every bite melts in your mouth, making it impossible to eat just one!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://www.inspiredtaste.net/wp-content/uploads/2016/06/Brownies-Recipe-1-1200.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 15,
    cookingTime: 25,
  )
    ..directions.addAll([
      CookingDirection(description: "Preheat oven to 350°F (175°C)."),
      CookingDirection(description: "Melt butter and mix with sugar and cocoa powder."),
      CookingDirection(description: "Add eggs and vanilla extract, then mix well."),
      CookingDirection(description: "Stir in flour and salt until just combined."),
      CookingDirection(description: "Pour batter into a greased baking dish and bake for 25 minutes."),
      CookingDirection(description: "Cool before cutting into squares."),
    ])
    ..ingredients.addAll([
      ListItem(amount: 0.5, unit: "cup", description: "butter"),
      ListItem(amount: 1, unit: "cup", description: "sugar"),
      ListItem(amount: 0.33, unit: "cup", description: "cocoa powder"),
      ListItem(amount: 2, description: "eggs"),
      ListItem(amount: 1, unit: "tsp", description: "vanilla extract"),
      ListItem(amount: 0.5, unit: "cup", description: "flour"),
      ListItem(amount: 0.25, unit: "tsp", description: "salt"),
    ]),
  Recipe(
    title: "Margarita Cocktail",
    category: "Drinks",
    difficulty: "Easy",
    description:
        "The ultimate refreshing cocktail! A perfect blend of tangy lime juice, smooth tequila, and a hint of orange liqueur, served over ice with a salted rim. One sip, and you’ll feel like you’re on a beach vacation!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://kitchenswagger.com/wp-content/uploads/2019/06/classic-margarita-1.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 5,
    cookingTime: 0,
  )
    ..directions.addAll(
      [
        CookingDirection(description: "Rub the rim of a glass with lime and dip in salt."),
        CookingDirection(description: "Fill the glass with ice cubes."),
        CookingDirection(description: "Mix tequila, lime juice, and triple sec in a shaker with ice."),
        CookingDirection(description: "Shake well and strain into the prepared glass."),
        CookingDirection(description: "Garnish with a lime wedge and serve."),
      ],
    )
    ..ingredients.addAll([
      ListItem(amount: 2, unit: "oz", description: "tequila"),
      ListItem(amount: 1, unit: "oz", description: "lime juice"),
      ListItem(amount: 1, unit: "oz", description: "triple sec"),
      ListItem(description: "Salt for rimming"),
      ListItem(description: "Lime wedge for garnish"),
    ]),
  Recipe(
    title: "Grilled Chicken Salad",
    category: "Salads",
    difficulty: "Medium",
    description:
        "Juicy, seasoned grilled chicken served over a fresh bed of crisp greens, cherry tomatoes, and cucumbers, drizzled with a light vinaigrette. It’s the perfect balance of protein, crunch, and vibrant flavors.",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://www.eatingbirdfood.com/wp-content/uploads/2023/06/grilled-chicken-salad-hero.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 15,
    cookingTime: 15,
  )
    ..directions.addAll([
      CookingDirection(description: "Grill chicken breasts until fully cooked, about 7-8 minutes per side."),
      CookingDirection(description: "Toss mixed greens, cherry tomatoes, cucumbers, and red onion in a large bowl."),
      CookingDirection(description: "Slice the grilled chicken and place on top of the salad."),
      CookingDirection(description: "Drizzle with your favorite dressing and serve immediately."),
    ])
    ..ingredients.addAll([
      ListItem(amount: 2, description: "chicken breasts"),
      ListItem(amount: 4, unit: "cups", description: "mixed greens"),
      ListItem(amount: 0.5, unit: "cup", description: "cherry tomatoes, halved"),
      ListItem(amount: 1, description: "cucumber, sliced"),
      ListItem(amount: 0.25, description: "red onion, thinly sliced"),
      ListItem(description: "Salad dressing of choice"),
    ]),
  Recipe(
    title: "Spaghetti Carbonara",
    category: "Main Courses",
    difficulty: "Medium",
    description:
        "A rich and creamy Italian classic made with just a handful of ingredients—al dente spaghetti tossed in a silky sauce of eggs, Parmesan cheese, crispy pancetta, and black pepper. Simple, yet deeply satisfying!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg":
          "https://www.marthastewart.com/thmb/dlKxe9kD9I9_Yfrqi7c4nMyT3yM=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/MSL-338686-spaghetti-carbonara-hero-3x2-69999-560b45d1dd9f4741b717176eff024839.jpeg",
      "cookingDirectionImg": [],
    }),
    prepTime: 10,
    cookingTime: 15,
  )
    ..directions.addAll([
      CookingDirection(description: "Cook spaghetti according to package instructions until al dente."),
      CookingDirection(description: "In a separate pan, cook the pancetta or bacon until crispy."),
      CookingDirection(description: "Whisk eggs, Parmesan, and black pepper in a bowl."),
      CookingDirection(
          description: "Combine the cooked spaghetti and pancetta with the egg mixture, tossing quickly to coat."),
      CookingDirection(description: "Serve immediately, garnished with more Parmesan and black pepper.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 12, unit: "oz", description: "spaghetti"),
      ListItem(amount: 4, unit: "oz", description: "pancetta or bacon, diced"),
      ListItem(amount: 2, description: "large eggs"),
      ListItem(amount: 0.5, unit: "cup", description: "Parmesan cheese, grated"),
      ListItem(amount: 0.25, unit: "tsp", description: "black pepper"),
    ]),
  Recipe(
    title: "Chocolate Lava Cake",
    category: "Sweet Stuff",
    difficulty: "Tricky",
    description:
        "A decadent dessert with a perfectly baked outer shell and a warm, gooey chocolate center. One bite into this rich, molten treat, and you’ll be in chocolate heaven! Best served with a scoop of vanilla ice cream.",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://www.billyparisi.com/wp-content/uploads/2022/02/lava-cake-1.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 15,
    cookingTime: 15,
  )
    ..directions.addAll([
      CookingDirection(description: "Preheat the oven to 425°F (220°C)."),
      CookingDirection(description: "Butter and flour four ramekins."),
      CookingDirection(description: "Melt chocolate and butter in a heatproof bowl over simmering water."),
      CookingDirection(description: "Whisk in sugar, eggs, and flour until smooth."),
      CookingDirection(description: "Pour batter into ramekins and bake for 12 minutes."),
      CookingDirection(description: "Let cool for 1-2 minutes before inverting onto plates."),
      CookingDirection(description: "Serve with vanilla ice cream or berries.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 0.5, unit: "cup", description: "unsalted butter"),
      ListItem(amount: 6, unit: "oz", description: "dark chocolate"),
      ListItem(amount: 0.5, unit: "cup", description: "sugar"),
      ListItem(amount: 2, description: "large eggs"),
      ListItem(amount: 2, description: "egg yolks"),
      ListItem(amount: 0.25, unit: "cup", description: "all-purpose flour"),
      ListItem(description: "Vanilla ice cream or berries for serving"),
    ]),
  Recipe(
    title: "Lemonade",
    category: "Drinks",
    difficulty: "Easy",
    description:
        "A timeless thirst-quencher made with freshly squeezed lemons, a touch of sugar, and ice-cold water. Sweet, tart, and incredibly refreshing—perfect for a hot summer day!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://brownthumbmama.com/wp-content/uploads/2016/02/lemonadecupcropOPT.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 5,
    cookingTime: 0,
  )
    ..directions.addAll([
      CookingDirection(description: "Juice the lemons into a pitcher."),
      CookingDirection(description: "Add the sugar and stir until dissolved."),
      CookingDirection(description: "Fill the pitcher with cold water and stir to combine."),
      CookingDirection(description: "Serve over ice with a lemon slice for garnish.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 4, description: "large lemons"),
      ListItem(amount: 0.5, unit: "cup", description: "sugar"),
      ListItem(amount: 5, unit: "cups", description: "cold water"),
      ListItem(description: "Ice cubes"),
      ListItem(description: "Lemon slices for garnish"),
    ]),
  Recipe(
    title: "Pasta Primavera",
    category: "Main Courses",
    difficulty: "Medium",
    description:
        "A vibrant, veggie-packed pasta dish that celebrates the freshness of the season. Lightly sautéed vegetables tossed with tender pasta in a simple garlic and olive oil sauce—healthy, colorful, and full of flavor!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://cdn.loveandlemons.com/wp-content/uploads/2022/06/pasta-primavera-1.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 10,
    cookingTime: 20,
  )
    ..directions.addAll([
      CookingDirection(description: "Cook pasta according to package instructions."),
      CookingDirection(
          description:
              "In a separate pan, sauté mixed vegetables (like zucchini, bell peppers, and tomatoes) with olive oil until tender."),
      CookingDirection(description: "Add the cooked pasta to the vegetables, and toss with garlic and basil."),
      CookingDirection(description: "Season with salt, pepper, and Parmesan cheese.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 8, unit: "oz", description: "pasta"),
      ListItem(amount: 1, description: "zucchini, sliced"),
      ListItem(amount: 1, description: "bell pepper, sliced"),
      ListItem(amount: 1, unit: "cup", description: "cherry tomatoes, halved"),
      ListItem(amount: 2, unit: "tbsp", description: "olive oil"),
      ListItem(amount: 2, unit: "cloves", description: "garlic, minced"),
      ListItem(amount: 0.25, unit: "cup", description: "fresh basil, chopped"),
      ListItem(description: "Salt and pepper to taste"),
      ListItem(amount: 0.25, unit: "cup", description: "Parmesan cheese"),
    ]),
  Recipe(
    title: "Crispy Tofu Stir-Fry",
    category: "Side Dishes",
    difficulty: "Medium",
    description:
        "Golden, crispy tofu tossed with colorful stir-fried veggies and a flavorful soy-garlic sauce. This protein-packed dish is crunchy on the outside, tender on the inside, and perfect for a quick meal!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://lifemadesweeter.com/wp-content/uploads/Crispy-Tofu-recipe-vegan-gluten-free-low-carb.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 15,
    cookingTime: 20,
  )
    ..directions.addAll([
      CookingDirection(description: "Press tofu to remove excess moisture and cut into cubes."),
      CookingDirection(description: "Heat oil in a pan and fry tofu until golden and crispy."),
      CookingDirection(description: "Remove tofu and stir-fry mixed vegetables in the same pan."),
      CookingDirection(description: "Add soy sauce, garlic, and ginger. Stir to combine."),
      CookingDirection(description: "Return the tofu to the pan, toss together and serve.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 1, unit: "block", description: "firm tofu"),
      ListItem(amount: 1, unit: "tbsp", description: "oil"),
      ListItem(amount: 1, description: "bell pepper, sliced"),
      ListItem(amount: 1, unit: "cup", description: "broccoli florets"),
      ListItem(amount: 2, unit: "tbsp", description: "soy sauce"),
      ListItem(amount: 2, unit: "cloves", description: "garlic, minced"),
      ListItem(amount: 1, unit: "inch piece", description: "ginger, grated"),
    ]),
  Recipe(
    title: "Mint Mojito",
    category: "Drinks",
    difficulty: "Easy",
    description:
        "A refreshingly cool cocktail with muddled fresh mint, tangy lime juice, and a splash of white rum, topped with sparkling soda water. Crisp, zesty, and incredibly thirst-quenching!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://cdn.loveandlemons.com/wp-content/uploads/2020/07/mojito-recipe.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 5,
    cookingTime: 0,
  )
    ..directions.addAll([
      CookingDirection(description: "In a glass, muddle fresh mint leaves with sugar and lime juice."),
      CookingDirection(description: "Add ice and rum, then top with soda water."),
      CookingDirection(description: "Stir gently and garnish with mint sprigs and lime slices.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 10, description: "fresh mint leaves"),
      ListItem(amount: 1, unit: "tbsp", description: "sugar"),
      ListItem(description: "Juice of 1 lime"),
      ListItem(amount: 2, unit: "oz", description: "white rum"),
      ListItem(description: "Soda water"),
      ListItem(description: "Ice cubes"),
      ListItem(description: "Mint sprigs and lime slices for garnish"),
    ]),
  Recipe(
    title: "Caramelized Carrots",
    category: "Side Dishes",
    difficulty: "Easy",
    description:
        "Sweet and buttery, these caramelized carrots are cooked to perfection, bringing out their natural sugars and deep flavors. A simple yet elegant side dish that pairs beautifully with any meal!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg":
          "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fit,w_730,h_913/k%2FPhoto%2FRecipes%2F2023-11-honey-glazed-carrots%2F33086-Honey-Glazed-Carrots",
      "cookingDirectionImg": [],
    }),
    prepTime: 10,
    cookingTime: 20,
  )
    ..directions.addAll([
      CookingDirection(description: "Peel and slice the carrots into uniform pieces."),
      CookingDirection(description: "Heat butter and olive oil in a pan over medium heat."),
      CookingDirection(description: "Add carrots to the pan and sauté until they start to soften, about 5-7 minutes."),
      CookingDirection(
          description:
              "Sprinkle with sugar and cook until the carrots are golden and caramelized, about 10-12 minutes."),
      CookingDirection(description: "Season with salt, pepper, and fresh parsley before serving.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 1, unit: "lb", description: "carrots, peeled and sliced"),
      ListItem(amount: 2, unit: "tbsp", description: "butter"),
      ListItem(amount: 1, unit: "tbsp", description: "olive oil"),
      ListItem(amount: 1, unit: "tbsp", description: "sugar"),
      ListItem(description: "Salt and pepper to taste"),
      ListItem(description: "Fresh parsley for garnish"),
    ]),
  Recipe(
    title: "Vegetable Fried Rice",
    category: "Side Dishes",
    difficulty: "Medium",
    description:
        "A quick and flavorful dish made with perfectly stir-fried rice, crisp vegetables, and savory soy sauce. Light, delicious, and a great way to use up leftover rice!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://veryveganish.com/wp-content/uploads/2024/07/Vegetable-Fried-Rice-no-egg-oil-free-21.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 10,
    cookingTime: 15,
  )
    ..directions.addAll([
      CookingDirection(description: "Cook rice ahead of time and let it cool."),
      CookingDirection(description: "Heat oil in a large pan or wok. Add chopped vegetables and cook until tender."),
      CookingDirection(description: "Add garlic and ginger and stir-fry for 1 minute."),
      CookingDirection(description: "Add rice, soy sauce, and stir to combine."),
      CookingDirection(description: "Push rice to the side of the pan and scramble eggs in the empty space."),
      CookingDirection(description: "Mix everything together and serve.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 2, unit: "cups", description: "cooked rice"),
      ListItem(amount: 1, unit: "cup", description: "mixed vegetables (peas, carrots, corn, etc.)"),
      ListItem(amount: 2, unit: "cloves", description: "garlic, minced"),
      ListItem(amount: 1, unit: "inch piece", description: "ginger, grated"),
      ListItem(amount: 2, unit: "tbsp", description: "soy sauce"),
      ListItem(amount: 2, description: "eggs, beaten"),
      ListItem(amount: 1, unit: "tbsp", description: "oil"),
      ListItem(description: "Green onions for garnish"),
    ]),
  Recipe(
    title: "Mushroom Risotto",
    category: "Main Courses",
    difficulty: "Tricky",
    description:
        "Creamy, rich, and deeply comforting, this risotto is loaded with the earthy goodness of mushrooms and a touch of Parmesan cheese. A luxurious dish that’s worth every stir!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg":
          "https://cdn77-s3.lazycatkitchen.com/wp-content/uploads/2019/11/vegan-mushroom-risotto-close-800x1200.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 10,
    cookingTime: 25,
  )
    ..directions.addAll([
      CookingDirection(description: "Heat oil and butter in a pan, then sauté onions and garlic until soft."),
      CookingDirection(description: "Add sliced mushrooms and cook until golden brown."),
      CookingDirection(description: "Add rice and stir for 1 minute to coat in oil and butter."),
      CookingDirection(
          description: "Gradually add warm broth one ladle at a time, stirring constantly until absorbed."),
      CookingDirection(description: "Continue adding broth and stirring until the rice is tender and creamy."),
      CookingDirection(description: "Finish with Parmesan and a bit of salt and pepper.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 2, unit: "tbsp", description: "butter"),
      ListItem(amount: 1, unit: "tbsp", description: "olive oil"),
      ListItem(amount: 0.5, description: "onion, diced"),
      ListItem(amount: 2, unit: "cloves", description: "garlic, minced"),
      ListItem(amount: 8, unit: "oz", description: "mushrooms, sliced"),
      ListItem(amount: 1, unit: "cup", description: "Arborio rice"),
      ListItem(amount: 4, unit: "cups", description: "vegetable or chicken broth"),
      ListItem(amount: 0.25, unit: "cup", description: "Parmesan cheese"),
      ListItem(description: "Salt and pepper to taste"),
    ]),
  Recipe(
    title: "Lemon Bars",
    category: "Sweet Stuff",
    difficulty: "Medium",
    description:
        "Tangy, buttery, and perfectly sweet, these bright and zesty lemon bars are the perfect dessert for citrus lovers. With a melt-in-your-mouth shortbread crust and a smooth lemon filling, they’re simply irresistible!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://preppykitchen.com/wp-content/uploads/2020/02/Lemon-Bars-feature-new.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 15,
    cookingTime: 30,
  )
    ..directions.addAll([
      CookingDirection(description: "Preheat the oven to 350°F (175°C)."),
      CookingDirection(
          description:
              "Make the crust by mixing flour, sugar, and butter, then press into the bottom of a baking dish."),
      CookingDirection(description: "Bake the crust for 15 minutes."),
      CookingDirection(description: "Whisk together eggs, sugar, flour, lemon juice, and zest for the filling."),
      CookingDirection(description: "Pour the filling over the hot crust and bake for another 20-25 minutes."),
      CookingDirection(description: "Let cool before cutting into squares and dust with powdered sugar.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 1.5, unit: "cups", description: "all-purpose flour"),
      ListItem(amount: 0.25, unit: "cup", description: "sugar"),
      ListItem(amount: 0.5, unit: "cup", description: "unsalted butter, softened"),
      ListItem(amount: 2, description: "large eggs"),
      ListItem(amount: 1, unit: "cup", description: "sugar"),
      ListItem(amount: 2, unit: "tbsp", description: "flour"),
      ListItem(amount: 0.25, unit: "cup", description: "lemon juice"),
      ListItem(amount: 1, unit: "tbsp", description: "lemon zest"),
      ListItem(description: "Powdered sugar for dusting"),
    ]),
  Recipe(
    title: "Iced Matcha Latte",
    category: "Drinks",
    difficulty: "Easy",
    description:
        "A creamy and energizing drink made with high-quality matcha green tea, lightly sweetened, and served over ice with milk. Smooth, refreshing, and packed with antioxidants!",
    notes: "",
    tags: [],
    imagesJson: jsonEncode({
      "titleImg": "https://coffeecopycat.com/wp-content/uploads/2023/04/IcedMatchaLatte1-1200x1600-1.jpg",
      "cookingDirectionImg": [],
    }),
    prepTime: 5,
    cookingTime: 0,
  )
    ..directions.addAll([
      CookingDirection(description: "Whisk the matcha powder with a little hot water to create a smooth paste."),
      CookingDirection(description: "Fill a glass with ice cubes and pour the matcha mixture over."),
      CookingDirection(description: "Top with milk (or milk alternative) and stir."),
      CookingDirection(description: "Sweeten with honey or syrup if desired.")
    ])
    ..ingredients.addAll([
      ListItem(amount: 1, unit: "tsp", description: "matcha powder"),
      ListItem(amount: 2, unit: "tbsp", description: "hot water"),
      ListItem(amount: 1, unit: "cup", description: "milk or milk alternative"),
      ListItem(description: "Ice cubes"),
      ListItem(description: "Sweetener of choice (honey, agave, etc.)"),
    ])
];
