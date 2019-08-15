From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: update hardware feature information for i.MX8QM
Date: Thu, 15 Aug 2019 07:58:56 +0000
Message-ID: <20190815075638.23148-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

Update hardware feature information for i.MX8QM.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 58a794c7387b..def8cbbc04e8 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -207,7 +207,7 @@
  *   MX35  FlexCAN2  03.00.00.00     no        no        no       no      =
  no           no
  *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no      =
  no           no
  *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no      =
 yes           no
- *  MX8QM         ?  ?                ?         ?         ?        ?      =
   ?          yes
+ *  MX8QM  FlexCAN3  03.00.23.00    yes       yes        no       no      =
 yes          yes
  *   VF610 FlexCAN3  ?               no       yes        no      yes      =
 yes?          no
  * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no      =
 yes           no
  * LX2160A FlexCAN3  03.00.23.00     no       yes        no       no      =
 yes          yes
--=20
2.17.1
