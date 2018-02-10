# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Phone numbers are removed from the database. It brings more problems than profit.
  Email is much better for communication in case of rubyjobs.ru and many online
  resources.
- A dedicated field for short description of a job ad added. Current
  automated solution (the first three paragraphs) does not work well because
  sometimes it is too long.

## [3.0.0] - 2018-02-10

### Added

- This CHANGELOG file
- Completed migration to Docker for development and deployment environments. Now
  the only external dependency for the project is Docker.

[Unreleased]: https://github.com/rubyjobsru/app/compare/v3.0.0...HEAD
