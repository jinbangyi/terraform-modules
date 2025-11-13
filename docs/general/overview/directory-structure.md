# Directory Structure

## Current Directory Structure

```bash
xneuro-core/
├── docs/
│   ├── dev/                           # docs for developer, easy for edit and read
│   ├── AI/                            # AI generated docs, summaries. AI generated docs are too comprehensive to read, so should only used for reference only.
│   │   └── summaries/                 # summary dir for each task coding agent done
│   ├── examples/                      # usecases/examples of how to use some features in this repo
│   └── general/                       # general docs for other user
│       ├── overview/                  # overview of this repo, coding agent should always load content in this dir to take a overview of this repo
│       │   ├── directory-structure.md # directory structure of this repo
│       │   ├── resource.md            # resources for this repo, for example how to get logs from loki api endpoint
│       │   └── standards.md           # include all the standards of this repo, for example coding standards, design standards, doc standards
│       ├── features/                  # all features of this repo
│       └── components/                # docs of all components in this repo
└── package.json
```
