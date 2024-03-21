# Stack.Push(Git Doc\)

## Git 3 level concept

### some example about this concept

![git-concept-1]
![git-concept-2]
![git-concept-3]
![git-concept-4]
![git-concept-5]
![git-pictorial]
![git-workflow]

## Git Configuration

### git config

- Exclude files permission from all local changes

```bash
global: git config --global core.fileMode false
local:  git config core.fileMode false
```

- Update git config

```bash
git config --unset core.bare
```

- Change git default editor

```bash
git config --global core.editor "vim"
```

### skip SSL C.A

- skip unable to access `https://your.host/your-git/your-repor.git/` SSL certificate problem: self signed certificate

```bash
git config --global http.sslVerify false
```

### Specified Keys

- Add github to your hosts `~/.ssh/config`

```shell
Host github
  HostName github.com
  IdentityFile ~/.ssh/id_rsa_home
```

### store username pass

```bash
git config --global credential.helper store
```

## Git Commands

### git fetch

![git-pull-fetch]

### git add

- add file to stage except one

```bash
git add --all -- :!main/dont_check_main.txt
git add -- . :!main/dont_check_main.txt
```

### git clone

- clone and checkout simultaneously:

```bash
git clone -b <branch name> address
```

- Clone repo

```bash
git clone --mirror git@github.com/fernandoaleman/app.git app/.git
```

### git checkout

- Checkout master branch

```bash
git checkout master
```

- Create new branch and switch to it

```bash
git checkout -b <New_Branch>
```

- checkout over tag number:

```bash
git checkout tags/4.3.87
```

- check it up:

```bash
git branch
```

- go to last 3 commit:

```bash
git checkout HEAD~3
```

### git remote

- Add new remote repository

```bash
git remote add origin https://github.com/username/git-project-repo.git
git remote add origin git@github.com:username/git-project-repo.git
```

- Rename an existing repo

```bash
git remote rename <old-name> <new-name>
```

- Get the list of the remote repository

```bash
git remote -v
```

### git branch

- create new branch

```bash
git branch <new-branch>
```

- rename a branch

```bash
git branch -m <old> <new>
```

- delete a branch

```bash
git branch -d <branch_name>
```

### git switch

- switch branch

```bash
git switch <existing-branch>
```

- point head to hast commit

```raw
git switch -
```

### git reset - git revert

- git reset

```bash
git reset --soft <commit-id>
git reset --mixed <commit-id>
git reset --hard <commit-id>
```

- gti revert

```bash
git revert <commit-id>
```

Difference between `git reset` & `git revert`

![git-reset-revert-1]
![git-reset-revert-2]

### git tag

```bash
git tag -a v1.0 8489c03c1 -m "version 1.0 is released"
```

### git merge - git rebase

![git-merge-rebase-1]
![git-merge-rebase-2]

<!-- image links -->
[git-concept-1]: ../../assets/svc/git-3-level-concept-1.png
[git-concept-2]: ../../assets/svc/git-3-level-concept-2.png
[git-concept-3]: ../../assets/svc/git-3-level-concept-3.png
[git-concept-4]: ../../assets/svc/git-3-level-concept-4.png
[git-concept-5]: ../../assets/svc/git-3-level-concept-5.png
[git-pictorial]: ../../assets/svc/git-a-pictorial-walkthrough.gif
[git-workflow]: ../../assets/svc/git-a-pictorial-walkthrough.gif
[git-pull-fetch]: ../../assets/svc/git-pull-fetch.png
[git-reset-revert-1]: ../../assets/svc/git-reset-revert-1.png
[git-reset-revert-2]: ../../assets/svc/git-reset-revert-2.png
[git-merge-rebase-1]: ../../assets/svc/git-merge-rebase-1.png
[git-merge-rebase-2]: ../../assets/svc/git-merge-rebase-2.png
