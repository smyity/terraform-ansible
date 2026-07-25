# Важность

Что здесь происходит:
1. Создание ВМ в Yandex Cloud
2. Запуск **ansible playbook**
    - Установка Docker
    - Клонирование репозитория [приложения](https://github.com/smyity/application.git)
    - Запуск compose.yml

## Как это работает

Есть несколько способов создания ВМ в **Yandex Cloud**:

> [!IMPORTANT]
>
> Все переменные которые можно менять находятся в файле [terraform.tfvars](./terraform.tfvars).

1. **Через GitHub**.

    В данном репозитории есть специальный файл для указания нужного состояния ВМ - *necessary_state.txt*. В нем может быть написано:
    - `yes` - для создания ВМ
    - `no` - для удаления ВМ

    ❗ Для данного способа обязательно нужно создать секреты (если делается fork): **Settings** → **Secrets and variables** → **Actions** → **New repository secret**:
    - `A_KEY`   - access_key статического ключа
    - `S_KEY`   - secret_key статического ключа
    - `CH_USER` - имя пользователя для ClickHouse
    - `CH_PASS` - пароль пользователя для ClickHouse
    - `A_1`     - содержимое файла authorized_key
    - `SSH_KEY` - приватный SSH ключ

    При таком способе выполняя команду `git push origin`, в зависимости от желаемого состояния будут запускаться pipeline.

2. **Локально**.

    Клонирование репозитория:
    ```
    git clone https://github.com/smyity/terraform-ansible.git
    ```
    ❗ Для данного способа обязательно нужно задать переменные окружения в терминале:
    - `export AWS_ACCESS_KEY_ID="<<access_key>>"`            - access_key
    - `export AWS_SECRET_ACCESS_KEY="<<secret_key>>"`        - secret_key
    - `export clickhouse_username="<<clickhouse_username>>"` - имя пользователя ClickHouse
    - `export clickhouse_password="<<clickhouse_password>>"` - пароль для пользователя ClickHouse
    <br>
    </br>

    - В файле *main.tf* раскомментировать строку `service_account_key_file` в `provider "yandex"`

    После перехода в директорию проекта выполнить инициализацию:
    ```
    terraform init
    ```
    Создание ВМ:
    ```
    terraform apply -auto-approve
    ```
    Удаление ВМ:
    ```
    terraform destroy -auto-approve
    ```