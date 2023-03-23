# Demo PaYC for Pre Submit Quality Gate

## Why need Pre-Submit quality gate?
Quality engineers could establish quality milestones in multiple levels (depending on software maturity). After the project reaches certain maturity, certain violations should break the build unless fixed by the developers. However, breaking the build at post-submit workflow consumes a long time to get feedback to the developers. This is because after the commit is made and the code is pushed to the repository, the PR will go into CI/CD pipeline and wait for a long time in the queue also stopping other PRs behind it. After waiting for long time and after making other PRs wait for long time, it might fails just because developer failed to fix few violations or overlooked some violations from Polyspace As You Code. To reduce this lengthy feedback time and to enforce quality in the software pre-commit hooks could be used in the pre-submit workflow. This way the pre-commit quality gate ensures if desired quality is achieved before a PR is created.

## What happens at Pre-Submit quality gate?
Pre-commit hooks run polyspace analysis (depending on the software maturity, it could be configured to SQO1, SQO2, and so on) only on the changed files in the local repository. If the findings from Polyspace does not meet the expected quality levels, commit is failed. Developer needs to fix the listed violations to successfully commit the changes. This strictly ensures the quality levels for new changes.

## Prerequisite to use the demo
1) Use the package manager pip/conda to instal pre-commit package `pip install pre-commit #pip` or `conda install -c conda-forge pre-commit #conda`
2) Python version > 3.0

## Steps to perform before using the hook
1) Clone this repository: `git clone https://insidelabs-git.mathworks.com/polyspacers/Bilbopoly.git`
2) open git bash from `<path>/Demo_PaYC_for_Pre_submit_Quality_Gate`
3) Install git hook scripts:  `pre-commit install`

That's it. Now you have activated the pre-commit hooks and every time a commit is made, the hook runs few tests which includes:
1) clang-format check: Checks for formatting error with Google style and throws error if formatting error exists
2) Yaml check (Autofixing script): Checks for formatting errors in Yaml file and fixes the violation automatically
3) Trimming Trailing whitespaces (Autofixing script): Trailing whitespaces if exist, they are fixed 
4) Builds project and perform Polyspace analysis: Performs a build, generates compilation database and then perform Polyspace analysis only on changed files
5) Verifies quality gate: All MISRA violations needs to be fixed before commiting. If they are not fixed, hook breaks the commit

## How to demo the project?
1) In the `main.cpp`, remove line 9 `typedef unsigned int uint32_t;` and change `uint32_t main()` to `int main()`
2) Make sure this change is reflecting in git: `git status`
3) Stage the changes: `git add .`
4) Try to commit the changes: `git commit -m "trial commit"`
5) MISRA violation 3-9-2 occurs and commit fails
6) Fix the violation by adding same lines. Fix the issue with PaYC on VS/VSCode/Eclipse with the misra_checker.xml file in this repo to make it visually clear.
7) Now again stage the changes: `git add .`
8) Try to commit the changes: `git commit -m "trial commit"`. This time commit is successful
9) Do not push the code to repo, rather use `git reset --hard HEAD`

![image](https://insidelabs-git.mathworks.com/polyspacers/Bilbopoly/-/blob/f343006abd8f82b9e11aa7053b5820f8813b5cf0/hook_result.png)

