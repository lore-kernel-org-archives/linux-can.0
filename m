From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/6] CAN FD support
Date: Mon, 18 Jun 2012 19:38:58 +0200
Message-ID: <4FDF67B2.1090004@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:16449 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab2FRRi7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 13:38:59 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Marc,

here's my first real git patch series adding support for CAN with flexible
data rate (CAN FD).

As there were no new remarks to my RFC v5 from 2012-05-28

http://comments.gmane.org/gmane.linux.can/1297

and it's tested and running on my machine for a while now it's IMHO time
for net-next now.

You can also pull the series ;-)

Git is hard for newbies but i gave my very best ...

Best regards,
Oliver


The following changes since commit 4670fd819e7f47392c7c6fc6168ea2857c66d163:

  tcp: Get rid of inetpeer special cases. (2012-06-09 01:25:47 -0700)

are available in the git repository at:

  git://gitorious.org/~hartkopp/linux-can/ollis-can-next.git canfd

for you to fetch changes up to d55c45913f93ccbd4378195e2d6ca96b2d14573b:

  canfd: update documentation according to CAN FD extensions (2012-06-17 21:23:55 +0200)

----------------------------------------------------------------

Oliver Hartkopp (6):
  canfd: add new data structures and constants
  canfd: add support for CAN FD in PF_CAN core
  canfd: add support for CAN FD in CAN_RAW sockets
  candev: add/update helpers for CAN FD
  vcan: add CAN FD support
  canfd: update documentation according to CAN FD extensions

 Documentation/networking/can.txt |  154 ++++++++++++++++++++++++++++++++++++--
 drivers/net/can/dev.c            |   35 ++++++++-
 drivers/net/can/vcan.c           |   27 +++++--
 include/linux/can.h              |   55 +++++++++++++-
 include/linux/can/core.h         |    4 +-
 include/linux/can/dev.h          |   33 ++++++--
 include/linux/can/raw.h          |    3 +-
 include/linux/if_ether.h         |    3 +-
 net/can/af_can.c                 |  116 +++++++++++++++++++++-------
 net/can/raw.c                    |   50 ++++++++++++-
 10 files changed, 417 insertions(+), 63 deletions(-)

-- 
1.7.10.4

