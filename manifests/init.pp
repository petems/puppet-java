# Public: installs java jre-7u51 and JCE unlimited key size policy files
#
# Examples
#
# include java
#
define java(
  $version,
  $jdk_dirname,
  $base_download_url = 'https://s3.amazonaws.com/boxen-downloads/java'
) {
  include boxen::config

  $jre_url = "${base_download_url}/jre-${version}-macosx-x64.dmg"
  $jdk_url = "${base_download_url}/jdk-${version}-macosx-x64.dmg"
  $wrapper = "${boxen::config::bindir}/java"
  $jdk_dir = "/Library/Java/JavaVirtualMachines/${jdk_dirname}"
  $sec_dir = "${jdk_dir}/Contents/Home/jre/lib/security"

  package {
    "jre-${version}.dmg":
      ensure   => present,
      alias    => 'java-jre',
      provider => pkgdmg,
      source   => $jre_url ;
    "jdk-${version}.dmg":
      ensure   => present,
      alias    => 'java',
      provider => pkgdmg,
      source   => $jdk_url ;
  }

  file { $wrapper:
    source  => 'puppet:///modules/java/java.sh',
    mode    => '0755',
    require => Package['java']
  }


  # Allow 'large' keys locally.
  # http://www.ngs.ac.uk/tools/jcepolicyfiles

  file { $sec_dir:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'wheel',
    mode    => '0775',
    require => Package['java']
  }

  file { "${sec_dir}/local_policy.jar":
    source  => 'puppet:///modules/java/local_policy.jar',
    owner   => 'root',
    group   => 'wheel',
    mode    => '0664',
    require => File[$sec_dir]
  }

  file { "${sec_dir}/US_export_policy.jar":
    source  => 'puppet:///modules/java/US_export_policy.jar',
    owner   => 'root',
    group   => 'wheel',
    mode    => '0664',
    require => File[$sec_dir]
  }
}
