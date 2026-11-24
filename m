Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544295;
	b=XeLWWHWEOWG3wt2bHD5U8OwyqdzyFTCJ0BXi4x+g/LgibMTsNt94JYTSvm++z69dV7rW
	 TEkVveKXxtgVncQUNxd6riJR5xeRWXFTG4fTF7zGLq4scfRwDr8N8leBIzRTNz39/7K6H
	 xpZ4KFGRS4T94hMfeebnTnfqzctDyhZn6o78K4Es2E+iQOhjvaPfLFeEo1HZVwlOc+6lI
	 SD6AYXofn4mpntUkG7lgULBFsQTM6WSHZj2I1KBEi9rRSiNBeVSShqEuGCc691D9Hkx+K
	 sQNt0R35yWH+rwtBY0KE6eJHvPIdhIvATrpEPFfD7312x9A99cih4j+7GokI+KPK0BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=g3r6px9wj27AE9bL3j63vFiaa51YZ/UcQpMXj27Znd8=;
	b=BkU+VgStt5hcJxdSlLMtjup4pw8oPmviKlXX/PixB9zQTyE6Dqa74M48U/SId0hJN8I3
	 Kh/CG17tgv+LnUEKt62q24OV5VDFjOL9svo/7c/hAWBzw6j2So+hGD1V5jo7sZbZcQius
	 nQEuV3Kud1V2jltKTCpVA6DKacVm90+uvR7tRQaIQuv+09khSijW70G+2PZdNpYLEWcw+
	 LfqzUoPM9tF24wTSDMRFV4n1PdK4QokO5KX7wqBEukOfIAlHuNGMCSmeLRZZXE84ECed8
	 7+TacLU4y098Ls3ynR4zfwBOiDohisCkbs+LAnj2+4+TLxlUH+ts94exGd6gH+Hi5sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=U0UOrD57;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC35606A687
	for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 18:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FC35606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=U0UOrD57
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f03920c477so41147845ad.2
        for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795544293; x=1796149093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3r6px9wj27AE9bL3j63vFiaa51YZ/UcQpMXj27Znd8=;
        b=U0UOrD57HY7ZLPwmUocZLCznbZCJPGOt0bsN8t0/Ex2MQnz4GIBpxpMskA/9NhMrto
         hD56TozGhVXNDm23Qqdzo2MY6niq5bpEJBY1kHIynxnsTUmaE3+HNkDI6XdFPEAkpSAv
         AxJrPcg1305PtwD6S7vziF4a01HZN2Yfi+1QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795544293; x=1796149093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3r6px9wj27AE9bL3j63vFiaa51YZ/UcQpMXj27Znd8=;
        b=HebNnr7MMrfm+Z9I6OAmb2KqKQvzS0z4zoLsnwPogpDFR+rvQ3FrKiGjn8BqWxqFDG
         oFS7i1CWBw67t29Tl1cctHSj4Jm4OodTnHzUyrca215ikxzkLaiFJ0h2BWRw3ej7gSJc
         DlyRJbyYs2tfviVqfi3k0A9VsJnMLs1Zle25e3GAF3rzzR4kfJCJjvKvi5YnUuZ+U2XG
         QeAiSD4B+/Gqj/KSznzdatyqqtcv9DlhQ1/0NrFSU9nc5rBooNi0hqLXnh58fSYtI/HP
         RjL1x3d8YlUxkODoONkA+j1ly+g9xzQp+YbNI1Jb0xk7lUBZtV8Hf9S6/PuZf1GxEYgc
         Evuw==
X-Forwarded-Encrypted: i=1; AL+hErFWQmK/0SLz3aTbzzNGXuDOp486tSHJoT77Q3YnodOLw2f7n92W4U6Et29S+h+Ab/qL3nTqoG7ArAA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SriX/v5ZCQtpYzmeKnRm1kuy44twv/A3sx6vikj+MKQ4C4qoa
	fXyLhRgxlLt6KQLrMzKwHQ92mw3blbSgWMqhBU4otVXSwNVx1+RAVl3F4g36NqdUvKQ=
X-Gm-Gg: AZFdTZdYDZaoEV0/9SlnqHQDqarx4gmnHPeC4qEiSNjafteV9rwjAP6h911xW4IanWG
	1+jKOMp/qbNpczrf9UPLNxG48uEqil8R2QDurDlgo8OCu58KaB7nhnLYzaoOamLZcDy/f5UquEm
	XzlYQcL1yrn185affAlZD9RzwXfZdtpMByBbWZ7erkctd8RoM8TnbZTNS++PUbrR4pIeHDQFTTD
	48T+ALBJxNMiIIeWNQx/YKRBzGudHfCPvepzrDhIM7PAGEGCPMEr7YGSrUazGk4owmQsEtxh/jH
	x7mnRh2T03I+reaJvTqH87JFl5W560G9OLaiPSJzseZdtVoYm+ZWKqaZ1yADRLpuGdEC6SeTjfb
	9Kj3KsO+rM9rRgZyukgMBNvrrb7Y76ddmWmffOiYGSXnSC/XNt0l8CGEjoNGIQDmjywyYVuvt/+
	YuLrLQYd9zY9BdHqDlVB6NTWCkLes/x7UhqI79aDMCHEtvYLZ+gMkaQgZIaH6QZKSSHGwAXkz8j
	daGAo+V4vT5dBW5HYSxPb1Z9VbXs4itgThqCQlOpp+D5iXvfSojlWjyi0gpqhag/re6tDsDs7zs
	HRWiJg5UbyTLhFNiLcTxPTsTim8MemzJJlJb5UbIXfqkZQj57bq02RokVFciLLJGl93iwzdGF/s
	fZWFHjgmRsLIzrv15v/g/X7XFaV26+9xpA/7YMQln+eI5wmc4bdbp7cpBTw+AZ5HE
