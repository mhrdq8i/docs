# # Stack.Push(GitFlow Doc\)

## [Creating a feature branch](#creating-a-feature-branch)

![git-flow-feature]

### May branch `feature` off from

- develop

### Must `feature` merge back into

- develop

### Branch naming convention for `feature`

- feature-\*

## [Creating a release branch](#creating-a-release-branch)

![git-flow-release]

### May branch `release` off from

- develop

### Must merge `release` back into

- develop and master

### Branch naming convention for `release`

- release-\*

## [Creating a Hotfix branch](#creating-a-hotfix-branch)

![git-flow-hotfix]

### May branch `hotfix` off from

- master

### Must merge `hotfix` back into

- develop and master

### Branch naming convention for `hotfix`

- hotfix-\*

<!-- image links -->

[git-flow-feature]: ../../assets/ops/svc/git-flow-feature.png
[git-flow-release]: ../../assets/ops/svc/git-flow-release.png
[git-flow-hotfix]: ../../assets/ops//svc/git-flow-hotfix.png
