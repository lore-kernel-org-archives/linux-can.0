Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792895322;
	b=txvgCHsTSxSAcUJNpL9rJBqF0L1ckfzAbEGzGN6UtP+bZv+qDYRCe2hABGa/rkcC9zoO
	 aHjCK67Cnyc4GwtqNFti03/CRc1UQBUA/iIXkg06aNozpluUCAcu2ZX0fa8Bu5+tg/vSU
	 ybFCp55TYe8eGa2z2IlB2lCElar65H0c+po+D1AAFYEg6ioE/YnpP1olw1UNepHImEyeF
	 1yjo/UDTmgBxhHu97GtwiZB2NUmEPywR+6Y9oRhBaMnzavkFU+lsnb9yHEPTILJjEGPxD
	 nvnYX/RtluluIrT1HJY+qKd4ncixUTRwMZ6iyqpFv/jwFOFm4VeP6FnSook70BGU9vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792895322;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=KlCL6ajdGE33h/4ItyXVVQ/Y4XQB52mQkplGtSJphiU=;
	b=NgQ21L8OJv9pp+f2yAxxYUQYFE8VzBxUKlDbu3eQp1D58U4896UIcb7aVRFEZZeBiHcz
	 7yYiHd4d33l7Q8panyC973mG/GQ8yM4iReTohXTmWnyMs0tyL5OTYpXxxWZfvBss5frWA
	 Bs62KX7dovAkDWhg2QIZh03eOgawbAUhi4Xzfa5iOOR9RQEqo+MMPUx+HAdLKXddzHOXE
	 XLYTRy0L4NtsaBZHG3IzmCTi9so2v08yyqAUpUfjL3J23A78JKeyWMbux8epfYUfD30FI
	 phAhcObVQXXkJH+kMK3Yb+6bKGEbvk8bhHzgUESyrIfCpsLbRzlRD3aNZ1NN4a4DuBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=k8d0q9TX;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAD606A31A;
	Sun, 25 Oct 2026 02:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1BAD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=k8d0q9TX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=KlCL6ajdGE33h/4ItyXVVQ/Y4XQB52mQkplGtSJphiU=;
	b=k8d0q9TX55BoVQrGOGwu9FEhK1QW0Eh1zxQ3LBmsm0N1JKO5HVdQg51xC1+At1
	huVbBzDFHhexlsZlWfc5YtPWZdVXxLRF8fnzcl58ZGHvImaAfjTNKSq++O39UCRC
	cPCzrYhegxXvyPRPbO229UjCreXwU1qjl6wHHNEyVFdGA=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Oleksij Rempel <o.rempel@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 1/1] can: j1939: validate the EDPO packet number
Date: Sun, 25 Oct 2026 10:18:45 +0800
Message-ID: <179289472575.8393.8146655386481092375@163.com>
In-Reply-To: <179278868667.3130.12995219647320420687@kernel.org>
References: <179265494813.314254.14725785769836234084@163.com> <179278868667.3130.12995219647320420687@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t0wwad1qVysZCw--.1023S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF1kGFyfuFWfGw1DWrWkXrb_yoW3ZrWUpr
	W3Kr9rGr1DGF4Yvr4ktFWkXFy09rs3Xr45WF17G3s7A398Cr47tFyDKFyfWa9rC3ykCaya
	9w1Ygw4DGr4kC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRLvtiUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xF47WrdaTGUXAAA3A

Hi sashiko,

Thanks -- both Medium findings are real. I will respin as a split series
rather than argue with them, and the three Low findings are accepted too; two
of them are process points that I should simply have gotten right the first
time.

## Medium: session reference leak in `j1939_session_cancel()`

Accepted. The old code did the cancel/get/start back to back inside
`j1939_tp_set_rxtimeout()`. The patch moves the cancel above
`j1939_session_list_lock()` and the get+start below `__j1939_session_cancel()`,
which calls `j1939_xtp_tx_abort()` -> `j1939_xtp_do_tx_ctl()` ->
`can_send()`, and then `j1939_sk_send_loop_abort()`. So the window now spans
lock acquisition and a CAN frame transmit instead of three instructions.

The list lock does not help, exactly as you say: `j1939_tp_set_rxtimeout()`
does not take it, and it is reached from the receive path without it by
`j1939_xtp_rx_cts_one()`, `j1939_xtp_rx_dpo_one()` and
`j1939_xtp_rx_dat_one()`, plus from the transmit retry path through
`j1939_session_tx_rts()`/`_tx_dpo()`/`_tx_dat()` inside `j1939_tp_txtimer()`.
Your CPU0/CPU1 interleaving is therefore reachable: two `j1939_session_get()`
calls, one queued hrtimer, one `j1939_session_put()` on expiry. The session
then never reaches `j1939_session_destroy()`, so it keeps both its
`priv_dev_tracker` netdev reference and its `j1939_priv` reference, and
`ip link del` hangs in `unregister_netdevice()`.

Two notes on the fix I intend to take, because I do not think
`hrtimer_try_to_cancel()` alone closes it:

- The reason the cancel had to move out of the lock stays valid. Before this
  patch, `j1939_session_cancel()` called `hrtimer_cancel(&session->rxtimer)`
  while holding `active_session_list_lock`, and `j1939_tp_rxtimer()` takes the
  same lock, so a running softirq callback waiting for the lock deadlocks the
  CPU that holds the lock and waits for the callback.
