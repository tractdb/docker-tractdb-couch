import configparser
import yaml

if __name__ == '__main__':
    local = configparser.ConfigParser()
    local.read('/tmp/local.ini')

    with open('/secrets/tractdbcouch.yml') as f:
        tractdbcouch = yaml.load(f)

    user = tractdbcouch['admin']['user']
    password = tractdbcouch['admin']['password']

    local['admins'] = {}
    local['admins'][user] = password

    with open('/etc/couchdb/local.ini', 'w') as f:
        local.write(f)
