From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 0/5] can: add SAE J1939 protocol
Date: Mon,  8 Oct 2018 11:48:31 +0200
Message-ID: <20181008094836.14080-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This series adds SAE J1939 support to the current kernel v4.19-rc6.

This stack has long history, starting back in 27 Apr 2011, if not
earlier:
https://lists.openwall.net/netdev/2011/04/27/45

After major rework and testing it is a time to send it mainline.

Kurt Van Dijck (2):
  mailmap: update email address
  can: introduce REQUIRED_SIZE macro

Oleksij Rempel (2):
  can: add socket type for CAN_J1939
  can: extend sockaddr_can to include j1939 members

The j1939 authors (1):
  can: add support of SAE J1939 protocol.

 .mailmap                           |    1 +
 Documentation/networking/j1939.txt |  468 ++++++++++
 MAINTAINERS                        |   10 +
 include/linux/can/can-ml.h         |    3 +
 include/linux/can/core.h           |    8 +
 include/uapi/linux/can.h           |   20 +-
 include/uapi/linux/can/j1939.h     |   83 ++
 net/can/Kconfig                    |    2 +
 net/can/Makefile                   |    2 +
 net/can/bcm.c                      |    4 +-
 net/can/j1939/Kconfig              |   23 +
 net/can/j1939/Makefile             |   12 +
 net/can/j1939/address-claim.c      |  224 +++++
 net/can/j1939/bus.c                |  309 +++++++
 net/can/j1939/j1939-priv.h         |  176 ++++
 net/can/j1939/main.c               |  371 ++++++++
 net/can/j1939/socket.c             |  781 ++++++++++++++++
 net/can/j1939/transport.c          | 1333 ++++++++++++++++++++++++++++
 net/can/raw.c                      |    4 +-
 19 files changed, 3829 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/networking/j1939.txt
 create mode 100644 include/uapi/linux/can/j1939.h
 create mode 100644 net/can/j1939/Kconfig
 create mode 100644 net/can/j1939/Makefile
 create mode 100644 net/can/j1939/address-claim.c
 create mode 100644 net/can/j1939/bus.c
 create mode 100644 net/can/j1939/j1939-priv.h
 create mode 100644 net/can/j1939/main.c
 create mode 100644 net/can/j1939/socket.c
 create mode 100644 net/can/j1939/transport.c

-- 
2.19.0