- `hrtimer_try_to_cancel()` under the lock avoids the deadlock -- a callback
  that is already running makes it return -1 instead of waiting -- but the get
  and the start would still race with a concurrent `j1939_tp_set_rxtimeout()`,
  which does its own cancel/get/start without the lock. Closing the window
  needs both armers serialized, so the respin arms the rxtimer only under
  `active_session_list_lock`: `j1939_tp_set_rxtimeout()` takes the lock and
  uses `hrtimer_try_to_cancel()` + `j1939_session_put()` on a return of 1
  before the get+start, and `j1939_session_cancel()` does the same under the
  lock it already takes. That is the pattern `j1939_cancel_active_session()`
  already uses. No caller of `j1939_tp_set_rxtimeout()` holds that lock today,
  so this does not create a new lock order.

That is a larger change than the current hunk, which is another reason to
split it out (see the subject finding below).

## Medium: WAITING_ABORT deactivation lets the ABORT echo hit the next session

Accepted, and this one is the more serious of the two. Confirmed in the tree:
`j1939_xtp_rx_abort()` calls `j1939_xtp_rx_abort_one()` twice, once with
`reverse = false` and once with `true`, and each does
`j1939_session_get_by_addr()`, which walks `active_session_list` and matches on
SA/DA/type/PGN only. Queued sessions are activated by
`j1939_sk_queue_activate_next_locked()`, which schedules the next session's
txtimer with `time_ms = 10 + get_random_u32_below(16)` when the previous
session carried an error, so there is a real 10-25 ms window in which B is on
the list and has not sent anything yet. An ABORT echo that is still in flight
from A then matches B, `j1939_xtp_rx_abort_one()` drops B with
`j1939_session_timers_cancel()` + `j1939_session_deactivate_activate_next()`,
and the sender of B gets an error for a transfer that never started.

The respin drops the `waiting` branch entirely and instead arms the abort
timer for both `J1939_SESSION_ACTIVE` and `J1939_SESSION_WAITING_ABORT`. Only
the `ACTIVE` case calls `__j1939_session_cancel()`, so a second error input
does not put a second ABORT frame on the bus; it just re-arms the timer. The
session stays on `active_session_list` either way. What the branch was working
around is that a second error input reaching the same session calls
`j1939_session_timers_cancel()` first, which cancels the abort timer armed by
the first call, and the second `j1939_session_cancel()` then found the state
already `J1939_SESSION_WAITING_ABORT`, matched neither arm of the old state
test, and armed nothing -- the stranding case from your subject finding, the
one that ends in `unregister_netdevice: waiting for vcan0 to become free`. With
the timer re-armed, the session either gets its own ABORT echo, which now still
finds it on the list because it was never deactivated, or `j1939_tp_rxtimer()`
takes the `J1939_SESSION_WAITING_ABORT` branch after
`J1939_XTP_ABORT_TIMEOUT_MS` and deactivates as before. Each re-arm stays
balanced: one `j1939_session_get()` against the one `j1939_session_put()` in
the callback.

## Low: the comment in `j1939_xtp_rx_dpo_one()` is wrong

Accepted, the comment is simply incorrect. `j1939_can_recv()` sets
`J1939_ECU_LOCAL_SRC` from the source address alone:

```c
	if (j1939_address_is_unicast(skcb->addr.sa) &&
	    priv->ents[skcb->addr.sa].nusers)
		skcb->flags |= J1939_ECU_LOCAL_SRC;
```

and `j1939_tp_cmd_recv()` forwards every ETP.CM_DPO with that flag to the
transmitter session, so any local node sending a bad DPO reaches the branch,
not only the echo of an EDPO this stack built. Both the comment and the
matching sentence in the commit message go away.

On the reason code: `J1939_XTP_ABORT_ECTS_TOO_BIG` ("ECTS requested packets
exceeds message size") is wrong for a DPO we received, so the check will send
`J1939_XTP_ABORT_BAD_EDPO_OFFSET` unconditionally. The transmitter-side case
that motivated the conditional is real, but its cause is not in this function:
`j1939_xtp_rx_cts_one()` bounds `pkt` only with `if (!pkt)` and
`dat[1] > session->pkt.block`, so an oversized ETP.CM_CTS packet number can set
`pkt.tx_acked` past `pkt.total`, and the EDPO built from it in
`j1939_session_tx_dpo()` carries that value back to us. The respin bounds the
CTS there -- `pkt > session->pkt.total` is exactly `ECTS_TOO_BIG` -- and then an
out-of-range DPO reaching the transmitter is a genuine peer error.

## Low: the subject covers only one of the changes

Accepted. v7 will be four patches:

1. `can: j1939: abort a session whose abort timer was cancelled` -- the
   WAITING_ABORT re-arm, with the two-unparsable-ETP.DT repro and the
   `ip link del` hang.
2. `can: j1939: arm the rx timer under the session list lock` -- the
   `j1939_tp_set_rxtimeout()` / `j1939_session_cancel()` serialization above.
3. `can: j1939: simplify the second RTS handling` -- the
   `j1939_xtp_rx_rts_session_active()` change.
4. `can: j1939: validate the EDPO packet number` -- the bound check, the NULL
   guard in `j1939_session_completed()`, and the CTS bound; the 256-packet
   repro and the 3/3 panic result stay with this one.

You are right that the `dpo >= pkt.total` check alone stops the T1 NULL
dereference; patches 1 and 2 are there for the reference strand, not for T1,
and I will say so in their messages instead of implying they are part of the
crash fix.

## Low: commit message and tags

Accepted, all three:

- The revision and testing history ("stock, v5, and this revision", the
  per-case matrix) moves below the `---` line.
- `From:` and `Signed-off-by:` will use the same name. The `Author:
  Quchaosheng` in v6 is a `git send-email` identity mismatch on my side, not
  an intentional alias.
- `Closes:` replaces `Link:` after `Reported-by:`.

Thanks for the review -- the two Medium findings in particular were worth the
round trip, and finding 3 saved a wrong abort code from going in.

Chaosheng

pw-bot: cr

