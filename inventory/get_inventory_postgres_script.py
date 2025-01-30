#!/usr/bin/env python

# Description: Python script to connect to a PostgreSQL database and retrieve inventory data

import sys
import psycopg2
from psycopg2 import Error
import os
import json
import hvac

class PostgresInventory:
    """ Class to connect to a PostgreSQL database and retrieve inventory data """
    def __init__(self, db_host, db_port, db_name, db_user, db_password):
        self.db_host = db_host
        self.db_port = db_port
        self.db_name = db_name
        self.db_user = db_user
        self.db_password = db_password

    def __enter__(self):
        self.connect()
        return self
    
    def connect(self):
        try:
            self.connection = psycopg2.connect(
                user = self.db_user,
                password = self.db_password,
                host = self.db_host,
                port = self.db_port,
                database = self.db_name
            )
            # print("Connected to the database")
        except (Exception, Error) as error:
            print("Error while connecting to PostgreSQL", error)
            raise
            exit(1)
            
    def get_inventory(self, db_table):
        cursor = self.connection.cursor()
        cursor.execute(f"SELECT * FROM {db_table}")
        records = cursor.fetchall()
        return records
    
    def __exit__(self, exc_type, exc_value, exc_traceback):
        self.connection.close()
        # print("Connection closed")

def main():
    # Create a Vault client
    vault_url = os.getenv('VAULT_ADDR')
    vault_token = os.getenv('VAULT_TOKEN')
    vault_client = hvac.Client(url=vault_url, token=vault_token)

    # Retrieve a secret for the database password
    db_password_secret = vault_client.secrets.kv.v1.read_secret(path="ssh/ansible", mount_point='secret')

    # Base structure required by Ansible for dynamic inventory
    inventory_dict = {
        "_meta": {
            "hostvars": {}
        },
        "all": {
            "children": ["ungrouped"]
        },
        "ungrouped": {
            "hosts": []
        }
    }
    
    db_params = {
        "db_host": "homenas.local.lan",
        "db_port": "5432",
        "db_name": "homelab_cmdb",
        "db_user": "homelab_cmdb",
        "db_password": db_password_secret['data']['ssh_password']
    }
    
    with PostgresInventory(**db_params) as inventory:
        records = inventory.get_inventory("servers")
        # json_output = inventory.convert_to_json(records)
        # print(json_output)
        for row in records:
            # print(f"Getting info for {row[4]}")
            server_name = row[0]
            os_ver = row[1]
            hardware_type = row[2]
            env = row[3]
            server_fqdn = row[4]
            ip_address = row[5]
            os_family = row[6]
            
            if os_family == "RedHat" or os_family == "Debian":
                ansible_user = "ansible"
            elif os_family == "Windows" and "homelab.local" in server_fqdn:
                ansible_user = "ansible@HOMELAB.LOCAL"
            elif os_family == "Windows" and "local.lan" in server_fqdn:
                ansible_user = "ansible"
            else:
                print(f"Unknown OS family for {server_fqdn}")
                quit()
                            
            if os_family not in inventory_dict:
                inventory_dict[os_family] = {
                    "hosts": []
                }
                inventory_dict["all"]["children"].append(os_family)
                
            inventory_dict[os_family]["hosts"].append(server_fqdn)
            inventory_dict["_meta"]["hostvars"][server_fqdn] = {
                "ansible_host": ip_address,
                "os": os_ver,
                "hardware_type": hardware_type,
                "env": env,
                "ansible_user": ansible_user
            }
    # Handle Ansible inventory protocol
    if len(sys.argv) == 2 and sys.argv[1] == '--list':
        # inventory = get_inventory()
        print(json.dumps(inventory_dict, indent=2))
    elif len(sys.argv) == 3 and sys.argv[1] == '--host':
        # Return empty dict for specific host (Ansible will get vars from _meta)
        print(json.dumps({}))
    else:
        print("Usage: %s --list or --host <hostname>" % sys.argv[0])
        sys.exit(1)
        
if __name__ == "__main__":
    main()
