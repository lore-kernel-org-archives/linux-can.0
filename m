From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2015-09-30
Date: Wed, 30 Sep 2015 13:12:43 +0200
Message-ID: <1443611564-1299-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request of a single patch for 4.3.

The patch is by Stephane Grosjean and add support for the peak OEM PCI card to
the peak_pci driver by adding its device ID.

regards,
Marc
---

The following changes since commit b84f78782052ee4516903e5d0566a5eee365b771:

  net: Initialize flow flags in input path (2015-09-29 21:52:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.3-20150930

for you to fetch changes up to 7253054e5d05233063c48f57ac02283bd35753d8:

  can: peak_pci: add unused device id. in devices table (2015-09-30 12:57:58 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.3-20150930

----------------------------------------------------------------
Stephane Grosjean (1):
      can: peak_pci: add unused device id. in devices table

 drivers/net/can/sja1000/peak_pci.c | 1 +
 1 file changed, 1 insertion(+)
