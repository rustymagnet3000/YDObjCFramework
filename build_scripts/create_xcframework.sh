# set framework folder name

if [ "true" == ${ALREADYINVOKED:-false} ]
then
echo "warning: Recusion detected, stopping."
else
export ALREADYINVOKED="true"

echo "[*]Creating XCFramework"

FRAMEWORK_FOLDER_NAME="${TARGETNAME}_XCFramework"
FRAMEWORK_NAME="${TARGETNAME}"
SCHEME="YDAliceSDK-iOS"
FRAMEWORK_PATH="${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}/${FRAMEWORK_NAME}.xcframework"
SIMULATOR_ARCHIVE_PATH="${TARGETNAME}/${FRAMEWORK_FOLDER_NAME}/simulator.xcarchive"
IOS_DEVICE_ARCHIVE_PATH="${TARGETNAME}/${FRAMEWORK_FOLDER_NAME}/iOS.xcarchive"

# Remove the xcframework, if it already existed on the desktop
rm -rf "${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}"
echo "Deleted ${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}"

# Create archive files for iOS and iOS simulators
xcodebuild archive -scheme ${SCHEME} \
 -destination="iOS Simulator" \
 -archivePath "${SIMULATOR_ARCHIVE_PATH}" \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO \
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

xcodebuild archive -scheme ${SCHEME} \
 -destination="iOS Simulator" \
 -archivePath "${IOS_DEVICE_ARCHIVE_PATH}" \
 -sdk iphoneos \
 SKIP_INSTALL=NO \
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

# Create framework on Desktop. Takes source archive files from local repo
xcodebuild -create-xcframework  \
 -framework ${SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
 -framework ${IOS_DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
 -output "${FRAMEWORK_PATH}"
 
rm -rf "${SIMULATOR_ARCHIVE_PATH}"
rm -rf "${IOS_DEVICE_ARCHIVE_PATH}"

# Remove the archives, that are no longer required
rm -rf "${IOS_DEVICE_ARCHIVE_PATH}"

# Open final framework
open "${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}"

fi