# AIDAMS homework

Repo where I do the linux/bash exercises from the course.

## Contents

- `env_install.sh` — script that sets up a python dev environment (checks python3, pip, installs jupyter notebook, etc.). Written for the bash scripting exercise. Supports a few flags: `--dry-run`, `--verbose`, `--quiet`, `--uninstall`.
- `install.sh` — small install script written during the git branch exercise.

## Usage

```sh
./env_install.sh            # normal run
./env_install.sh --dry-run  # show what it would do without installing anything
./env_install.sh --uninstall --dry-run
```

A log of what the script does is written to `env_install.log`.

---

## Git reflection questions (from the git mini exercise)

1. **Why is version control useful?**
   Because it keeps a history of every change so you can go back in time, see what was changed and by whom, and work with other people without overwriting each other's work.

2. **What is the difference between staging and committing?**
   Staging is choosing which changes go into the next snapshot (like putting things in a box), committing is actually taking the snapshot. You can stage files with `git add` and commit them with `git commit`.

3. **When should you make a commit?**
   After a logical chunk of work is done, e.g. when a feature works or a bug is fixed. Small commits are easier to understand and to revert than huge ones.

4. **What is the difference between `git init` and `git clone`?**
   `git init` creates a brand new empty repository in the current folder, `git clone` copies an existing repository (usually from a remote) to your machine.

5. **Why should you write good commit messages?**
   Because future you (and your teammates) need to understand what each change did without reading the whole diff. A short message saying *what* and *why* is enough.

6. **What is the purpose of using branches?**
   Branches let you work on something new without touching the main code. You can experiment, and only bring the changes back (merge) when they are ready.

7. **When would you create a new branch instead of working on main?**
   For any feature or fix that might take a while or break things, so the main branch stays in a working state. In this exercise I used a branch for `install.sh` and merged it once it was done.
