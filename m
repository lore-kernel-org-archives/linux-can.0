From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1] can: j1939: transport: j1939_session_tx_dat(): fix use-after-free read in j1939_tp_txtimer()
Date: Fri, 14 Feb 2020 13:06:23 +0100
Message-ID: <20200214120623.19574-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, syzbot+5322482fe520b02aea30@syzkaller.appspotmail.com, linux-stable <stable@vger.kernel.org>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The current stack implementation do not support ECTS requests of not
aligned TP sized blocks.

If ECTS will request a block with size and offset spanning two TP
blocks, this will cause memcpy() to read beyond the queued skb (which
does only contain one TP sized block).

Sometimes KASAN will detect this read if the memory region beyond the
skb was previously allocated and freed. In other situations it will stay
undetected. The ETP transfer in any case will be corrupted.

This patch adds a sanity check to avoid this kind of read and abort the
session with error J1939_XTP_ABORT_ECTS_TOO_BIG.

Reported-by: syzbot+5322482fe520b02aea30@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: linux-stable <stable@vger.kernel.org> # >= v5.4
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fe231992d848..ebe18c3b0f35 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -787,6 +787,13 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 		if (len > 7)
 			len = 7;
 
+		if (offset + len > se_skb->len) {
+			netdev_err_once(priv->ndev,
+					"%s: 0x%p: requested data outside of queued buffer\n",
+					__func__, session);
+			return -EOVERFLOW;
+		}
+
 		memcpy(&dat[1], &tpdat[offset], len);
 		ret = j1939_tp_tx_dat(session, dat, len + 1);
 		if (ret < 0) {
@@ -1123,6 +1130,9 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		 * cleanup including propagation of the error to user space.
 		 */
 		break;
+	case -EOVERFLOW:
+		j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
+		break;
 	case 0:
 		session->tx_retry = 0;
 		break;
-- 
2.25.0
