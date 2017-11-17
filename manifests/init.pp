# See README.md
class users (
  $admins_group_id        = hiera('users_admins_group_id',           $users::params::admins_group_id),
  $admins_group_name      = hiera('users_admins_group_name',         $users::params::admins_group_name),
  $admins_ssh_keys        = hiera_hash('users::admins_ssh_keys',    $users::params::admins_ssh_keys),
  $admins_users           = hiera_hash('users::admins_users',       $users::params::admins_users),

) inherits users::params {

  anchor { 'users::begin' : } ->
    class  { '::users::config'  : } ->
  anchor { 'users::end'   : }

}
