# see README.md
class users::config {

    group { $users::admins_group_name:
    ensure => present,
    gid    => $users::admins_group_id,
  }
  $admins_user_defaults = {
    shell      => '/bin/bash',
    managehome => true,
    system     => false,
    gid        => $users::admins_group_id,
    groups     => $admins_groups,
  }

  create_resources('user', $users::admins_users, $admins_user_defaults)

  $key_defaults = {
    'type' => 'ssh-rsa',
  }

  create_resources('ssh_authorized_key', $users::admins_ssh_keys, $key_defaults)
  
  group { $users::app_group_name:
    ensure => 'present',
    gid    => $users::app_group_id,
  }

  user { $users::app_user_name:
    ensure     => 'present',
    uid        => $users::app_user_id,
    gid        => $users::app_group_name,
    managehome => true,
    require    => Group[$users::app_group_name],
  }
  
  file { '/var/log/app/':
    ensure  => 'directory',
    recurse => true,
    owner   => $users::app_user_name,
    group   => $users::app_group_name,
    mode    => '1775',
    require => User[$users::app_user_name],
  }
  
  logrotate::rule { 'app':
    create_owner => root,
    create_group => root,
    path         => /var/log/app/*.log,
    compress     => true,
    copytruncate => true,
    rotate       => 28,
    rotate_every => day,
    missingok    => true,
    create       => true,
    create_mode  => 664,
  }
}
