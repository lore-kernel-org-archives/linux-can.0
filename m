From: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [BUG] pfifo_fast may cause out-of-order CAN frame transmission
Date: Thu, 09 Jan 2020 13:51:03 +0100
Message-ID: <7717e4470f6881bbc92645c72ad7f6ec71360796.camel@redhat.com>
References: <661cc33a-5f65-2769-cc1a-65791cb4b131@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <661cc33a-5f65-2769-cc1a-65791cb4b131@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-can.vger.kernel.org

On Wed, 2020-01-08 at 15:55 +0100, Ahmad Fatoum wrote:
> I've run into an issue of CAN frames being sent out-of-order on an i.MX6 Dual
> with Linux v5.5-rc5. Bisecting has lead me down to this commit:
> 
> ba27b4cdaaa ("net: dev: introduce support for sch BYPASS for lockless qdisc")
> 
> With it, using pfifo_fast, every few hundred frames, FlexCAN's .ndo_start_xmit is
> passed frames in an order different from how userspace stuffed them into the same
> socket.
> 
> Reverting it fixes the issue as does booting with maxcpus=1 or using pfifo
> instead of pfifo_fast.
> 
> According to [1], such reordering shouldn't be happening.
> 
> Details on my setup:
> Kernel version: v5.5-rc5, (occurs much more often with LOCKDEP turned on)
> CAN-Bitrate: 250 kbit/s
> CAN frames are generated with:
> cangen canX -I2 -L1 -Di -i -g0.12 -p 100
> which keeps polling after ENOBUFS until socket is writable, sends out a CAN
> frame with one incrementing payload byte and then waits 120 usec before repeating.
> 
> Please let me know if any additional info is needed.

Thank you for the report.

I think there is a possible race condition in the 'empty' flag update
schema:

CPU 0					CPU1
(running e.g. net_tx_action)		(can xmit)

qdisc_run()				__dev_xmit_skb()
pfifo_fast_dequeue				
// queue is empty, returns NULL
WRITE_ONCE(qdisc->empty, true);
					pfifo_fast_enqueue
					qdisc_run_begin() 	
					// still locked by CPU 0,
					// return false and do nothing, 
					// qdisc->empty is still true

					(next can xmit)
					// BYPASS code path
					sch_direct_xmit()
					// send pkt 2
					__qdisc_run()
					// send pkt 1

The following patch try to addresses the above, clearing 'empty' flag
in a more aggressive way. We can end-up skipping the bypass
optimization more often than strictly needed in some contended
scenarios, but I guess that is preferrable to the current issue.

The code is only build-tested, could you please try it in your setup?

Thanks,

Paolo
---
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index fceddf89592a..df460fe0773a 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -158,7 +158,6 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 	if (qdisc->flags & TCQ_F_NOLOCK) {
 		if (!spin_trylock(&qdisc->seqlock))
 			return false;
-		WRITE_ONCE(qdisc->empty, false);
 	} else if (qdisc_is_running(qdisc)) {
 		return false;
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 0ad39c87b7fd..3c46575a5af5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3625,6 +3625,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 			qdisc_run_end(q);
 		} else {
 			rc = q->enqueue(skb, q, &to_free) & NET_XMIT_MASK;
+			if (rc != NET_XMIT_DROP && READ_ONCE(q->empty))
+				WRITE_ONCE(q->empty, false);
 			qdisc_run(q);
 		}
 
