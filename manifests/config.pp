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
  
  group { $users::zonza_projects_group_name:
    ensure => 'present',
    gid    => $users::zonza_projects_group_id,
  }

  user { $users::zonza_projects_user_name:
    ensure     => 'present',
    uid        => $users::zonza_projects_user_id,
    gid        => $users::zonza_projects_group_name,
    managehome => true,
  }
  
  file { '/var/log/hogarth/':
    ensure  => 'directory',
    recurse => true,
    owner   => $users::zonza_projects_user_name,
    require => User[$users::zonza_projects_user_name],
  }
}

