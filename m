From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: pull request CAN FD support
Date: Tue, 19 Jun 2012 21:19:13 +0200
Message-ID: <4FE0D0B1.2040103@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:39953 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab2FSTTO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 Jun 2012 15:19:14 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Marc,

as there were no new remarks (and it has been hanging around on the ML for
quite a long time) i only posted the data structures patch after some
cosmetics suggested by Wolfgang.

The changes to the former patchset can be seen here too:

https://gitorious.org/linux-can/ollis-can-next/commit/d55c45913f93ccbd4378195e2d6ca96b2d14573b/diffs/e8b122525696b14ce6bcbce00785d06595663070

Regards,
Oliver



The following changes since commit 4670fd819e7f47392c7c6fc6168ea2857c66d163:

  tcp: Get rid of inetpeer special cases. (2012-06-09 01:25:47 -0700)

are available in the git repository at:

  git://gitorious.org/~hartkopp/linux-can/ollis-can-next.git canfd

for you to fetch changes up to e8b122525696b14ce6bcbce00785d06595663070:

  canfd: update documentation according to CAN FD extensions (2012-06-19 11:37:06 +0200)

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
 include/linux/can.h              |   59 +++++++++++++--
 include/linux/can/core.h         |    4 +-
 include/linux/can/dev.h          |   33 ++++++--
 include/linux/can/raw.h          |    3 +-
 include/linux/if_ether.h         |    3 +-
 net/can/af_can.c                 |  116 +++++++++++++++++++++-------
 net/can/raw.c                    |   50 ++++++++++++-
 10 files changed, 420 insertions(+), 64 deletions(-)



