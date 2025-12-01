# dbt Challenge Project
This is a non-functioning mock dbt project used as a performance task for Analytics Engineer candidates.

## The Challenge
This challenge is focused on dbt concepts and the candidate's aptitude for recognizing, understanding, and replicating dbt development patterns.

Please **fork** this project and provide a link to the fork as your challenge submission.

### Prompt 1:
The project is lacking documentation.
- Add a YML file for each model, providing names, data types, and descriptions of each column in the model. Add tests at your discretion.
- Add a YML file for each macro that explains what it is used for and how it works. Include a list of arguments that the macro accepts and the impact they have.


### Prompt 2:
At a later stage of the project, the Product data from Rexel/GexPro will need to be combined with the product data from Capitol Light.
- Add models and YML files as needed so that the Capitol Light data is prepared to the same state of readiness as the Rexel/GexPro data is right now.


### Prompt 3:
It is a pain to keep track of and add the "updated_at" timestamp to snapshots. It would be preferable to apply a consistent name at the Standardization step, so that each Snapshot definition could have the same argument for "updated_at."
- Please extend the Standardization macros so that you can call the macro with an argument for what the "updated_at" column is named in the sourced, and it will consistently output a column called "updated_at" as an alias of whatever the source's timestamp is called.
