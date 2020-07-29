---
title: Nixos Accountability
tags:
  - nixos
  - accountability
---

# Parameters

* anything on the system can change - so just writing to a file won't work.
* services can only be disabled through rebuilding - note for subversion
* write wrapper around nixos-rebuild called cleanbrowsing-nixos-rebuild to:
  
  * start a service that monitors resolv.conf and ensures it has a proper
    nameserver setup (and only that nameserver)
  * make the service store a log of the time last checked. 

    * file should be created using mkTmp
    * timestamp on file should be read - if file was modified in any way then
      the timestamp would reflect this. If timestamp is too old then alert -
      service was stopped or disabled.

# Preventing Subversion

* I need something that will create a chicken and the egg problem. If I disable
  one service then another service will alert. And there's no way to disable 2
  services at exactly the same time.

* Each service will read the last line from a log file and ensure it came from
  the other service. THen write it's own response.

* Each running service will monitor /etc/nixos/configuration.nix and all
  related files to ensure that the code to enable itself isn't modified.
  If it is alert - this should be done fast enough that rebuilding won't 
  prevent an alert.
