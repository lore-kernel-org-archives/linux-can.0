From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: fix timeout when set small bitrate
Date: Thu, 31 Jan 2019 09:37:22 +0000
Message-ID: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

Current we can meet timeout issue when setting a small bitrate like 10000
as follows on i.MX6UL EVK board (ipg clock =3D 66MHZ, per clock =3D 30MHZ):
root@imx6ul7d:~# ip link set can0 up type can bitrate 10000
A link change request failed with some changes committed already.
Interface can0 may have been left with an inconsistent configuration, pleas=
e check.
RTNETLINK answers: Connection timed out

It is caused by calling of flexcan_chip_unfreeze() timeout.

Originally the code is using usleep_range(10, 20) for unfreeze operation,
but the patch (8badd65 can: flexcan: avoid calling usleep_range from interr=
upt
context) changed it into udelay(10) which is only a half delay of before,
there're also some other delay changes.

After double to FLEXCAN_TIMEOUT_US to 100 can fix the issue.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 2bca867bcfaa..1f2b4db7da88 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -166,7 +166,7 @@
 #define FLEXCAN_MB_CNT_LENGTH(x)	(((x) & 0xf) << 16)
 #define FLEXCAN_MB_CNT_TIMESTAMP(x)	((x) & 0xffff)
=20
-#define FLEXCAN_TIMEOUT_US		(50)
+#define FLEXCAN_TIMEOUT_US		(100)
=20
 /* FLEXCAN hardware feature flags
  *
--=20
2.17.1
