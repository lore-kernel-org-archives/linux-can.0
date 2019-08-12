From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v2 1/5] can: xilinx_can: Skip error message on deferred probe
Date: Mon, 12 Aug 2019 15:36:42 +0530
Message-ID: <1565604406-4920-2-git-send-email-appana.durga.rao@xilinx.com>
References: <1565604406-4920-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565604406-4920-1-git-send-email-appana.durga.rao@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: netdev@vger.kernel.org, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>

When can clock is provided from the clock wizard, clock wizard driver may
not be available when can driver probes resulting to the error message
"Device clock not found error".

As this error message is not very userful to the end user, skip printing
it in the case of deferred probe.

Fixes: b1201e44 ("can: xilinx CAN controller support")
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index bd95cfa..ac175ab 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1791,7 +1791,8 @@ static int xcan_probe(struct platform_device *pdev)
 	/* Getting the CAN can_clk info */
 	priv->can_clk = devm_clk_get(&pdev->dev, "can_clk");
 	if (IS_ERR(priv->can_clk)) {
-		dev_err(&pdev->dev, "Device clock not found.\n");
+		if (PTR_ERR(priv->can_clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Device clock not found.\n");
 		ret = PTR_ERR(priv->can_clk);
 		goto err_free;
 	}
-- 
2.7.4
