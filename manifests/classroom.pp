class advanced::classroom {
  include pe_mcollective
  # These are the files that we manage with this class
  $managed_files = [
    '/etc/puppetlabs/puppet/auth.conf',
    '/etc/puppetlabs/puppet/manifests/site.pp',
  ]

  class {'advanced::classroom::hostname':} ->
  class {'advanced::classroom::puppetdb':} ->
  class {'advanced::mcollective':} ->
  class {'advanced::irc::client':}

  # Backup and create default file then don't replace
  advanced::backup   { $managed_files :} ->
  advanced::template { $managed_files :
    replace_file => false,
  }
  file { '/etc/puppetlabs/puppet/.mcollective_advanced_class':
    mode   => '666',
    source => '/var/lib/peadmin/.mcollective',
  }


  # Enable autosigning to simplify exercises
  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure  => file,
    content => template("${module_name}/etc/puppetlabs/puppet/autosign.conf.erb"),
  }
}
