Prerequisite
- [Docker](https://www.docker.com/products/docker-desktop) & [docker-compose](https://docs.docker.com/compose/)
- [traefik](https://gitlab.com/until-app/development/traefik)

1. Execute the `setup` script.

   ```bash
   ./setup
   ```

2. Internal hosts address for project. You need to edit your hosts file.

   Location for :

    - Windows : **`C:/Windows/System32/driver/etc/hosts`**
    - Linux and Mac : **`/etc/hosts`**

   Add this content :

    ```bash
    127.0.0.1       wordpress.untilapp.local
    ```

    <aside>
    ⚠️ If you want change any values, remember to change it in `.env` , variables finished by `_DOMAIN`
    </aside>
