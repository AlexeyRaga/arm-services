# arm-services
SystemD services for arm cluster (consul, registrator, etc)

#### Install and use

    git clone https://github.com/AlexeyRaga/arm-services
    cd arm-services
    ./install.sh

Services will be created and enabled, _ready to start_, but **not** started automatically.

:exclamation: Don't forget to bootstrap consul cluster!

#### Bootstrapping

Consul cluster needs to be bootstrapped before it can be used as a service.
To help with this process there are two scripts included: `bootstrap-leader.sh` and `bootstrap-join.sh`.
They can be used as:

    # on a "current leader" machine
    ./bootstrap-leader.sh -join 192.168.1.151 -join 192.168.1.152 -join 192.168.1.153 -join 192.168.1.154
    
    #on all the other machines
    ./bootstrap-join.sh -join 192.168.1.151 -join 192.168.1.152 -join 192.168.1.153 -join 192.168.1.154

Obviously use your IP addresses in `-join` parameter, and use as many machines as you want to join the cluster :)

It does not matter whoch machine you choose as "leader" while bootstrapping, the `consul` specifics is that there should be one. After all the machines join the cluster just shop consul containers:

    docker stop consul
    
and the services can be started as usual

    systemctl start consul
    systemctl start registrator

#### Disclaimer

The services are `enabled` in `systemd` so they should be starting on boot, but it doesn't happen and due to my lack of experience with `systemd` I cannot tell why. 
`systemctl is-enabled consul; echo $?` tells me that the service is enabled, yet it does not automatically start :(

The consul UI can be found at **http://[your-ip]:8500/ui**
