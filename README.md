# Starbase

Starbase is a mock application that lets you, as a user:

- Sign up, sign in and reset your password via email authentication
- Follow stars, genres and movies
- List genres along with their movies
- List and search through stars by their names

and a few more things in undocumented graphql endpoints. It's deployed on Heroku
at [https://f4881080e5.herokuapp.com](https://f4881080e5.herokuapp.com)

## Usage

To set up starbase for development, migrate and seed the database:

```shell
bundle exec rails db:migrate
bundle exec rails db:seed
```

The seeding might take a bit as it imports a few thousand rows of star and movie
data, and inserts them one by one, not in bulk.

With the database ready, you can run a local instance:

```shell
bundle exec rails server
```

You can also run the scarce number of integration tests available:

```shell
bundle exec rails test
```

## Further Discussion

Along with the aforementioned issues, there are even more I'm aware of and would have loved to fix if I had more time.

* The little spinning animation of the follow icons for displays cards are bound to
  network actions so they might be delayed when there are network issues, hurting UX.

* The code might be synctactically inconsistent at places. I've recently gotten
  my Github Copilot Beta key and this is the first project I've used it on and
  it's a bit distruptive at times :(

* The search bar in the stars view constantly queries for every keystroke which would
  be a waste of resources in the real world. It would be better to have it wait
  N milliseconds of unchanged input, triggered by keystrokes, and then query.

* The homepage might take a bit to load on first launch, so it might benefit
  from a loading indicator.

* Heroku doesn't offer any simple free STMP transports so anything that requires
  email sending (password reset and email confirmation) might be a bit of a
  hassle.

* I've tried to make the UI look okay on mobile devices but there are some rough
  parts where I haven't bothered to put more time into, e.g. the pagination on
  genre pages.

* I've written a few integration tests with enough diversity to let you know I
  can write good tests :) The coverage isn't near 100%, but I'm sure it's a good
  start.
