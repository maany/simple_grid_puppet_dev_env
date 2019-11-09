# simple_grid_puppet_dev_kit

The dev-kit is used for developing and testing the SIMPLE Grid framework right from your desktop. 
It simulates a grid site by creates 3 containers (1 config master and 2 lightweight component nodes).
You can execute the simple-grid puppet module until the pre-deploy stage (which essentially covers all the steps a site admin has to perform in order to use the framework).

## Setup instructions

You must install docker (>18) and docker-compose on your development machine.

```
mkdir simple_grid
cd simple_grid
git clone https://github.com/maany/simple_grid_puppet_dev_kit/
git clone https://github.com/WLCG-Lightweight-Sites/simple_grid_puppet_module
cd simple_grid_puppet_dev_kit
docker-compose up
```
You should now have 3 containers with {container_name} basic_config_master, lightweight_component01 and lightweight_component02.

Get inside each of the containers using
```
docker exec -it {container_name} bash
```

and initiaize them by executing

```
/data/init.sh
```

You are all set for development.
