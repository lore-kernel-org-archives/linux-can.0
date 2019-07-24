From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/7] can: rcar_canfd: fix possible IRQ storm on high load
Date: Wed, 24 Jul 2019 15:03:17 +0200
Message-ID: <20190724130322.31702-3-mkl@pengutronix.de>
References: <20190724130322.31702-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190724130322.31702-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

We have observed rcar_canfd driver entering IRQ storm under high load,
with following scenario:
- rcar_canfd_global_interrupt() in entered due to Rx available,
- napi_schedule_prep() is called, and sets NAPIF_STATE_SCHED in state
- Rx fifo interrupts are masked,
- rcar_canfd_global_interrupt() is entered again, this time due to
  error interrupt (e.g. due to overflow),
- since scheduled napi poller has not yet executed, condition for calling
  napi_schedule_prep() from rcar_canfd_global_interrupt() remains true,
  thus napi_schedule_prep() gets called and sets NAPIF_STATE_MISSED flag
  in state,
- later, napi poller function rcar_canfd_rx_poll() gets executed, and
  calls napi_complete_done(),
- due to NAPIF_STATE_MISSED flag in state, this call does not clear
  NAPIF_STATE_SCHED flag from state,
- on return from napi_complete_done(), rcar_canfd_rx_poll() unmasks Rx
  interrutps,
- Rx interrupt happens, rcar_canfd_global_interrupt() gets called
  and calls napi_schedule_prep(),
- since NAPIF_STATE_SCHED is set in state at this time, this call
  returns false,
- due to that false return, rcar_canfd_global_interrupt() returns
  without masking Rx interrupt
- and this results into IRQ storm: unmasked Rx interrupt happens again
  and again is misprocessed in the same way.

This patch fixes that scenario by unmasking Rx interrupts only when
napi_complete_done() returns true, which means it has cleared
NAPIF_STATE_SCHED in state.

Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 05410008aa6b..de34a4b82d4a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1508,10 +1508,11 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 
 	/* All packets processed */
 	if (num_pkts < quota) {
-		napi_complete_done(napi, num_pkts);
-		/* Enable Rx FIFO interrupts */
-		rcar_canfd_set_bit(priv->base, RCANFD_RFCC(ridx),
-				   RCANFD_RFCC_RFIE);
+		if (napi_complete_done(napi, num_pkts)) {
+			/* Enable Rx FIFO interrupts */
+			rcar_canfd_set_bit(priv->base, RCANFD_RFCC(ridx),
+					   RCANFD_RFCC_RFIE);
+		}
 	}
 	return num_pkts;
 }
-- 
2.20.1
