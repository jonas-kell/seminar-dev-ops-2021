# Pipeline Code Documentation

The scripts provide a simple check for licenses of Composer- and NPM-dependencies with GitLab.

This makes ist particularly useful for Laravel applications, because these use precisely these two dependency managers.

To use the scripts, just copy the **license-checker** folder in the root of your application. If that is the case, the **vendor** folder, **node_modules** folder, **composer.json** file, **packages.json** file and the **license-checker** folder should all be on the same level and all these should be directly in the root of the location.

Then the only thing left ist to place the **.gitlab-ci.yml** file also there at the applications root, so that is gets detected by GitLab pipelines.

If the project already uses GitLab pipelines, the two jobs from the file just need to be included in the desired stage of the existing pipeline.
