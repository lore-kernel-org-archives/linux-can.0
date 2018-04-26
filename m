From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] can: fix ndo_start_xmit()'s return type
Date: Thu, 26 Apr 2018 23:13:35 +0200
Message-ID: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>
List-Id: linux-can.vger.kernel.org

ndo_start_xmit() is defined as returing an 'netdev_tx_t'.
However, several can drivers use 'int' as the return type
of their start_xmit() method.
This series contains the fix for all three of them.

Luc Van Oostenryck (3):
  can: janz-ican3: fix ican3_xmit()'s return type
  can: sun4i: fix sun4ican_start_xmit()'s return type
  can: xilinx: fix xcan_start_xmit()'s return type

 drivers/net/can/janz-ican3.c | 2 +-
 drivers/net/can/sun4i_can.c  | 2 +-
 drivers/net/can/xilinx_can.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.0
