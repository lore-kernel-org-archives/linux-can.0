Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309438;
	b=OVTu+RYXfeIHcGoRCKoEZs1bxgbcp+t+gv/snA4MC7AqH4mgCNcwSYxrsJp8m+CLjsIx
	 hCVqnoQZw1Up2a0HQnnXZ7zFghH5YhG9On3OU9dCe0fdJGnS4tXaKylzV9AHrxqV14H7p
	 c7uPfLNa45YBw9C95yHwnbTOuXV+AqwUwazwPGK7HC36PK60pMGE31HvsuFEPGWTzVhoT
	 kpZ+oCKwYevaEHXzz0dVHanrzqvOgr77hjfWqqnDVWGIm2Ka76iJOgVXBUZK/3SIVKPc0
	 s6oonEjHx9aeSQorXi3VW3rQ7n+qtfXFOPE/GyVQgCAHurZuIYbUdTkJ0SHFHQXjHmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309438;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PILEnaDBNzPkill2qm3jj+/BKJ1Q7LUkoPvGO+IJ4aY=;
	b=BNoLZQBRhA2FTtR+YH2gr7IJkY8kflyXGmO8VNTsK8Vyk2MZC4CTEWCUSy0dm5Q+ubHt
	 HE5/gZb+EVm3otcNPL+7zxwidRsgQAEYQ7wFJIH7fYXMmM3Zx6wv5OnLi5G4JmPeH/0q3
	 4XxP4qpZ/qjEkqLvlwFVIKmVnOSf7i2LQm4zUWAmmdLdXGWn93AYxSo16BcqPdIeM/drv
	 TKg/kbkrZhPXWF+qLk/UChzY6XvZOezx6QHkNKnYjdZ7/rfK2EgGRTZYotUGX22xnYe0l
	 0pHRjif45jhmTqvIfCxZ/DPVMVO9HtFOg4N6jNpxKLACdBtdqgUdlfVWmnT1gBt1xqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYM5lkLf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD5606A320;
	Sun, 22 Nov 2026 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYM5lkLf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEB21F000C0;
	Sun, 22 Nov 2026 01:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309438;
	bh=PILEnaDBNzPkill2qm3jj+/BKJ1Q7LUkoPvGO+IJ4aY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cYM5lkLfxZQj+lCVglPjc4pVh+jXGBy8Yupym6eqWm7JkiWwD+JeqVrZgEcJYZUs4
	 zhnVYL6UC9NBzYPEQ7nxTSzf7PttwEl3tlgejUDd9jKIfozed+xsmXmO8N6Bc6yuKA
	 wdQJuWmpvkjs+69zRxKSnKUkOxvu+GeYn3A6Ui3UwNz3NmDGD2ScTzCmOy1UuzatTQ
	 3tqKlRcQvEfvAswH9yoJWESHNqX221fBWGWYCCwlksZeZCAJAECEJYMikOOjhxfBR0
	 e8JOlnmTp6S8nkVuIhaaR7jsVr5ytumHcDc89M8JvtZJveEM5nw22m+rl5Mc3C2SFb
	 SeWgXuAKIlyxw==
Subject: Re: [PATCH can-next v5 7/9] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Sun, 22 Nov 2026 01:03:57 +0000
Message-ID: <179530943723.3131.3874073778043295050@kernel.org>
In-Reply-To: <20261120-j1939-selftests-v5-7-fdf4c242a37e@pengutronix.de>
References: <20261120-j1939-selftests-v5-7-fdf4c242a37e@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new RX tests in
  tools/testing/selftests/net/can/test_j1939_multi.c assume that…

--

selftests: can: add J1939 TP/ETP multi-frame tests against CAN_RAW

This adds TP and ETP round-trip selftests in both directions. A CAN_RAW
socket acts as the transport peer and by default sits on its own vcan
behind the CAN gateway that j1939_lib.sh sets up. The tests check the
control and DT frames the kernel sends and the order of the TX-completion
ACK, and test_j1939_multi.sh is added to TEST_PROGS.

> diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
> new file mode 100644
> index 0000000000000..6edce7493892b
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_multi.c
> @@ -0,0 +1,682 @@

[ ... ]

> +static bool send_dt_burst_ok(int raw, uint8_t prio, pgn_t dt_pgn, uint8_t da,
> +			     uint8_t sa, unsigned int next, unsigned int count,
> +			     const uint8_t *payload, size_t size,
> +			     unsigned int first_seq)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < count; i++) {
> +		size_t abs_pkt = (next - 1) + i;
> +		uint8_t seq = first_seq + i;
> +
> +		if (!send_dt_ok(raw, prio, dt_pgn, da, sa, seq, payload,
> +				abs_pkt * J1939_DT_DATA_LEN, size))
> +			return false;
> +	}
> +	return true;
> +}

[ ... ]

> +static bool etp_rx_serve_cts_ok(int raw, const uint8_t *payload, size_t size)
> +{

[ ... ]

> +		cm_dat_init(dat, ETP_CMD_DPO);
> +		dat[ETP_DPO_PKTS_OFF] = cts_pkts;
> +		put_le24(&dat[ETP_DPO_BASE_OFF], next - 1);
> +		if (!peer_send_cm_ok(raw, ETP_CM, dat))
> +			return false;
> +
> +		if (!send_dt_burst_ok(raw, PRIO, ETP_DT, SA_LOCAL, SA_PEER,
> +				      next, cts_pkts, payload, size,
> +				      TP_FIRST_PKT))
> +			return false;

[Severity: Medium]
Can the DPO and the up to 255 DT frames after it reach the J1939 stack
in a different order than they were sent?

Each raw send() goes through can_send()->netif_rx()->netif_rx_internal().
With RPS off, that queues the frame on the current CPU's backlog:

net/core/dev.c:netif_rx_internal() {
    ...
	ret = enqueue_to_backlog(skb, smp_processor_id(), &qtail);
    ...
}

The gateway then queues its copy for CANIF while that CPU processes its
backlog. Frames stay in order only inside a single CPU's backlog.

On PREEMPT_RT, use_backlog_threads() always returns true. So netif_rx()
only wakes the per-CPU backlog_napi thread, and send() returns before
the frame has been handled. On non-RT kernels the same thing happens
with thread_backlog_napi, or when softirq work goes to ksoftirqd.

The test thread has no CPU affinity. Suppose it moves to another CPU
between two send() calls, for example after the backlog thread it just
woke preempts it. Then the new CPU can process a later frame before the
earlier frames still queued on the old CPU.

An ETP DT that arrives before the DPO has been handled hits the default
case in j1939_xtp_rx_dat_one() and cancels the session:

net/can/j1939/transport.c:j1939_xtp_rx_dat_one() {
    ...
	case J1939_TP_CMD_CTS:
		if (skcb->addr.type != J1939_ETP)
			break;
		fallthrough;
	default:
		...
		goto out_session_cancel;
    ...
}

The send_tp_dt_burst_ok() call in tp_serve_cts_ok() has the same
pattern. A TP DT that arrives early fails this check:

	if (packet == session->pkt.rx)
		session->pkt.rx++;

Then pkt.rx never reaches pkt.last, no EOMA is sent, and the session
times out.

The commit message says:

    j1939_lib.sh also turns RPS off on that vcan, so
    the peer gets each frame only after the stack has handled its echo

That covers the order between the stack's echo and the peer. It doesn't
cover the order of the peer's own consecutive frames. Nothing in
j1939_lib.sh or in this directory uses taskset or sched_setaffinity, and
that is still true at the end of the series.

Could tp_rx_from_raw and etp_rx_from_raw then fail at random in the
default kselftest run, especially on RT kernels or loaded VMs?

Would pinning the test process to one CPU fix this? That could be
sched_setaffinity() in j1939_test_main() or taskset in j1939_lib.sh.
The per-CPU backlog FIFO would then keep the order.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120-j1939-selftests-v5-0-fdf4c242a37e%40pengutronix.de
