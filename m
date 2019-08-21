From: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?=5bPATCH=5d_can=3a_Delete_unnecessary_checks_before_the_m?=
 =?UTF-8?B?YWNybyBjYWxsIOKAnGRldl9rZnJlZV9za2LigJ0=?=
Date: Wed, 21 Aug 2019 21:30:11 +0200
Message-ID: <27674907-fd2a-7f0c-84fd-d8b5124739a9@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, Allison Randal <allison@lohutok.net>, "David S. Miller" <davem@davemloft.net>, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Lukas Wunner <lukas@wunner.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Sean Nyekjaer <sean@geanix.com>, Thomas Gleixner <tglx@linutronix.de>, Weitao Hou <houweitaoo@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 21 Aug 2019 21:16:15 +0200

The dev_kfree_skb() function performs also input parameter validation.
Thus the test around the shown calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/can/spi/hi311x.c  | 3 +--
 drivers/net/can/spi/mcp251x.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 03a711c3221b..7c7c7e78214c 100644
=2D-- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -184,8 +184,7 @@ static void hi3110_clean(struct net_device *net)

 	if (priv->tx_skb || priv->tx_len)
 		net->stats.tx_errors++;
-	if (priv->tx_skb)
-		dev_kfree_skb(priv->tx_skb);
+	dev_kfree_skb(priv->tx_skb);
 	if (priv->tx_len)
 		can_free_echo_skb(priv->net, 0);
 	priv->tx_skb =3D NULL;
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 12358f06d194..1c496d2adb45 100644
=2D-- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -274,8 +274,7 @@ static void mcp251x_clean(struct net_device *net)

 	if (priv->tx_skb || priv->tx_len)
 		net->stats.tx_errors++;
-	if (priv->tx_skb)
-		dev_kfree_skb(priv->tx_skb);
+	dev_kfree_skb(priv->tx_skb);
 	if (priv->tx_len)
 		can_free_echo_skb(priv->net, 0);
 	priv->tx_skb =3D NULL;
=2D-
2.23.0
