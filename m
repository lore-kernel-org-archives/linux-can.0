From: Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: [PATCH net 2/4] can: j1939: cancel rxtimer on multipacket broadcast session complete
Date: Wed, 5 Aug 2020 11:50:23 +0800
Message-ID: <1596599425-5534-3-git-send-email-zhangchangzhong@huawei.com>
References: <1596599425-5534-1-git-send-email-zhangchangzhong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1596599425-5534-1-git-send-email-zhangchangzhong@huawei.com>
Sender: netdev-owner@vger.kernel.org
To: robin@protonic.nl, linux@rempel-privat.de, kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

If j1939_xtp_rx_dat_one() receive last frame of multipacket broadcast
message, j1939_session_timers_cancel() should be called to cancel
rxtimer.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 net/can/j1939/transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index e5188ac..dd6a120 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1788,6 +1788,7 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 	}
 
 	if (final) {
+		j1939_session_timers_cancel(session);
 		j1939_session_completed(session);
 	} else if (do_cts_eoma) {
 		j1939_tp_set_rxtimeout(session, 1250);
-- 
2.9.5
