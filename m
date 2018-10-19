From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] can: janz-ican3: fix a missing-check bug
Date: Fri, 19 Oct 2018 11:38:33 -0500
Message-ID: <1539967113-12352-1-git-send-email-wang6495@umn.edu>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

In ican3_old_recv_msg(), the values in the MSYNC control registers are
firstly read to 'peer' and 'locl' from the IO memory region 'mod->dpm'
through ioread8(). Then the result of the bitwise XOR of 'locl' and 'peer'
is saved to 'xord'. After that, 'xord' is checked to see whether the flag
MSYNC_RB_MASK is set. If not, an error code ENOMEM will be returned to
indicate that there is no mbox for reading. Later on, the whole message,
including the control registers, is read from 'mod->dpm' to 'msg' through
memcpy_fromio(). However, after this read, there is no re-check on the
values of the control registers. Given that the device also has the
permission to access the IO memory region, it is possible that a malicious
device controlled by an attacker modify the values in the control registers
between these two reads. By doing so, the attacker can bypass the check on
the control registers and supply unexpected values, which can cause
undefined behavior of the kernel and introduce potential security risk.

This patch rewrites the values of the control registers in 'msg' after
memcpy_fromio(), using the values acquired from ioread8(). Through this
way, the above issue can be avoided.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/net/can/janz-ican3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 02042cb..45c6760 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -335,6 +335,8 @@ static int ican3_old_recv_msg(struct ican3_dev *mod, struct ican3_msg *msg)
 	mbox_page = (mbox == MSYNC_RB0) ? QUEUE_OLD_RB0 : QUEUE_OLD_RB1;
 	ican3_set_page(mod, mbox_page);
 	memcpy_fromio(msg, mod->dpm, sizeof(*msg));
+	msg->control = peer;
+	msg->spec = locl;
 
 	/*
 	 * notify the firmware that the read buffer is available
-- 
2.7.4
