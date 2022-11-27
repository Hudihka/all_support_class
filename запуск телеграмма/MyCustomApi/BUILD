load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MyCustomApi",
    module_name = "MyCustomApi",
    srcs = glob([
        "Sources/**/*.swift"
    ]),
    copts = [
        "-warnings-as-errors"
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit"
    ],
    visibility = [
        "//visibility:public"
    ],
)
