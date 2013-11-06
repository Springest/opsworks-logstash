# A complete Logstash stack on [AWS OpsWorks](http://aws.amazon.com/opsworks/)

__UPDATE__: I wrote a [blog post](http://devblog.springest.com/complete-logstash-stack-on-aws-opsworks-in-15-minutes/) that will help you set this up.

This is a bunch of cookbooks that will allow you to run a complete Logstash setup on a scalable
[AWS OpsWorks](http://aws.amazon.com/opsworks/) stack. At [Springest](http://www.springest.com)
we use it to ship from 250 to about 1k log entries per second, depending on the RPM on our 18 servers.

![kibana](http://springest-monosnap.s3-website-eu-west-1.amazonaws.com/2013_11_05_17_30_10_abrqo.jpg)
__A screenshot of [Kibana3](http://demo.kibana.org/), included in the cookbooks.__


## The stack's layers

![layers](http://springest-monosnap.s3-website-eu-west-1.amazonaws.com/2013_11_05_11_52_21_z5pt8.jpg)
__A screenshot of the layers in [AWS OpsWorks](http://aws.amazon.com/opsworks/)__

- A RabbitMQ cluster layer (Ubuntu) – Agents wil ship their logs to this cluster and the Logstash server cluster uses it as an input source.
- An ElasticSearch cluster layer (Amazon Linux) – All log messages are stored and indexed here.
- A LogStash cluster layer (Ubuntu) – Takes the messages from the RabbitMQ fanout and puts them into ElasticSearch.
- A Kibana server (Ubuntu) - An Angular.js interface on top of ElasticSearch to search, graph etc.

## Setting up your stack

- Set `git://github.com/Springest/opsworks-logstash.git` as a repository URL for your custom cookbooks.
- Use the following Chef custom JSON:

```json
{
    "chef_environment": "production",
    "elasticsearch": {
        "cluster": {
            "name": "logstash"
        },
        "basic_auth": {
            "user": "<es username here>",
            "password": "<es password here>"
        }
    },
    "rabbitmq": {
        "cluster": true,
        "erlang_cookie": "<any random alphanumeric string will do>"
    },
    "rabbitmq_cluster": {
        "user": "<rabbitmq username here>",
        "password": "<rabbitmq password here>"
    },
    "kibana": {
        "webserver": "nginx",
        "webserver_hostname": "<your kibana domain, eg: kibana.example.com>",
        "web_user": "<kibana username here>",
        "web_password": "<kibana password here>",
        "es_port": "9200",
        "es_role": "elasticsearch",
        "es_server": "<es loadbalancer address here>",
        "es_user": "<es username here>",
        "es_password": "<es password here>"
    },
    "logstash": {
        "elasticsearch_cluster": "logstash",
        "server": {
            "install_rabbitmq": false,
            "enable_embedded_es": false,
            "elasticsearch_role": "elasticsearch",
            "inputs": [
                {
                    "rabbitmq": {
                        "exchange": "rawlogs",
                        "user": "<rabbitmq username here>",
                        "password": "<rabbitmq password here>",
                        "host": "<IP or LB address of your rabbitmq server/cluster>",
                        "type": "all"
                    }
                }
            ]
        }
    }
}
```

### Configure Custom Chef recipes

#### ElasticSearch

![elasticsearch recipes](http://springest-monosnap.s3-website-eu-west-1.amazonaws.com/2013_11_05_17_21_21_u1qo0.jpg)

#### Kibana

![kibana recipes](http://springest-monosnap.s3-website-eu-west-1.amazonaws.com/2013_11_05_17_22_50_e2bpa.jpg)

#### Logstash

![logstash recipes](http://springest-monosnap.s3-website-eu-west-1.amazonaws.com/2013_11_05_17_24_04_poohu.jpg)

#### RabbitMQ

![rabbitmq recipes](http://springest-monosnap.s3-website-eu-west-1.amazonaws.com/2013_11_05_17_24_45_iojw0.jpg)

## Contribute

- Fork the project
- Create a feature branch
- Fix the code
- Create a pull request

## Thanks to

All of these people have made our lives a little better by writing great
software.

The contributors at these projects:

- [ElasticSearch](http://elasticsearch.com/) for their awesome search
  engine.
- [Kibana](http://www.elasticsearch.org/overview/kibana/) for a
  beautiful graphing tool.
- [LogStash](http://logstash.net/) for bringing our logs together.
- [RabbitMQ](http://www.rabbitmq.com/) for a robust message broker.

And the people who wrote these cookbooks:

- [@lusis](https://github.com/lusis) for his work on the [Kibana cookbook](https://github.com/foxycoder/chef-kibana) and the [LogStash cookbook](https://github.com/foxycoder/chef-logstash)
- [@karmi](https://github.com/foxycoder/cookbook-elasticsearch) for the original, and [@ehlertij](https://github.com/ehlertij), [@tkawa](https://github.com/tkawa), and [@interu](https://github.com/interu) for their efforts on the [ElasticSearch cookbook for OpsWorks](https://github.com/sportngin/cookbook-elasticsearch).
- [@brianbianco](https://github.com/brianbianco) for his [Redis cookbook](https://github.com/brianbianco/redisio)
- [@sethvargo](https://github.com/sethvargo) for the [hostsfile cookbook](https://github.com/customink-webops/hostsfile)
- [@ddux](https://github.com/ddux) for the [rbenv cookbook](https://github.com/ddux/rbenv-cookbook)
- [@bryanwb](https://github.com/bryanwb) for the [Yumrepo cookbook](https://github.com/bryanwb/cookbook-yumrepo)
- [@guilhem](https://github.com/guilhem) for his efforts on the [Htpaswd cookbook](https://github.com/Youscribe/htpasswd-cookbook)

And the guys at [Opscode](http://www.opscode.com/chef/) and their
contributors for Chef and cookbooks like:

- [RabbitMQ](https://github.com/opscode-cookbooks/rabbitmq)
- [Java](https://github.com/opscode-cookbooks/java)
- [Apt](https://github.com/opscode-cookbooks/apt)
- [Erlang](https://github.com/opscode-cookbooks/erlang)
- [Nginx](https://github.com/opscode-cookbooks/nginx)
- [NTP](https://github.com/opscode-cookbooks/ntp)
- [Runit](https://github.com/opscode-cookbooks/runit)
- [Ant](https://github.com/opscode-cookbooks/ant)
- [Apache2](https://github.com/opscode-cookbooks/apache2)
- [Ark](https://github.com/opscode-cookbooks/ark)
- [AWS](https://github.com/opscode-cookbooks/aws)
- [Build-essential](https://github.com/opscode-cookbooks/build-essential)
- [Chef handler](https://github.com/opscode-cookbooks/chef_handler)
- [Git](https://github.com/opscode-cookbooks/git)
- [Ohai](https://github.com/opscode-cookbooks/ohai)
- [OpenSSL](https://github.com/opscode-cookbooks/openssl)
- [Perl](https://github.com/opscode-cookbooks/perl)
- [Python](https://github.com/opscode-cookbooks/python)
- [Windows](https://github.com/opscode-cookbooks/windows)
- [xfs](https://github.com/opscode-cookbooks/xfs)
- [xml](https://github.com/opscode-cookbooks/xml)
- [yum](https://github.com/opscode-cookbooks/yum)
- [rsyslog](https://github.com/opscode-cookbooks/rsyslog)

And last but not least:

- [Amazon AWS](http://aws.amazon.com)

