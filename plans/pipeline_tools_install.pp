plan puppet_pipeline_builder::pipeline_tools_install(
  TargetSpec  $nodes,
) {
  # Install the puppet-agent package if Puppet is not detected.
  # Copy over custom facts from the Bolt modulepath.
  # Run the `facter` command line tool to gather node information.
  $nodes.apply_prep
    # Compile the manifest block into a catalog
    apply($nodes) {
      class { 'java':
        distribution => 'jdk',
      }

      # file { '/opt/apache-maven/conf/settings.xml':
      #   ensure  => file,
      #   content => $maven_settings,
      # }

      class { 'docker': }

      class { '::ius': }

      # class { 'pipelines::agent':
      #   access_token => Sensitive($agent_token),
      #   secret_key   => Sensitive($agent_key),
      # }

      package { 'wget':
        ensure => present,
      }

      package { 'git':
        ensure => installed,
      }

      user { 'distelli':
        groups => ['docker'],
      }
    }

    # Install maven
    run_task('puppet_pipeline_builder::maven_install', $nodes)
}
