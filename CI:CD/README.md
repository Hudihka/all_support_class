информация была в зята с https://medium.com/@naman.mittal/automate-ios-deployment-process-by-ci-cd-using-gitlab-ci-and-fastlane-547d824ee41a

если не получается собрать из за ssl сертификата, попробуй команду 
git config --global http.sslVerify true
не забудь потом поставить фолз

# это был дефолтный
 stages:
   - build
   - test
   - archive
   - deploy

 build_project:
   stage: build
   script:
     - xcodebuild clean -project ProjectName.xcodeproj -scheme SchemeName | xcpretty
     - xcodebuild test -project ProjectName.xcodeproj -scheme SchemeName -destination 'platform=iOS Simulator,name=iPhone 8,OS=11.3' | xcpretty -s
   tags:
     - ios_11-3
     - xcode_9-3
     - macos_10-13

 archive_project:
   stage: archive
   script:
     - xcodebuild clean archive -archivePath build/ProjectName -scheme SchemeName
     - xcodebuild -exportArchive -exportFormat ipa -archivePath "build/ProjectName.xcarchive" -exportPath "build/ProjectName.ipa" -exportProvisioningProfile "ProvisioningProfileName"
   rules:
     - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
   artifacts:
     paths:
       - build/ProjectName.ipa
   tags:
     - ios_11-3
     - xcode_9-3
     - macos_10-13

 deploy:
   stage: deploy
   script: echo "Define your deployment script!"
   environment: production
