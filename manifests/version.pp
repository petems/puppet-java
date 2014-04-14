# Public: Install a java version
#
# Usage:
#
# java::version { 'v7u51' :
#     version => '7u51',
#     jdk_dirname => 'jdk1.7.0_51.jdk',
# }
#
define java::version (
  $version,
  $jdk_dirname,
) {
  java { $version:
    version      => $version,
    jdk_dirname  => $jdk_dirname
  }
}
