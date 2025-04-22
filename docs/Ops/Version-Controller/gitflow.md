# GitFlow

```bash
# May branch `feature` off from
develop

# Must `feature` merge back into
develop

# Branch naming convention for `feature`
feature-\*

# May branch `release` off from
develop

# Must merge `release` back into
develop and master

# Branch naming convention for `release`
release-\*

# May branch `hotfix` off from
master

# Must merge `hotfix` back into
develop and master

# Branch naming convention for `hotfix`
hotfix-\*
```

### Create feature/release/hotfix branchs

??? "Feature branch"

    ![gitflow-feature](../../assets/svc/gitflow-feature.png)

??? "Release Branch"

    ![gitflow-release](../../assets/svc/gitflow-release.png)

??? "Hotfix Branch"

    ![gitflow-hotfix](../../assets/svc/gitflow-hotfix.png)
