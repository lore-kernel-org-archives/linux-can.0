From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] bonding: do not enslave CAN devices
Date: Thu, 30 Jan 2020 14:30:46 +0100
Message-ID: <20200130133046.2047-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org, syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com, dvyukov@google.com, mkl@pengutronix.de, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net, Oliver Hartkopp <socketcan@hartkopp.net>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Since commit 8df9ffb888c ("can: make use of preallocated can_ml_priv for per
device struct can_dev_rcv_lists") the device specific CAN receive filter lists
are stored in netdev_priv() and dev->ml_priv points to these filters.

In the bug report Syzkaller enslaved a vxcan1 CAN device and accessed the
bonding device with a PF_CAN socket which lead to a crash due to an access of
an unhandled bond_dev->ml_priv pointer.

Deny to enslave CAN devices by the bonding driver as the resulting bond_dev
pretends to be a CAN device by copying dev->type without really being one.

Reported-by: syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com
Fixes: 8df9ffb888c ("can: make use of preallocated can_ml_priv for per
device struct can_dev_rcv_lists")
Cc: linux-stable <stable@vger.kernel.org> # >= v5.4
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/bonding/bond_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 48d5ec770b94..4b781a7dfd96 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1475,6 +1475,18 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		return -EPERM;
 	}
 
+	/* CAN network devices hold device specific filter lists in
+	 * netdev_priv() where dev->ml_priv sets a reference to.
+	 * As bonding assumes to have some ethernet-like device it doesn't
+	 * take care about these CAN specific filter lists today.
+	 * So we deny the enslaving of CAN interfaces here.
+	 */
+	if (slave_dev->type == ARPHRD_CAN) {
+		NL_SET_ERR_MSG(extack, "CAN devices can not be enslaved");
+		slave_err(bond_dev, slave_dev, "no bonding on CAN devices\n");
+		return -EINVAL;
+	}
+
 	/* set bonding device ether type by slave - bonding netdevices are
 	 * created with ether_setup, so when the slave type is not ARPHRD_ETHER
 	 * there is a need to override some of the type dependent attribs/funcs.
-- 
2.20.1
