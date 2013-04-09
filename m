From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2013-04-09
Date: Tue,  9 Apr 2013 10:13:34 +0200
Message-ID: <1365495215-12081-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45956 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934505Ab3DIINk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Apr 2013 04:13:40 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, davem@davemloft.net

Hello David,

here's a fix for the v3.9 release cycle, if not too late:

Wei Yongjun contributes a patch for the can-gw protocoll. The patch fixes the
memory allocated with kmem_cache_alloc(), is now freed using kmem_cache_free(),
not kfree().

regards,
Marc

---

The following changes since commit c802d759623acbd6e1ee9fbdabae89159a513913:

  netrom: fix invalid use of sizeof in nr_recvmsg() (2013-04-08 22:49:23 -0400)

are available in the git repository at:

  git://gitorious.org/linux-can/linux-can.git fixes-for-3.9

for you to fetch changes up to 3480a2125923e4b7a56d79efc76743089bf273fc:

  can: gw: use kmem_cache_free() instead of kfree() (2013-04-09 09:58:44 +0200)

----------------------------------------------------------------
Wei Yongjun (1):
      can: gw: use kmem_cache_free() instead of kfree()

 net/can/gw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


