From: Mauro Carvalho Chehab <mchehab+huawei-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/37] net: manually convert files to ReST format - part 2
Date: Thu, 30 Apr 2020 18:03:55 +0200
Message-ID: <cover.1588261997.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux Doc Mailing List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, coreteam-Cap9r6Oaw4JrovVCs/uTlw@public.gmane.org, netfilter-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ishizaki Kou <kou.ishizaki-g3qfMnKXm6lL9jVzuh4AOg@public.gmane.org>, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Marcelo Ricardo Leitner <marcelo.leitner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jozsef Kadlecsik <kadlec-Cap9r6Oaw4JrovVCs/uTlw@public.gmane.org>, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, Florian Westphal <fw-HFFVJYpyMKqzQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jakub Kicinski <kuba-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geoff Levand <geoff-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Michael Ellerman <mpe@>
List-Id: linux-can.vger.kernel.org

That's the second part of my work to convert the networking
text files into ReST. it is based on today's linux-next (next-20200430).

The full series (including those ones) are at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=net-docs

I should be sending the remaining patches (another /38 series)
after getting those merged at -next.

The documents, converted to HTML via the building system are at:

	https://www.infradead.org/~mchehab/kernel_docs/networking/

Mauro Carvalho Chehab (37):
  docs: networking: convert l2tp.txt to ReST
  docs: networking: convert lapb-module.txt to ReST
  docs: networking: convert ltpc.txt to ReST
  docs: networking: convert mac80211-injection.txt to ReST
  docs: networking: convert mpls-sysctl.txt to ReST
  docs: networking: convert multiqueue.txt to ReST
  docs: networking: convert netconsole.txt to ReST
  docs: networking: convert netdev-features.txt to ReST
  docs: networking: convert netdevices.txt to ReST
  docs: networking: convert netfilter-sysctl.txt to ReST
  docs: networking: convert netif-msg.txt to ReST
  docs: networking: convert nf_conntrack-sysctl.txt to ReST
  docs: networking: convert nf_flowtable.txt to ReST
  docs: networking: convert openvswitch.txt to ReST
  docs: networking: convert operstates.txt to ReST
  docs: networking: convert packet_mmap.txt to ReST
  docs: networking: convert phonet.txt to ReST
  docs: networking: convert pktgen.txt to ReST
  docs: networking: convert PLIP.txt to ReST
  docs: networking: convert ppp_generic.txt to ReST
  docs: networking: convert proc_net_tcp.txt to ReST
  docs: networking: convert radiotap-headers.txt to ReST
  docs: networking: convert ray_cs.txt to ReST
  docs: networking: convert rds.txt to ReST
  docs: networking: convert regulatory.txt to ReST
  docs: networking: convert rxrpc.txt to ReST
  docs: networking: convert sctp.txt to ReST
  docs: networking: convert secid.txt to ReST
  docs: networking: convert seg6-sysctl.txt to ReST
  docs: networking: convert skfp.txt to ReST
  docs: networking: convert strparser.txt to ReST
  docs: networking: convert switchdev.txt to ReST
  docs: networking: convert tc-actions-env-rules.txt to ReST
  docs: networking: convert tcp-thin.txt to ReST
  docs: networking: convert team.txt to ReST
  docs: networking: convert timestamping.txt to ReST
  docs: networking: convert tproxy.txt to ReST

 .../admin-guide/kernel-parameters.txt         |    2 +-
 Documentation/admin-guide/serial-console.rst  |    2 +-
 Documentation/filesystems/afs.rst             |    2 +-
 Documentation/networking/bonding.rst          |    2 +-
 Documentation/networking/can.rst              |    2 +-
 .../networking/checksum-offloads.rst          |    2 +-
 Documentation/networking/index.rst            |   37 +
 Documentation/networking/ip-sysctl.rst        |    2 +-
 .../networking/{l2tp.txt => l2tp.rst}         |  145 ++-
 .../{lapb-module.txt => lapb-module.rst}      |  120 +-
 .../networking/{ltpc.txt => ltpc.rst}         |   45 +-
 ...1-injection.txt => mac80211-injection.rst} |   41 +-
 .../{mpls-sysctl.txt => mpls-sysctl.rst}      |   17 +-
 .../{multiqueue.txt => multiqueue.rst}        |   41 +-
 .../{netconsole.txt => netconsole.rst}        |  125 +-
 ...etdev-features.txt => netdev-features.rst} |   19 +-
 .../{netdevices.txt => netdevices.rst}        |   21 +-
 ...filter-sysctl.txt => netfilter-sysctl.rst} |   11 +-
 Documentation/networking/netif-msg.rst        |   95 ++
 Documentation/networking/netif-msg.txt        |   79 --
 ...ack-sysctl.txt => nf_conntrack-sysctl.rst} |   51 +-
 .../{nf_flowtable.txt => nf_flowtable.rst}    |   55 +-
 .../{openvswitch.txt => openvswitch.rst}      |   23 +-
 .../{operstates.txt => operstates.rst}        |   45 +-
 Documentation/networking/packet_mmap.rst      | 1084 +++++++++++++++++
 Documentation/networking/packet_mmap.txt      | 1061 ----------------
 .../networking/{phonet.txt => phonet.rst}     |   56 +-
 .../networking/{pktgen.txt => pktgen.rst}     |  316 ++---
 .../networking/{PLIP.txt => plip.rst}         |   43 +-
 .../{ppp_generic.txt => ppp_generic.rst}      |   52 +-
 .../{proc_net_tcp.txt => proc_net_tcp.rst}    |   23 +-
 ...iotap-headers.txt => radiotap-headers.rst} |   99 +-
 .../networking/{ray_cs.txt => ray_cs.rst}     |  101 +-
 Documentation/networking/{rds.txt => rds.rst} |  295 +++--
 .../{regulatory.txt => regulatory.rst}        |   29 +-
 .../networking/{rxrpc.txt => rxrpc.rst}       |  306 ++---
 .../networking/{sctp.txt => sctp.rst}         |   37 +-
 .../networking/{secid.txt => secid.rst}       |    6 +
 Documentation/networking/seg6-sysctl.rst      |   26 +
 Documentation/networking/seg6-sysctl.txt      |   18 -
 .../networking/{skfp.txt => skfp.rst}         |  153 ++-
 .../{strparser.txt => strparser.rst}          |   85 +-
 .../{switchdev.txt => switchdev.rst}          |  114 +-
 .../networking/tc-actions-env-rules.rst       |   29 +
 .../networking/tc-actions-env-rules.txt       |   24 -
 .../networking/{tcp-thin.txt => tcp-thin.rst} |    5 +
 .../networking/{team.txt => team.rst}         |    6 +
 .../{timestamping.txt => timestamping.rst}    |  154 ++-
 .../networking/{tproxy.txt => tproxy.rst}     |   55 +-
 MAINTAINERS                                   |   14 +-
 drivers/net/Kconfig                           |    4 +-
 drivers/net/appletalk/Kconfig                 |    2 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c  |    2 +-
 drivers/net/ethernet/toshiba/spider_net.c     |    2 +-
 drivers/net/fddi/Kconfig                      |    2 +-
 drivers/net/plip/Kconfig                      |    2 +-
 drivers/net/wireless/Kconfig                  |    2 +-
 drivers/staging/fsl-dpaa2/ethsw/README        |    2 +-
 include/linux/netdev_features.h               |    2 +-
 include/net/cfg80211.h                        |    2 +-
 include/uapi/linux/errqueue.h                 |    2 +-
 net/Kconfig                                   |    2 +-
 net/core/pktgen.c                             |    2 +-
 net/lapb/Kconfig                              |    2 +-
 net/mac80211/tx.c                             |    2 +-
 net/netfilter/Kconfig                         |    2 +-
 net/rxrpc/Kconfig                             |    6 +-
 net/rxrpc/sysctl.c                            |    2 +-
 net/wireless/radiotap.c                       |    2 +-
 samples/pktgen/README.rst                     |    2 +-
 70 files changed, 2864 insertions(+), 2357 deletions(-)
 rename Documentation/networking/{l2tp.txt => l2tp.rst} (79%)
 rename Documentation/networking/{lapb-module.txt => lapb-module.rst} (74%)
 rename Documentation/networking/{ltpc.txt => ltpc.rst} (86%)
 rename Documentation/networking/{mac80211-injection.txt => mac80211-injection.rst} (67%)
 rename Documentation/networking/{mpls-sysctl.txt => mpls-sysctl.rst} (82%)
 rename Documentation/networking/{multiqueue.txt => multiqueue.rst} (76%)
 rename Documentation/networking/{netconsole.txt => netconsole.rst} (66%)
 rename Documentation/networking/{netdev-features.txt => netdev-features.rst} (95%)
 rename Documentation/networking/{netdevices.txt => netdevices.rst} (89%)
 rename Documentation/networking/{netfilter-sysctl.txt => netfilter-sysctl.rst} (62%)
 create mode 100644 Documentation/networking/netif-msg.rst
 delete mode 100644 Documentation/networking/netif-msg.txt
 rename Documentation/networking/{nf_conntrack-sysctl.txt => nf_conntrack-sysctl.rst} (85%)
 rename Documentation/networking/{nf_flowtable.txt => nf_flowtable.rst} (76%)
 rename Documentation/networking/{openvswitch.txt => openvswitch.rst} (95%)
 rename Documentation/networking/{operstates.txt => operstates.rst} (87%)
 create mode 100644 Documentation/networking/packet_mmap.rst
 delete mode 100644 Documentation/networking/packet_mmap.txt
 rename Documentation/networking/{phonet.txt => phonet.rst} (82%)
 rename Documentation/networking/{pktgen.txt => pktgen.rst} (62%)
 rename Documentation/networking/{PLIP.txt => plip.rst} (92%)
 rename Documentation/networking/{ppp_generic.txt => ppp_generic.rst} (91%)
 rename Documentation/networking/{proc_net_tcp.txt => proc_net_tcp.rst} (83%)
 rename Documentation/networking/{radiotap-headers.txt => radiotap-headers.rst} (70%)
 rename Documentation/networking/{ray_cs.txt => ray_cs.rst} (65%)
 rename Documentation/networking/{rds.txt => rds.rst} (59%)
 rename Documentation/networking/{regulatory.txt => regulatory.rst} (94%)
 rename Documentation/networking/{rxrpc.txt => rxrpc.rst} (85%)
 rename Documentation/networking/{sctp.txt => sctp.rst} (64%)
 rename Documentation/networking/{secid.txt => secid.rst} (87%)
 create mode 100644 Documentation/networking/seg6-sysctl.rst
 delete mode 100644 Documentation/networking/seg6-sysctl.txt
 rename Documentation/networking/{skfp.txt => skfp.rst} (68%)
 rename Documentation/networking/{strparser.txt => strparser.rst} (80%)
 rename Documentation/networking/{switchdev.txt => switchdev.rst} (84%)
 create mode 100644 Documentation/networking/tc-actions-env-rules.rst
 delete mode 100644 Documentation/networking/tc-actions-env-rules.txt
 rename Documentation/networking/{tcp-thin.txt => tcp-thin.rst} (97%)
 rename Documentation/networking/{team.txt => team.rst} (67%)
 rename Documentation/networking/{timestamping.txt => timestamping.rst} (89%)
 rename Documentation/networking/{tproxy.txt => tproxy.rst} (70%)

-- 
2.25.4
