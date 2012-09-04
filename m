From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2012-09-04
Date: Tue,  4 Sep 2012 22:55:41 +0200
Message-ID: <1346792142-17609-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35286 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757685Ab2IDUzz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Sep 2012 16:55:55 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org

Hello David,

this patch is for the v3.6 release cycle. Beno=C3=AEt Locher fixed a re=
peated frame
bug in the mcp251x driver. He implemented the workaround suggested by t=
he
errata sheet.

regards, Marc

--

The following changes since commit 5002200599429e83fc13e0d9a2d4788b7951=
5b0c:

  net: qmi_wwan: add several new Gobi devices (2012-09-01 22:49:34 -040=
0)

are available in the git repository at:

  git://gitorious.org/linux-can/linux-can.git fixes-for-3.6

for you to fetch changes up to cab32f39dcc5b35db96497dc0a026b5dea76e4e7=
:

  can: mcp251x: avoid repeated frame bug (2012-09-03 20:12:06 +0200)

----------------------------------------------------------------
Beno=C3=AEt Locher (1):
      can: mcp251x: avoid repeated frame bug

 drivers/net/can/mcp251x.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)


