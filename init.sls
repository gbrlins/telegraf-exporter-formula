{% if salt['pillar.get']('telegraf_exporter:enabled', True) %}

{% if grains['os'] == 'Ubuntu' %}
  {% set id = 'ubuntu' %}
  {% set codename= grains['oscodename'] %}

{% elif grains['os'] == 'SUSE' %}
  {% set id = 'SUSE' %}
  {% set codename= grains['oscodename'] %}
{% endif %}


{% if grains['os'] == 'Ubuntu' %}
add-telegraf-repo-ubuntu:
  pkgrepo.managed:
    - humanname: Repositorio para telegraf ubuntu
    - name: deb http://repos.influxdata.com/{{ id }} {{ codename }} stable
    - dist: {{ codename }}
    - file: /etc/apt/sources.list.d/influxdb.list
    - gpgcheck: 1
    - key_url: https://repos.influxdata.com/influxdb.key

telegraf-ubuntu:
  pkg.installed:
    - fromrepo: {{ codename }}
    - refresh: True
    - pkgs:
      - telegraf

{% elif grains['os'] == 'SUSE' %}
add-telegraf-repo-sles:
  pkgrepo.managed:
    - humanname: Repositorio para telegraf SUSE
    - baseurl: https://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Leap_15.1/
    - gpgcheck: 1
    - gpgkey: https://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Leap_15.1/repodata/repomd.xml.key
    - refresh: True

telegraf-sles:
  pkg.installed:
    - refresh: True
    - pkgs:
      - telegraf 
{% endif %}

create-file:
  file.managed:
    - name: /tmp/usb_activity.log

telegraf.service:
  service.running:
    - enable: True
    - full_restart: True

/etc/telegraf/telegraf.conf:
  file.managed:
    - source: salt://telegraf-exporter/files/telegraf.conf
    - name: /etc/telegraf/telegraf.conf
    - group: root
    - user: root    
    - mode: 644

{% else %}
{% endif %}
