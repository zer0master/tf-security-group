
# protocols can be named (tcp, udp, icmp, all), or numbers (all: -1, IPV4-ICMP: 1, TCP: 6, UDP: 17, IPV6-ICMP: 58)
# refer to https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml

variable "rules" {
  #NOTE: cidr blocks are defined in resource(s) because flexibility...
  description = "ingress/egress rule mappings: 'name' = ['from port', 'to port', 'protocol', 'description']"
  type        = map(list(any))

  #ref: https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf
  # will be updated as needed
  default = {
    consul-tcp                        = [8300, 8300, "tcp", "Consul server"]
    consul-cli-rpc-tcp                = [8400, 8400, "tcp", "Consul CLI RPC"]
    consul-webui-tcp                  = [8500, 8500, "tcp", "Consul web UI"]
    consul-dns-tcp                    = [8600, 8600, "tcp", "Consul DNS"]
    consul-dns-udp                    = [8600, 8600, "udp", "Consul DNS"]
    consul-serf-lan-tcp               = [8301, 8301, "tcp", "Serf LAN"]
    consul-serf-lan-udp               = [8301, 8301, "udp", "Serf LAN"]
    consul-serf-wan-tcp               = [8302, 8302, "tcp", "Serf WAN"]
    consul-serf-wan-udp               = [8302, 8302, "udp", "Serf WAN"]

    docker-swarm-mngmt-tcp            = [2377, 2377, "tcp", "Docker Swarm cluster management"]
    docker-swarm-node-tcp             = [7946, 7946, "tcp", "Docker Swarm node"]
    docker-swarm-node-udp             = [7946, 7946, "udp", "Docker Swarm node"]
    docker-swarm-overlay-udp          = [4789, 4789, "udp", "Docker Swarm Overlay Network Traffic"]

    dns-udp                           = [53, 53, "udp", "DNS"]
    dns-tcp                           = [53, 53, "tcp", "DNS"]

    ntp-udp                           = [123, 123, "udp", "NTP"]

    elasticsearch-rest-tcp            = [9200, 9200, "tcp", "Elasticsearch REST interface"]
    elasticsearch-java-tcp            = [9300, 9300, "tcp", "Elasticsearch Java interface"]

    grafana-tcp                       = [3000, 3000, "tcp", "Grafana Dashboard"]

    graphite-webui                    = [80, 80, "tcp", "Graphite admin interface"]
    graphite-2003-tcp                 = [2003, 2003, "tcp", "Carbon receiver plain text"]
    graphite-2004-tcp                 = [2004, 2004, "tcp", "Carbon receiver pickle"]
    graphite-2023-tcp                 = [2023, 2023, "tcp", "Carbon aggregator plaintext"]
    graphite-2024-tcp                 = [2024, 2024, "tcp", "Carbon aggregator pickle"]
    graphite-8080-tcp                 = [8080, 8080, "tcp", "Graphite gunicorn port"]
    graphite-8125-tcp                 = [8125, 8125, "tcp", "Statsd TCP"]
    graphite-8125-udp                 = [8125, 8125, "udp", "Statsd UDP default"]
    graphite-8126-tcp                 = [8126, 8126, "tcp", "Statsd admin"]

    http-80-tcp                       = [80, 80, "tcp", "HTTP"]
    http-8080-tcp                     = [8080, 8080, "tcp", "HTTP"]

    https-443-tcp                     = [443, 443, "tcp", "HTTPS"]
    https-8443-tcp                    = [8443, 8443, "tcp", "HTTPS"]

    kubernetes-api-tcp                = [6443, 6443, "tcp", "Kubernetes API Server"]

    postgresql-tcp                    = [5432, 5432, "tcp", "PostgreSQL"]

    prometheus-http-tcp               = [9090, 9090, "tcp", "Prometheus"]
    prometheus-pushgateway-http-tcp   = [9091, 9091, "tcp", "Prometheus Pushgateway"]

    ssh-tcp                           = [22, 22, "tcp", "SSH"]

    all-all                           = [-1, -1, "-1", "All protocols"]
    all-tcp                           = [0, 65535, "tcp", "All TCP ports"]
    all-udp                           = [0, 65535, "udp", "All UDP ports"]
    all-icmp                          = [-1, -1, "icmp", "All IPV4 ICMP"]
    all-ipv6-icmp                     = [-1, -1, 58, "All IPV6 ICMP"]

    _                                 = ["", "", ""]
    # lookup() default: should never be used in practice
  }
}
