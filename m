From: Michael Walle <michael@walle.cc>
Subject: [PATCH 0/2] can: flexcan: small fix and ISO CAN-FD support
Date: Mon, 29 Jun 2020 20:18:07 +0200
Message-ID: <20200629181809.25338-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Michael Walle <michael@walle.cc>
List-Id: linux-can.vger.kernel.org

Hi,

this patch series is based on:
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=flexcan

I took the liberty and ported and made some style changes to the ISO CAN-FD
patch from Joakim.

With these two patches applied for the branch above:
Tested-by: Michael Walle <michael@walle.cc>

Michael Walle (2):
  can: flexcan: use ctrlmode to enable CAN-FD
  can: flexcan: add support for ISO CAN-FD

 drivers/net/can/flexcan.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.20.1
