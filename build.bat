hugo -b https://bartimus-primed.github.io/container_course -d docs
cd docs
git add .
git commit -m "build"
git push
cd ..