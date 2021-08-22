# Changelog

<!--
Prefix your message with one of the following:

- [Added] for new features.
- [Changed] for changes in existing functionality.
- [Deprecated] for soon-to-be removed features.
- [Removed] for now removed features.
- [Fixed] for any bug fixes.
- [Security] in case of vulnerabilities.
-->

## Unreleased

- [Changed] Change namespace from `ActiveRecord::UUID` to `AR::UUID`.
- [Removed] Dropped support for Rails 4.2.

## v0.2.1 - 2019-11-26

- No significant changes.

## v0.2.0 - 2017-06-23

- [Fixed] Use the first available extension for UUID generation (`pgcrypto` or
  `uuid-ossp`).
- [Fixed] Handle `belongs_to_required_by_default`.

## v0.1.2 - 2015-05-23

- [Fixed] Make sure we always override schema statements's create_table method.

## v0.1.1 - 2015-04-27

- Initial release.

## v0.1.0 - 2015-04-27

- Yanked release.
