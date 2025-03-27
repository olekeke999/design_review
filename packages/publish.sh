pushd design_review_devtools_extension

flutter pub get
dart run devtools_extensions build_and_copy --source=. --dest=../design_review/extension/devtools

popd

pushd design_review
flutter pub publish
popd