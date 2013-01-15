class advanced::proxy {
  class {'advanced::proxy::hostname':} ->
  class {'advanced::proxy::haproxy':} ->
  class {'advanced::irc::server':}
}
