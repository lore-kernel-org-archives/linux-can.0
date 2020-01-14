From: Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH] can, slip: Protect tty->disc_data access with RCU
Date: Tue, 14 Jan 2020 15:32:44 +0100
Message-ID: <20200114143244.20739-1-rpalethorpe@suse.com>
References: <0000000000002b81b70590a83ad7@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000002b81b70590a83ad7@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: Richard Palethorpe <rpalethorpe@suse.com>, syzbot+017e491ae13c0068598a@syzkaller.appspotmail.com, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Tyler Hall <tylerwhall@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
List-Id: linux-can.vger.kernel.org

write_wakeup can happen in parallel with close where tty->disc_data is set
to NULL. So we a) need to check if tty->disc_data is NULL and b) ensure it
is an atomic operation. Otherwise accessing tty->disc_data could result in
a NULL pointer deref or access to some random location.

This problem was found by Syzkaller on slcan, but the same issue appears to
exist in slip where slcan was copied from.

A fix which didn't use RCU was posted by Hillf Danton.

Fixes: 661f7fda21b1 ("slip: Fix deadlock in write_wakeup")
Fixes: a8e83b17536a ("slcan: Port write_wakeup deadlock fix from slip")
Reported-by: syzbot+017e491ae13c0068598a@syzkaller.appspotmail.com
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Tyler Hall <tylerwhall@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
---

Note, that mabye RCU should also applied to receive_buf as that also happens
in interrupt context. So if the pointer assignment is split by the compiler
then sl may point somewhere unexpected?

 drivers/net/can/slcan.c | 11 +++++++++--
 drivers/net/slip/slip.c | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 2e57122f02fb..ee029aae69d4 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -344,7 +344,14 @@ static void slcan_transmit(struct work_struct *work)
  */
 static void slcan_write_wakeup(struct tty_struct *tty)
 {
-	struct slcan *sl = tty->disc_data;
+	struct slcan *sl;
+
+	rcu_read_lock();
+	sl = rcu_dereference(tty->disc_data);
+	rcu_read_unlock();
+
+	if (!sl)
+		return;
 
 	schedule_work(&sl->tx_work);
 }
@@ -644,7 +651,7 @@ static void slcan_close(struct tty_struct *tty)
 		return;
 
 	spin_lock_bh(&sl->lock);
-	tty->disc_data = NULL;
+	rcu_assign_pointer(tty->disc_data, NULL);
 	sl->tty = NULL;
 	spin_unlock_bh(&sl->lock);
 
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 2a91c192659f..dfed9f0b8646 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -452,7 +452,14 @@ static void slip_transmit(struct work_struct *work)
  */
 static void slip_write_wakeup(struct tty_struct *tty)
 {
-	struct slip *sl = tty->disc_data;
+	struct slip *sl;
+
+	rcu_read_lock();
+	sl = rcu_dereference(tty->disc_data);
+	rcu_read_unlock();
+
+	if (!sl)
+		return;
 
 	schedule_work(&sl->tx_work);
 }
@@ -882,7 +889,7 @@ static void slip_close(struct tty_struct *tty)
 		return;
 
 	spin_lock_bh(&sl->lock);
-	tty->disc_data = NULL;
+	rcu_assign_pointer(tty->disc_data, NULL);
 	sl->tty = NULL;
 	spin_unlock_bh(&sl->lock);
 
-- 
2.24.0
