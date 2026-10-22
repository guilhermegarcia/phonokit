# phonokit tests

The test suite uses [tytanic](https://typst-community.github.io/tytanic/) (`tt`). Version 0.4.1 targets Typst 0.15.1.

```sh
brew install tytanic                              # or: cargo binstall tytanic
tt run --font-path tests/fonts                    # run every test
tt run --font-path tests/fonts consonants         # run tests whose id matches "consonants"
tt update --font-path tests/fonts <test-id>       # accept a new reference after an intended change
```

Always pass `--font-path tests/fonts` (or set `TYPST_FONT_PATHS=tests/fonts`). The suite doesn't read system fonts. It only uses Charis (committed here, SIL Open Font License; see `fonts/OFL.txt`) and the fonts embedded in Typst. That way the references render identically on every machine and in CI.

## Layout

Each test is a folder `tests/<module>/<case>/` with a `test.typ`:

- **Reference tests** have a `ref/` folder with the expected PNG pages. A failing run writes `out/` (current output) and `diff/` (differences). Both are gitignored.
- **Logic tests** (`logic-*`) are compile-only. They check values with `assert.eq` and errors with `assert-panic`.

Test files import the package root-relative: `#import "/lib.typ": *`.

## Rules

- Every bug fix adds or updates a test that would have caught it.
- Run `tt update` only when an output change is intended, and look at the new reference first.
- The GitHub workflow (`.github/workflows/tests.yml`) runs the suite on every push and pull request to `main`. If it fails, download the `artifacts` zip to see the `diff/` images.
