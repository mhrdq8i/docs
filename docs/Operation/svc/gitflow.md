# GitFlow

```bash
# May branch `feature` off from
$ develop

# Must `feature` merge back into
$ develop

# Branch naming convention for `feature`
$ feature-\*

# May branch `release` off from
$ develop

# Must merge `release` back into
$ develop and master

# Branch naming convention for `release`
$ release-\*

# May branch `hotfix` off from
$ master

# Must merge `hotfix` back into
$ develop and master

# Branch naming convention for `hotfix`
$ hotfix-\*
```

## Creating a feature branch

![gitflow-feature](/docs/assets/svc/gitflow-feature.png)

## Creating a release branch

![gitflow-release](/docs/assets/svc/gitflow-release.png)

## Creating a Hotfix branch

![gitflow-hotfix](/docs/assets/svc/gitflow-hotfix.png)
