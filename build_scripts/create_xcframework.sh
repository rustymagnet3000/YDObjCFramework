# set framework folder name

if [ "true" == ${ALREADYINVOKED:-false} ]
then
echo "RECURSION: Detected, stopping"
else
export ALREADYINVOKED="true"

echo "[*] Creating XCFramework"



FRAMEWORK_FOLDER_NAME="${TARGETNAME}_XCFramework"
FRAMEWORK_NAME="${TARGETNAME}"
SCHEME="YDAliceSDK-iOS"
FRAMEWORK_PATH="${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}/${FRAMEWORK_NAME}.xcframework"
SIMULATOR_ARCHIVE_PATH="${TARGETNAME}/${FRAMEWORK_FOLDER_NAME}/simulator.xcarchive"
IOS_DEVICE_ARCHIVE_PATH="${TARGETNAME}/${FRAMEWORK_FOLDER_NAME}/iOS.xcarchive"

echo ${FRAMEWORK_NAME}
echo ${FRAMEWORK_PATH}
echo ${SIMULATOR_ARCHIVE_PATH}
echo ${IOS_DEVICE_ARCHIVE_PATH}

rm -rf "${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}/${FRAMEWORK_FOLDER_NAME}"
echo "Deleted ${FRAMEWORK_FOLDER_NAME}"

mkdir "${FRAMEWORK_FOLDER_NAME}"
echo "Created ${FRAMEWORK_FOLDER_NAME}"
echo "Archiving ${FRAMEWORK_NAME}"
echo "SIMULATOR_ARCHIVE_PATH= ${SIMULATOR_ARCHIVE_PATH}"

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

 
fi