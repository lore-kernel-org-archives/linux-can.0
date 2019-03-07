From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Date: Thu, 7 Mar 2019 15:00:33 +0000
Message-ID: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>, Per Christensen <pnc@deif.com>, Rasmus Villemoes <Rasmus.Villemoes@prevas.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

While trying to add support for the Flexcan modules on the MPC8309,
I'm hitting ETIMEDOUT in flexcan_chip_disable(). With this, probing
succeeds. Checking the leftover value of timeout with a primitive

  pr_err("%s: timeout=3D=3D%d\n", __func__, timeout);

after the loop in chip_disable() typically shows values around 12-14,
i.e. suggesting that it takes about 110-130 us for the LPM_ACK bit to
appear. So a timeout value of about twice that seems reasonable.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 75ce11395ee8..5f32053f78de 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -165,7 +165,7 @@
 #define FLEXCAN_MB_CNT_LENGTH(x)	(((x) & 0xf) << 16)
 #define FLEXCAN_MB_CNT_TIMESTAMP(x)	((x) & 0xffff)
=20
-#define FLEXCAN_TIMEOUT_US		(50)
+#define FLEXCAN_TIMEOUT_US		(250)
=20
 /* FLEXCAN hardware feature flags
  *
--=20
2.20.1
