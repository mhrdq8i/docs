# GitFlow doc

## [Creating a feature branch](#creating-a-feature-branch)

<img src="../../assets/cicd/svc/git-flow-feature.png" width="30%" height="30%" >

### May branch `feature` off from

- develop

### Must `feature` merge back into

- develop

### Branch naming convention for `feature`

- feature-\*

## [Creating a release branch](#creating-a-release-branch)

<img src="../../assets/cicd/svc/git-flow-release.png" width="50%" height="50%" >

### May branch `release` off from

- develop

### Must merge `release` back into

- develop and master

### Branch naming convention for `release`

- release-\*

## [Creating a Hotfix branch](#hotfix-branches)

<img src="../../assets/cicd/svc/git-flow-hotfix.png" width="30%" height="30%" >

### May branch `hotfix` off from

- master

### Must merge `hotfix` back into

- develop and master

### Branch naming convention for `hotfix`

- hotfix-\*
