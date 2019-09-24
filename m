From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH 3/7] can: ti_hecc: stop the CPK on down
Date: Tue, 24 Sep 2019 18:45:52 +0000
Message-ID: <20190924184437.10607-4-jhofstee@victronenergy.com>
References: <20190924184437.10607-1-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190924184437.10607-1-jhofstee@victronenergy.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

When the interface goes down, the CPK should no longer take an active
part in the CAN-bus communication, like sending acks and error frames.
So enable configuration mode in ti_hecc_stop, so the CPK is no longer
active.

When a transceiver switch is present the acks and errors don't make it
to the bus, but disabling the CPK then does prevent oddities, like
ti_hecc_reset failing, since the CPK can become bus-off and starts
counting the 11 bit recessive bits, which seems to block the reset. It
can also cause invalid interrupts and disrupt the CAN-bus, since
transmission can be stopped in the middle of a message, by disabling
the tranceiver while the CPK is sending.

Since the CPK is disabled after normal power on, it is typically only
seen when the interface is restarted.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
---
 drivers/net/can/ti_hecc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 461c28ab6d66..b82c011ddbec 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -400,6 +400,9 @@ static void ti_hecc_stop(struct net_device *ndev)
 {
 	struct ti_hecc_priv *priv =3D netdev_priv(ndev);
=20
+	/* Disable the CPK; stop sending, erroring and acking */
+	hecc_set_bit(priv, HECC_CANMC, HECC_CANMC_CCR);
+
 	/* Disable interrupts and disable mailboxes */
 	hecc_write(priv, HECC_CANGIM, 0);
 	hecc_write(priv, HECC_CANMIM, 0);
--=20
2.17.1
