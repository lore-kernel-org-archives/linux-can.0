From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull request: linux-can-next 2012-03-08
Date: Thu,  8 Mar 2012 10:50:29 +0100
Message-ID: <1331200230-1118-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this patch is against net-next. It's a bugfix for the PCAN-USB driver
on big endian system.

Regards, Marc

---

The following changes since commit ae5d33723e325392c48bc0ff481d9ec8d646a0ed:

  powerpc/44x: Add more changes for APM821XX EMAC driver (2012-03-06 17:07:42 -0500)

are available in the git repository at:
  git@gitorious.org:linux-can/linux-can-next.git master

Stephane Grosjean (1):
      can: peak_usb: PCAN-USB specific part: fix little endian usage

 drivers/net/can/usb/peak_usb/pcan_usb.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)
