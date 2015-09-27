From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [RFC PATCH 0/4] Net namespaces for SocketCAN
Date: Sun, 27 Sep 2015 18:22:08 +0000
Message-ID: <DB3PR05MB09246A6393EF43427D2CC17689400@DB3PR05MB0924.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0086.outbound.protection.outlook.com ([157.55.234.86]:39760
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752507AbbI0SW1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 27 Sep 2015 14:22:27 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, John Ernberg <john.ernberg@actia.se>

Hi all,

I've added net namespace support for raw and gw sockets. BCM needs work.

I've done some preliminary testing and everything seems to work, but I would
like to have some input from you guys before continuing.

In particular I'm worried that I might have missed something with regard to
receive lists. Devices still share the same "rcv_cache" across namespaces.

Please tell me what you think.

Thanks,
Andri

Andri Yngvason (4):
  net: can: make af_can header global
  net: can: rename structures
  net: can: move shared data into net namespace
  net: can: remove net namespace restrictions

 include/linux/can/core.h    |   4 +-
 include/net/af_can.h        | 131 +++++++++++++++++++
 include/net/net_namespace.h |   4 +
 include/net/netns/can.h     |  20 +++
 net/can/af_can.c            | 183 ++++++++++++++------------
 net/can/af_can.h            | 126 ------------------
 net/can/bcm.c               |  29 +++--
 net/can/gw.c                |  13 +-
 net/can/proc.c              | 307 ++++++++++++++++++++++++--------------------
 net/can/raw.c               |  34 +++--
 10 files changed, 466 insertions(+), 385 deletions(-)
 create mode 100644 include/net/af_can.h
 create mode 100644 include/net/netns/can.h
 delete mode 100644 net/can/af_can.h

-- 
2.5.3

