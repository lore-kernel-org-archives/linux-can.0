From: David Jander <david@protonic.nl>
Subject: Re: j1939
Date: Tue, 20 Sep 2016 09:22:34 +0200
Message-ID: <20160920092234.7accf5f8@erd980>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:2653 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbcITHWh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2016 03:22:37 -0400
In-Reply-To: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, Kurt Van Dijck <kurt.van.dijck@eia.be>

On Mon, 19 Sep 2016 18:54:43 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> Hello,
> 
> I've ported Kurt's latest j1939 patches to linux-4.7. I've squashed all
> patches into one. Then a patch to undo unused modifications and a bunch
> of patches to make checkpatch happy.
> 
> I've pushed the result to
> 
> https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/log/?h=j1939
> 
> The remaining warning is about a case statement without fall through
> annotations and/or breaks:
> 
> > WARNING: Possible switch case/default not preceeded by break or fallthrough comment
> > #4017: FILE: net/can/j1939/transport.c:1031:
> > +	case tp_cmd_cts:
> > 
> > WARNING: Possible switch case/default not preceeded by break or fallthrough comment
> > #4018: FILE: net/can/j1939/transport.c:1032:
> > +	case 0xff: /* did some data */
> > 
> > WARNING: Possible switch case/default not preceeded by break or fallthrough comment
> > #4019: FILE: net/can/j1939/transport.c:1033:
> > +	case etp_cmd_dpo:  
> 
> The code in question is:
> 
> > /* transmit function */
> > static int j1939tp_txnext(struct session *session)
> > {
> > 	u8 dat[8];
> > 	const u8 *tpdat;
> > 	int ret, offset, pkt_done, pkt_end;
> > 	unsigned int pkt, len, pdelay;
> > 
> > 	memset(dat, 0xff, sizeof(dat));
> > 	get_session(session); /* do not loose it */
> > 
> > 	switch (session->last_cmd) {
> > 	case 0:
> > 		if (!j1939tp_im_transmitter(session->skb))
> > 			break;
> > 		dat[1] = (session->skb->len >> 0) & 0xff;
> > 		dat[2] = (session->skb->len >> 8) & 0xff;
> > 		dat[3] = session->pkt.total;
> > 		if (session->extd) {
> > 			dat[0] = etp_cmd_rts;
> > 			dat[1] = (session->skb->len >> 0) & 0xff;
> > 			dat[2] = (session->skb->len >> 8) & 0xff;
> > 			dat[3] = (session->skb->len >> 16) & 0xff;
> > 			dat[4] = (session->skb->len >> 24) & 0xff;
> > 		} else if (j1939cb_is_broadcast(session->cb)) {
> > 			dat[0] = tp_cmd_bam;
> > 			/* fake cts for broadcast */
> > 			session->pkt.tx = 0;
> > 		} else {
> > 			dat[0] = tp_cmd_rts;
> > 			dat[4] = dat[3];
> > 		}
> > 		if (dat[0] == session->last_txcmd)
> > 			/* done already */
> > 			break;
> > 		ret = j1939tp_tx_ctl(session, 0, dat);
> > 		if (ret < 0)
> > 			goto failed;
> > 		session->last_txcmd = dat[0];
> > 		/* must lock? */
> > 		if (tp_cmd_bam == dat[0])
> > 			j1939tp_schedule_txtimer(session, 50);
> > 		j1939tp_set_rxtimeout(session, 1250);
> > 		break;
> > 	case tp_cmd_rts:
> > 	case etp_cmd_rts:

This fall-through looks correct.

> > 		if (!j1939tp_im_receiver(session->skb))
> > 			break;
> >  tx_cts:
> > 		ret = 0;
> > 		len = session->pkt.total - session->pkt.done;
> > 		len = min(max(len, session->pkt.block), block ?: 255);
> > 
> > 		if (session->extd) {
> > 			pkt = session->pkt.done + 1;
> > 			dat[0] = etp_cmd_cts;
> > 			dat[1] = len;
> > 			dat[2] = (pkt >>  0) & 0xff;
> > 			dat[3] = (pkt >>  8) & 0xff;
> > 			dat[4] = (pkt >> 16) & 0xff;
> > 		} else {
> > 			dat[0] = tp_cmd_cts;
> > 			dat[1] = len;
> > 			dat[2] = session->pkt.done + 1;
> > 		}
> > 		if (dat[0] == session->last_txcmd)
> > 			/* done already */
> > 			break;
> > 		ret = j1939tp_tx_ctl(session, 1, dat);
> > 		if (ret < 0)
> > 			goto failed;
> > 		if (len)
> > 			/* only mark cts done when len is set */
> > 			session->last_txcmd = dat[0];
> > 		j1939tp_set_rxtimeout(session, 1250);
> > 		break;
> > 	case etp_cmd_cts:
> > 		if (j1939tp_im_transmitter(session->skb) && session->extd &&
> > 		    (etp_cmd_dpo != session->last_txcmd)) {
> > 			/* do dpo */
> > 			dat[0] = etp_cmd_dpo;
> > 			session->pkt.dpo = session->pkt.done;
> > 			pkt = session->pkt.dpo;
> > 			dat[1] = session->pkt.last - session->pkt.done;
> > 			dat[2] = (pkt >>  0) & 0xff;
> > 			dat[3] = (pkt >>  8) & 0xff;
> > 			dat[4] = (pkt >> 16) & 0xff;
> > 			ret = j1939tp_tx_ctl(session, 0, dat);
> > 			if (ret < 0)
> > 				goto failed;
> > 			session->last_txcmd = dat[0];
> > 			j1939tp_set_rxtimeout(session, 1250);
> > 			session->pkt.tx = session->pkt.done;
> > 		}
> > 	case tp_cmd_cts:
> > 	case 0xff: /* did some data */
> > 	case etp_cmd_dpo:

Also in this case, a tp_cmd_cts has almost the same function as etp_cmd_dpo,
so this should be ok. Not yet sure how the 0xff thing is supposed to work...

> > 		if ((session->extd || !j1939cb_is_broadcast(session->cb)) &&
> > 		    j1939tp_im_receiver(session->skb)) {
> > 			if (session->pkt.done >= session->pkt.total) {
> > 				if (session->extd) {
> > 					dat[0] = etp_cmd_eof;
> > 					dat[1] = session->skb->len >> 0;
> > 					dat[2] = session->skb->len >> 8;
> > 					dat[3] = session->skb->len >> 16;
> > 					dat[4] = session->skb->len >> 24;
> > 				} else {
> > 					dat[0] = tp_cmd_eof;
> > 					dat[1] = session->skb->len;
> > 					dat[2] = session->skb->len >> 8;
> > 					dat[3] = session->pkt.total;
> > 				}
> > 				if (dat[0] == session->last_txcmd)
> > 					/* done already */
> > 					break;
> > 				ret = j1939tp_tx_ctl(session, 1, dat);
> > 				if (ret < 0)
> > 					goto failed;
> > 				session->last_txcmd = dat[0];
> > 				j1939tp_set_rxtimeout(session, 1250);
> > 				/* wait for the EOF packet to come in */
> > 				break;
> > 			} else if (session->pkt.done >= session->pkt.last) {
> > 				session->last_txcmd = 0;
> > 				goto tx_cts;
> > 			}
> > 		}

Here we could better have break to be clear I guess. No code paths get to this
point AFAICS, but clarity is always better IMHO.

> > 	case tp_cmd_bam:
> > 		if (!j1939tp_im_transmitter(session->skb))
> > 			break;
> > 		tpdat = session->skb->data;
> > 		ret = 0;
> > 		pkt_done = 0;
> > 		pkt_end = (!session->extd && j1939cb_is_broadcast(session->cb))
> > 			? session->pkt.total : session->pkt.last;
> > 
> > 		while (session->pkt.tx < pkt_end) {
> > 			dat[0] = session->pkt.tx - session->pkt.dpo + 1;
> > 			offset = session->pkt.tx * 7;
> > 			len = session->skb->len - offset;
> > 			if (len > 7)
> > 				len = 7;
> > 			memcpy(&dat[1], &tpdat[offset], len);
> > 			ret = j1939tp_tx_dat(session->skb, session->extd,
> > 					     dat, len + 1);
> > 			if (ret < 0)
> > 				break;
> > 			session->last_txcmd = 0xff;
> > 			++pkt_done;
> > 			++session->pkt.tx;
> > 			pdelay = j1939cb_is_broadcast(session->cb) ?  50 :
> > 				packet_delay;
> > 			if ((session->pkt.tx < session->pkt.total) && pdelay) {
> > 				j1939tp_schedule_txtimer(session, pdelay);
> > 				break;
> > 			}
> > 		}
> > 		if (pkt_done)
> > 			j1939tp_set_rxtimeout(session, 250);
> > 		if (ret)
> > 			goto failed;
> > 		break;

Does coding-style suggest a default:break; here?

> > 	}
> > 	put_session(session);
> > 	return 0;
> >  failed:
> > 	put_session(session);
> > 	return ret;
> > }  
> 
> Is here someone with insight and can tell if the code is correct this way?

Looks correct to me. I have yet to test it though.

> Another thing that IMHO has to be sorted out is the use of module
> parameters:
> 
> > ./main.c:49:MODULE_PARM_DESC(padding, "Pad all packets to 8 bytes, and stuff with 0xff");
> > ./transport.c:60:MODULE_PARM_DESC(transport_burst_count, "Number of packets to send in burst between flow control (1..255, default 255)");
> > ./transport.c:61:MODULE_PARM_DESC(transport_max_size, "Maximum packet size (default 100k)");
> > ./transport.c:62:MODULE_PARM_DESC(transport_retry_time, "Packet retransmission timeout in msecs, used in case of buffer full. (default 20)");
> > ./transport.c:63:MODULE_PARM_DESC(transport_packet_delay, "Delay between packets to avoid buffer overruns (default 0)");  
> 
> Better convert them to netlink options.
> 
> Next think I'll do is to establish some communication with an external
> j1939 component. I'll keep you updated.

Thanks!

Best regards,

-- 
David Jander
Protonic Holland.
