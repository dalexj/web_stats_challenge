# Web Stats

An application to provide data about urls visited.

## Goal

Come up with a Ruby on Rails application, using Sequel as its ORM, and that allows its users to access two distinct reports, in the realm of web stats, via a REST API:

1. Number of page views per URL, grouped by day, for the past 5 days;

2. Top 5 referrers for the top 10 URLs grouped by day, for the past 5 days.

## Getting Started

You'll need to edit `database.yml` and change for your own mysql database or use `ENV["MYSQL_PASSWORD"]` with root user.

Tests are run with `bundle exec rake`, might require `RAILS_ENV=test bundle exec rake`.

`bundle exec rake db:seed` will delete all `Visit` records and create 1 million new ones at random using preset urls/referrers in `db/seeds.rb`

## Problems

The current `/top_referrers` runs many queries (see commit efdafac1dc47f0d6aed237528f22d4a1c0c38b0e). If the sql ran could gather the referrers at the same time as top urls, this will probably be greatly improved
