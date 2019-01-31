From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: fix timeout when set small bitrate
Date: Thu, 31 Jan 2019 06:58:31 +0000
Message-ID: <20190131065619.7298-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Current we can meet timeout issue when setting a small bitrate
like 10000 as follows:
root@imx6qdlsolo:~# ip link set can0 up type can bitrate 10000
A link change request failed with some changes committed already.
Interface can0 may have been left with an inconsistent configuration,
please check.
RTNETLINK answers: Connection timed out

It is caused by calling of flexcan_chip_unfreeze() timeout.

Originally the code is using usleep_range(10, 20) for unfreeze operation,
but the patch (8badd65 can: flexcan: avoid calling usleep_range from
interrupt context) changed it into udelay(10) which is only a half delay
of before, there're also some other delay changes.

After only changed unfreeze delay back to udelay(20), the issue is gone.
So other timeout values are kept the same as 8badd65 changed.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 2bca867bcfaa..1d3a9053bbeb 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -530,7 +530,7 @@ static int flexcan_chip_unfreeze(struct flexcan_priv *p=
riv)
 	priv->write(reg, &regs->mcr);
=20
 	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
-		udelay(10);
+		udelay(20);
=20
 	if (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
 		return -ETIMEDOUT;
--=20
2.17.1
