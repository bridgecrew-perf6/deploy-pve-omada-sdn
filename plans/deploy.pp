# Deploy Omada SDN Controller
plan omada_sdn::deploy (
  TargetSpec $targets
) {
  $terraform_result = run_task(
    'terraform::apply',
    'localhost',
    dir => './terraform'
  )

  apply_prep($targets)

  $apply_result = apply($targets, _catch_errors => true, _run_as => root) {
    $unneeded_packages = [
      'ubuntu-standard',
      'usbutils',
      'bind9-libs',
      'cpp', 'cpp-9',
      'dmidecode',
      'dosfstools',
      'irqbalance',
      'libdrm-common',
      'libllvm12', 'libxcb-shm0', 'libxcb-xfixes0',
      'libice6', 'libmaxminddb0',
      'xinit',
      'xauth',
      'x11-common',
      'libx11-data',
      'libx11-xcb1',
      'ntfs-3g',
      'libxcb1', 'libxshmfence1',
      'libxau6',
    ]
    package { $unneeded_packages:
      ensure => absent
    }
    -> class { 'unattended_upgrades':
      auto                   => {
        reboot => true,
        clean  => 7,
        remove => true,
      },
      extra_origins          => [
        '${distro_id}:${distro_codename}-updates',
      ],
      remove_new_unused_deps => true,
      syslog_enable          => true,
      days                   => ["0", "1", "2", "3", "4", "5", "6"],
    }
    -> file { '/etc/rsyslog.d/listen.conf':
      ensure  => present,
      notify  => Exec['restart-rsyslog'],
      content => @(EOD)
        module(load="imudp")
        input(type="imudp" port="514")
        module(load="imtcp")
        input(type="imtcp" port="514")
        | EOD
    }
    -> class { 'java':
      distribution => 'jre',
    }
    -> package { 'jsvc': }
    -> file { '/usr/lib/jvm/java-11-openjdk-amd64/lib/amd64/':
      ensure => directory,
    }
    -> file { '/usr/lib/jvm/java-11-openjdk-amd64/lib/amd64/server':
      ensure => link,
      target => '../server',
    }
    file { '/usr/share/keyrings/mongodb-44-keyring.asc':
      ensure => present,
      source => 'https://www.mongodb.org/static/pgp/server-4.4.asc',
      notify => Exec['mongodb-apt-update'],
    }
    -> file { '/etc/apt/sources.list.d/mongodb.list':
      content => @(EOD)
        # Managed by Puppet
        deb [signed-by=/usr/share/keyrings/mongodb-44-keyring.asc arch=amd64,arm64] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse 
        | EOD
    }
    ~> exec { 'mongodb-apt-update':
      command     => '/usr/bin/env apt-get -d update',
      refreshonly => true,
    }
    -> package { 'mongodb-org': }
    -> package { 'curl': }
    -> file { '/var/tmp/omada_sdn_controller_v5.deb':
      ensure         => present,
      source         => 'https://static.tp-link.com/upload/software/2022/202201/20220120/Omada_SDN_Controller_v5.0.30_linux_x64.deb',
      checksum_value => '92abc1274d580e631c71b60e79afd8b08be65ca5387c625eea1a040cbaee0ccf',
    }
    -> package { 'omadac':
      provider => dpkg,
      ensure   => installed,
      source   => '/var/tmp/omada_sdn_controller_v5.deb',
    }

    exec { 'restart-rsyslog':
      command     => '/usr/bin/env systemctl restart rsyslog',
      refreshonly => true,
    }
  }
  return $apply_result
}
