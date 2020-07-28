#!/bin/bash

set -e
if [ $# = 0 ]; then
	echo "You should input project name."
fi

mkdir $1
cd $1

# Generate README.md
cat > README.md <<- END
### How to run project?
- mvn clean install
- java -jar target/snapshotName.jar

### What is required?
- Java 8+
- Maven
END
# Generate maven folder structure
mkdir -p src/{main/{java/pl/matsyposz/$1,resources},test/java/pl/matsyposz/$1}
# Generate .gitignore
curl https://www.toptal.com/developers/gitignore/api/vim,java,intellij+all,eclipse,maven,macos > .gitignore
# Generate pom.xml
curl https://raw.githubusercontent.com/matsyposz/standardPom/master/pom.xml | gsed {s/#APP/$1/g} | gsed {s/#NAME/$1/g} | gsed {s/#DESC/DescriptionHere/g} > pom.xml
# Generate App.java
cat > src/main/java/pl/matsyposz/$1/App.java <<- END
package pl.matsyposz.$1;

public class App {

    public static void main(String[] args) {}
}
END
# Generate AppTest.java
cat > src/test/java/pl/matsyposz/$1/AppTest.java <<- END
package pl.matsyposz.$1;

public class AppTest {}
END

git init
git add .
git commit -m "git init"
git checkout -b dev
