<h1 align="center"> <code>moviesApp</code> </h1>
<h3 align="center"> A Shiny App-Package </h3>
<h5 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shinyap/"> Shiny App-Packages </a> </h5>

<hr>

# moviesApp

`moviesApp` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

## Movie review data application

The original code and data for the Shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

# Using code examples

The branches in this repo contain a Shiny application in the various stages of development. The best way to access each branch/app is with the [`shinypak` package](https://mjfrigaard.github.io/shinypak/). 

```r
# install.packages("pak")
pak::pak("mjfrigaard/shinypak")
library(shinypak)
```

List all the apps with `list_apps()`


```r
head(list_apps())
#>                  branch        last_updated
#> 2     01_whole-app-game 2024-01-01 14:11:32
#> 1        02.1_shiny-app 2024-01-04 13:05:58
#> 4       02.2_movies-app 2024-01-04 13:07:59
#> 5         02.3_proj-app 2024-01-04 13:08:58
#> 6      03.1_description 2024-01-04 13:10:00
#> 7            03.2_rproj 2024-01-04 13:25:06
```

Launch an app with `launch()`

```r
launch(app = "02.3_proj-app")
```

Or use the terminal

``` bash
git clone https://github.com/mjfrigaard/moviesApp.git
cd moviesApp
git checkout <branch_name>
open moviesApp.Rproj
```

------------------------------------------------------------------------

# Branches

View all the applications in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## GitHub Actions

This chapter introduces GitHub Actions and CI/CD.

### `20.1_cicd-style`

[`20.1_cicd-style`](https://github.com/mjfrigaard/moviesApp/tree/20.1_cicd-style) gives examples [GitHub Actions](https://docs.github.com/en/actions).

The style workflow is stored in the `.github` folder:

```
.github/
  └── workflows
      └── style.yaml

2 directories, 1 file
```

The workflow file contains the following: 

```
# Workflow derived from https://github.com/r-lib/actions/tree/v2/examples
# Need help debugging build failures? Start at https://github.com/r-lib/actions#where-to-find-help
on:
  push:
    branches: [20.1_cicd-style]
    paths: ["**.[rR]", "**.[qrR]md", "**.[rR]markdown", "**.[rR]nw", "**.[rR]profile"]

name: Style

jobs:
  style:
    runs-on: ubuntu-latest
    env:
      GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - name: Checkout repo
        uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Setup R
        uses: r-lib/actions/setup-r@v2
        with:
          use-public-rspm: true

      - name: Install dependencies
        uses: r-lib/actions/setup-r-dependencies@v2
        with:
          extra-packages: any::styler, any::roxygen2
          needs: styler

      - name: Enable styler cache
        run: styler::cache_activate()
        shell: Rscript {0}

      - name: Determine cache location
        id: styler-location
        run: |
          cat(
            "location=",
            styler::cache_info(format = "tabular")$location,
            "\n",
            file = Sys.getenv("GITHUB_OUTPUT"),
            append = TRUE,
            sep = ""
          )
        shell: Rscript {0}

      - name: Cache styler
        uses: actions/cache@v3
        with:
          path: ${{ steps.styler-location.outputs.location }}
          key: ${{ runner.os }}-styler-${{ github.sha }}
          restore-keys: |
            ${{ runner.os }}-styler-
            ${{ runner.os }}-

      - name: Style
        run: styler::style_pkg()
        shell: Rscript {0}

      - name: Commit and push changes
        run: |
          if FILES_TO_COMMIT=($(git diff-index --name-only ${{ github.sha }} \
              | egrep --ignore-case '\.(R|[qR]md|Rmarkdown|Rnw|Rprofile)$'))
          then
            git config --local user.name "$GITHUB_ACTOR"
            git config --local user.email "$GITHUB_ACTOR@users.noreply.github.com"
            git commit ${FILES_TO_COMMIT[*]} -m "Style code (GHA)"
            git pull --ff-only
            git push origin
          else
            echo "No changes to commit."
          fi

```
