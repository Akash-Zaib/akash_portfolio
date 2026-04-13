# akash_portfolio

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

For creating new build and movw to deployed branch
# 1) From your Flutter source branch
flutter build web --release --base-href=/akash_portfolio/

# 2) Copy fresh build to temp folder
mkdir C:\temp\akash_web_deploy -Force
xcopy .\build\web\* C:\temp\akash_web_deploy\ /E /H /C /I /Y

# 3) Clean branch-switch blockers
git stash -u

# 4) Switch to deployed branch
git switch gh-pages

# 5) Remove old deployed files but keep .git and CNAME if you use custom domain
Get-ChildItem -Force | Where-Object { $_.Name -ne '.git' -and $_.Name -ne 'CNAME' } | Remove-Item -Recurse -Force

# 6) Copy new build into gh-pages root
xcopy C:\temp\akash_web_deploy\* . /E /H /C /I /Y

# 7) Add .nojekyll
New-Item .nojekyll -ItemType File -Force

# 8) Commit and push
git add .
git commit -m "Deploy updated Flutter web build"
git push origin gh-pages

# 9) Go back to your source branch
git switch Analytics
git stash pop
