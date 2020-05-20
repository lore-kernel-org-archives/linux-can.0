From: Dinghao Liu <dinghao.liu@zju.edu.cn>
Subject: [PATCH] can: xilinx_can: fix runtime pm imbalance on error
Date: Wed, 20 May 2020 20:14:34 +0800
Message-ID: <20200520121434.4927-1-dinghao.liu@zju.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Wolfgang Grandegger <wg@grandegger.com>
List-Id: linux-can.vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
the call returns an error code. Thus a pairing decrement is needed
on the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/net/can/xilinx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index c1dbab8c896d..a9e8184cc611 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1823,8 +1823,8 @@ static int xcan_probe(struct platform_device *pdev)
 	return 0;
 
 err_disableclks:
-	pm_runtime_put(priv->dev);
 err_pmdisable:
+	pm_runtime_put(priv->dev);
 	pm_runtime_disable(&pdev->dev);
 err_free:
 	free_candev(ndev);
-- 
2.17.1