X-Received: by 2002:a17:903:1a2b:b0:2ed:99b9:7fd8 with SMTP id d9443c01a7336-2f03f1403acmr165211935ad.30.1795544292574;
        Tue, 24 Nov 2026 10:18:12 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f12028dsm71104755ad.60.2026.11.24.10.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:18:12 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] can: j1939: do not pass a NULL session skb to the socket layer
Date: Tue, 24 Nov 2026 23:48:05 +0530
Message-Id: <20261124181805.638413-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179553126874.3135.14817947057284289051@kernel.org>
References: <179553126874.3135.14817947057284289051@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you - you are right on both counts, and the first one is the more
useful kind of wrong to be told about: the patch stopped the crash while the
commit message named a trigger that cannot happen, and the cause was left in
place.  v2 fixes the cause and says what actually happens.

v2 is posted as a separate thread:

  [PATCH net v2] can: j1939: reject an out-of-range data packet offset

The changelog is under its --- line, with a Link: back to this thread.

Point by point.


1. Is this the actual trigger?

> For a receive session, the queue does not seem able to be empty while the
> session is alive.
> That means the splat needs an ETP RTS, then an ETP DPO with an out-of-range
> offset, then an EOMA.
> Could the commit message describe the DPO trigger instead?

It is not the trigger, and yours is.  Checked against net.git:
j1939_session_new() queues one skb, j1939_session_fresh_new() sizes it to the
whole message with skb_put_zero(), and only j1939_session_skb_drop_old() -
which returns early below two queued skbs - and j1939_session_destroy()
remove any.  So the queue is never empty for a live receive session, and
"an EOMA for a connection whose data packets never arrived" describes nothing
real.  What fails is where the getter looks:

	offset_start = session->pkt.dpo * 7;

and for a receive session pkt.dpo is written only by j1939_xtp_rx_dpo_one(),
straight from the wire.

The reproducer sends precisely the sequence you describe - an ETP RTS, an ETP
DPO carrying 0xffffff, 0x100000, 0x010000 and 0x001000 in turn, then an EOMA -
and its own comments in the report thread say that pkt.dpo is taken unchecked
and that the lookup then matches no skb.  The analysis was there; it did not
reach the commit message I wrote.  That is on me, and v2's message is written
around the DPO.

> Would it also make sense to fix the cause? j1939_xtp_rx_dpo_one() could
> reject or cancel the session when the DPO is >= pkt.total. Another option
> is to fetch the RX message at offset 0 in j1939_session_completed(). The
> NULL check would then stay as a second guard.

v2 does both, because they answer different questions.

	dpo = j1939_etp_ctl_to_packet(dat);
	if (dpo >= session->pkt.total) {
		netdev_info(...);
		j1939_session_timers_cancel(session);
		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
		return;
	}

That is the cause, and the shape is j1939_xtp_rx_dat_one()'s: it already
refuses a packet number it cannot place and cancels the session, and the
packet numbers it checks are counted from this very offset, so checking one
and not the other was the gap.  dpo >= pkt.total is exactly the condition
under which dpo * 7 lands at or past total_message_size, since
pkt.total = (len + 6) / 7.

An out-of-range offset has no legitimate use either way: every data packet
that follows is rejected by the "packet > session->pkt.total" test in
j1939_xtp_rx_dat_one(), which derives packet from the same dpo, so such a
session can never complete with data.  Cancelling it costs a correct peer
nothing.

And in j1939_session_completed() the lookup is now at offset 0:

	se_skb = j1939_session_skb_get_by_offset(session, 0);

The DPO window says where the next data packet belongs; at completion it is
the whole message that goes to the sockets, which for a receive session is
the single skb at offset 0.  The NULL test stays, now as a second guard: if
it ever fires, an skb has gone missing from a queue this file does not touch
while the session lives, which would be a kernel bug rather than something a
peer did.

> One more point: j1939_session_tx_dat() and j1939_xtp_rx_dat_one() both call
> j1939_session_skb_get_by_offset(), not j1939_session_skb_get(). The only
> other caller of j1939_session_skb_get() appears to be j1939_simple_txnext().

Correct, and v1's commit message said otherwise.  j1939_simple_txnext() is
the other caller and it does test the result ("if (!se_skb) return 0;").
That sentence is gone from v2 rather than repaired, since the patch no longer
rests on what other callers do.


2. When se_skb is NULL, the session still ends as a success

> Is user space told anything at all?
> Could it also mention that error-queue users are left with a transfer that
> never completes or aborts?

Nothing is told, exactly as you describe.  j1939_session_deactivate_locked()
leaves session->err at 0, j1939_session_destroy() queues
J1939_ERRQUEUE_RX_ABORT only when err is set, so a socket on the error queue
sees RX_RTS and RX_DPO and then neither the data nor an abort; and no abort
frame goes to the peer, because j1939_session_cancel() is not called on that
path.  v2's commit message states this in those terms.

I have not made the guard report an error, and the reason is the first point:
with the offset checked where it arrives, that path is no longer reachable
from the wire, and the peer now gets the abort frame and the socket the
RX_ABORT from j1939_session_cancel() in j1939_xtp_rx_dpo_one() instead -
which is the right place for it, since that is where the protocol was
violated.  Setting session->err in j1939_session_completed() would also write
a field that __j1939_session_cancel() writes under
active_session_list_lock, and I would rather not add that to a path that
should now be unreachable.

If you would still prefer the guard to abort rather than to drop quietly, say
so and I will respin; it is a small change, but it is one I would rather not
make blind.


Thanks again for both - the first changed the patch, and the second changed
what the commit message claims.

pw-bot: cr
