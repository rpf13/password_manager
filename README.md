# README

## State of Development

[GoRails PasswordManager](https://gorails.com/series/password-manager-with-rails-7)

Lessons done until the Style with Tailwind CSS.
It seems tailwind css is not 100% correctly set up.
The app/assets/stylesheets/application.tailwind.css seem to have issues with the import `Unknown at rule @tailwind`
Once the `@layer components` out of that file are used, like shown in the tutorial, it is clearly visible that there is an issue with tailwind CSS setup, since they have no effect.

Checking on that, there might be an issue, since the project used another version of rails than the one installed.
The logic of the application is working fine, styling is missing and not finished yet.
