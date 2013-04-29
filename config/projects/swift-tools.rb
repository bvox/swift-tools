
name "swift-tools"
maintainer "Sergio Rubio <rubiojr@bvox.net>"
homepage "http://bvox.net"

replaces        "swift-tools"
install_path    "/opt/swift-tools"
#build_version   Omnibus::BuildVersion.new.semver
build_version   "0.0.1"
build_iteration 1

# creates required build directories
dependency "preparation"

# swift-tools dependencies/components
dependency "swift-tools"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
