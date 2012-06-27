From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH 0/4] can: flexcan: upgrade the flexcan.c to support i.MX6
Date: Wed, 27 Jun 2012 16:19:17 +0800
Message-ID: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:36766 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab2F0ITn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 04:19:43 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, davem@davemloft.net, shawn.guo@linaro.org
Cc: linux-can@vger.kernel.org

i.MX6 is freescale arm chip, it has two flexcan controllers, when i add this driver to the i.MX6 and run it on the i.MX6 sabre lite board, this driver has several problems:
1. the value in the device tree is stored in big endian format, while arm works in little endian mode by default, The [1/4] patch fix this problem.
2. the i.MX6 has a higher can controller and has more registers, and some registers need to be set before the hardware can work well, The [2/4] patch fix this problem.
3. i.MX6 has two clocks to drive flexcan module. The [3/4] patch fix this problem.
4. i.MX6 has an external PHY to be operated. The [4/4] patch fix this problem.

Hui Wang (4):
      can: flexcan: use be32_to_cpup to handle the value of dt entry
      can: flexcan: add hardware controller version support
      can: flexcan: add ipg and ser clocks support
      can: flexcan: add transceiver switch support when use device tree

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    7 +
 drivers/net/can/flexcan.c                          |  119 ++++++++++++++++----
 2 files changed, 106 insertions(+), 20 deletions(-)

Thanks,
Hui.


