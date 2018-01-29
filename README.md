# The first and one of the most popular niche job boards for Russian-speaking Ruby developers

[![CircleCI](https://circleci.com/gh/rubyjobsru/app.svg?style=svg)](https://circleci.com/gh/rubyjobsru/app)

The job board is a Rails application, so you might expect all casual Rails things like controllers, models, templates, and etc.

See the app running at [http://www.rubyjobs.ru](http://www.rubyjobs.ru).

## Getting Started

Thanks to [the normalized script pattern](https://github.com/github/scripts-to-rule-them-all) it is very easy to run the all locally. Once you have
the code on you machine, simply run:

```shell
script/setup
```

The setup script will install all gem dependencies, create and prepare development and test databases, and etc.

### Development Dependencies

- Docker
- Docker Compose

### Testing

Nothing more than:

```shell
script/test
```

### Code Style

Code of the application must follow default configuration provided by Rubocop. However due to some legacy constrains some cops and policies are disabled for now. Feel free to contribute and fix that.

Run code linter with:

```shell
script/lint
```

## Copyright Information

(c) 2008-2018, Alexander Sulim, [http://sul.im](http://sul.im)
