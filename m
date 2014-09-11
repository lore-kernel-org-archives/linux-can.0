From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2014-09-11
Date: Thu, 11 Sep 2014 09:53:03 +0200
Message-ID: <1410421984-15125-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40797 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbaIKHxN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Sep 2014 03:53:13 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello David,

this is a pull request for the current release cycle of a single patch.

The patch by David Jander fixes a scheduling while atomic problem in the
flexcan driver, that was introduced by me in v3.14-rc6.

Marc

The following changes since commit 1d7efe9dfaa6025acd29a726315f6f7d30a9f1ca:

  Documentation: filter: Add MIPS to architectures with BPF JIT (2014-09-10 15:24:27 -0700)

are available in the git repository at:

  git://gitorious.org/linux-can/linux-can.git tags/linux-can-fixes-for-3.17-20140911

for you to fetch changes up to 8badd65e48c90d66587359d5329c2813088c0f50:

  can: flexcan: avoid calling usleep_range from interrupt context (2014-09-11 09:29:51 +0200)

----------------------------------------------------------------
linux-can-fixes-for-3.17-20140911

----------------------------------------------------------------
David Jander (1):
      can: flexcan: avoid calling usleep_range from interrupt context

 drivers/net/can/flexcan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

