# A complete Logstash stack on [AWS OpsWorks](http://aws.amazon.com/opsworks/)

This is a bunch of cookbooks that will allow you to run a complete Logstash setup on a scalable
[AWS OpsWorks](http://aws.amazon.com/opsworks/) stack. At [Springest](http://www.springest.com)
we use it to ship from 250 to about 1k log entries per second, depending on the RPM on our 18 servers.

![kibana](http://springest-monosnap.s3-website-eu-west-1.amazonaws.com/2013_11_05_17_30_10_abrqo.jpg)
__A screenshot of [Kibana3](http://demo.kibana.org/), included in the cookbooks.__


## The stack's layers

![layers](http://springest-monosnap.s3-website-eu-west-1.amazonaws.com/2013_11_05_11_52_21_z5pt8.jpg)
__A screenshot of the layers in [AWS OpsWorks](http://aws.amazon.com/opsworks/)__

- A RabbitMQ cluster layer – Agents wil ship their logs to this cluster and the Logstash server cluster uses it as an input source.
- An ElasticSearch cluster layer – All log messages are stored and indexed here.
- A Logstash cluster layer – Takes the messages from the RabbitMQ fanout and puts them into ElasticSearch.
- A Kibana server - An Angular.js interface on top of ElasticSearch to search, graph etc.

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
