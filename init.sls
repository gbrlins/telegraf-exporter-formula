{% if salt['pillar.get']('telegraf_exporter:enabled', True) %}

{% if grains['os'] == 'Ubuntu' %}
  {% set id = 'ubuntu' %}
  {% set codename= grains['oscodename'] %}

{% elif grains['os'] == 'SUSE' %}
  {% set id = 'SUSE' %}
  {% set codename= grains['oscodename'] %}
{% endif %}


{% if grains['os'] == 'Ubuntu' %}
install-telegraf-ubuntu:
  pkgrepo.managed:
    - name: deb https://repos.influxdata.com/{{ id }} {{ codename }} stable
    - dist: {{ codename }}
    - file: /etc/apt/sources.list.d/influxdb.list
    - keyserver: https://repos.influxdata.com/influxdb.key

telegraf-ubuntu:
  pkg.installed:
    - fromrepo: {{ codename }}
    - pkgs:
      - telegraf

{% elif grains['os'] == 'SUSE' %}
install-telegraf-suse:
  pkg.installed:
    - fromrepo: obs://devel:languages:go/
    - skip_verify: True
    - skip_suggestions: True
    - refresh: True
    - pkgs:
      - telegraf 
{% endif  %}

create-file:
  file.managed:
    - name: /tmp/usb_activity.log

telegraf.service:
  service.running:
    - enable: True
    - reload: True

/etc/telegraf/telegraf.conf:
  file.managed:
    - source: salt://telegraf-exporter/files/telegraf.conf
    - name: /etc/telegraf/telegraf.conf
    - group: root
    - user: root    
    - mode: 644

{% else %}
{% endif %}
