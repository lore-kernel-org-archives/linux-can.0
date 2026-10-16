Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB303E1692;
	Fri, 16 Oct 2026 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134016; cv=none; b=P06B9WELM9ImyRSxWHjO1tCx9SZiX5joNMbu6fcDwRTzT1USPY33s2Bs4ZR/NyWuL6UtjgoHJ4dn9F1ILc2mSXP4jlIz7cQhpKuiddtVVzKZNLNIJsB7UFQ6g7726mcLUsKzYCLDLHQixD/1+o+CFQvAt9V354Bzav0OIECH2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134016; c=relaxed/simple;
	bh=YANuoAAQcPnVJK2NhhseqaTjDBstUEhVU47RKCSOT8c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwqsGcfdgr0CxFPovfNFRHcGrFbaV18I7vtyj89CIUaUvQaoyT+P2Aiisj9vC5QBY09vhVOdvAP+N0cVI6440Cm/LIDqXrXgLrshVj6B55+gDcJxQT99fTeribvvLGCxHCNbzQSU3H1eOE9vYKurR0THfASyMawMH4zZD+S932Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH7uc5xr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH7uc5xr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C9E1F000C6;
	Fri, 16 Oct 2026 07:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792134006;
	bh=N/VIQ6ZifhY4wPpgeQGr8KfRPVuNyWzDH6+Kt3lmFeg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GH7uc5xrclZsKJBbImLyrFssd49RilkbPwMueWKMXeVRTgiqf49Ql3zdEL6+9cFdP
	 6qdJWtXzb/jYvpMpmIJJseta+x13Cyxv9Z9TmFpzUeOf5Jt+mt+wvC2IPIAsLvAt4e
	 8q+2hwJhoPHhY1gsNXRJsYnOvyGoGe+yWr/8C9oa3SOaO55mAzSB007Nk19Kphjq14
	 SUGNTKBYs2O2oey+6+Csp6bclbrA3NbOLhvqCskNf7vbpitAnU5KfC/g3m8i5F87BU
	 bL7vAI9rdg299eevu6DRMfenqKrg2jmfnXTuuy7BjzdfN8lgI5S6ACErfN2ACZXGdD
	 jeK//JmsA5+Mw==
Subject: Re: [PATCH can-next v1 4/8] selftests: can: add J1939 addressing and
 concurrency tests
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alexander.hoelzl@gmx.net, quchaosheng000406@163.com,
 penguin-kernel@I-love.SAKURA.ne.jp, kuba@kernel.org
Date: Fri, 16 Oct 2026 07:00:05 +0000
Message-ID: <179213400517.1406898.11829174772680604152@kernel.org>
In-Reply-To: <20261014154435.3577983-5-o.rempel@pengutronix.de>
References: <20261014154435.3577983-5-o.rempel@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Several tests sync with the kernel's address-claim commit
  timer only through a fixed `usleep(ACLAIM_SETTLE_US)` of 300 ms.
- [Low] The comment above the name_addressing test says "NAME based
  addressing reaches the socket bound to that NAME", but no receiver is…
- [Low] The shared runner j1939_lib.sh setup() accepts a real CAN
  interface (`else ip link set dev "$CANIF" type can bitrate…
- [Low] stress_concurrent_sessions claims to show that "many concurrent
  transport-protocol sessions run without corruption", but all eight…
- [Low] In stress_concurrent_sessions, if fork() fails at iteration k >
  0, `ASSERT_GE(pids[i], 0)` goes through __bail(), which runs the…

--

selftests: can: add J1939 addressing and concurrency tests

This adds a kselftest for J1939 NAME-based addressing and address
claiming. It covers NAME bind and getsockname readback, the source
address on the wire, NAME-addressed transfers using a forged Address
Claimed, and address-claim conflicts. It also runs several concurrent
transport sessions as a stress check.

> diff --git a/tools/testing/selftests/net/can/test_j1939_addr.c b/tools/testing/selftests/net/can/test_j1939_addr.c
> new file mode 100644
> index 000000000000..8b1b093f0839
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_addr.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * J1939 addressing and concurrency selftests.

[ ... ]

> + * The vcan interface is set up by the caller (see test_j1939_addr.sh); its name
> + * is passed via the CANIF environment variable.
> + */

[Severity: Low]
setup() in the shared runner j1939_lib.sh also accepts a real CAN
device:

	else
		ip link set dev "$CANIF" type can bitrate "$BITRATE" || exit $ksft_skip
	fi

If CANIF points at a real bus with other J1939 nodes, what happens to an
ECU that already holds 0x50 or 0x90?

forge_address_claim() sends an Address Claimed from a CAN_RAW socket for
SA_RX (0x90) in name_addressing. It also sends one for SA_CLAIM (0x50)
with NAME_LOWER (0x00000000c0ffee00) in ac_conflict_lose, and
claim_addr() claims 0x50 too. A compliant ECU that sees a competing claim
with a lower NAME has to give up its address. The kernel follows the same
rule in j1939_ac_process().

Should these tests skip when CANIF is not a vcan? If not, could the
header comment and commit message at least mention this side effect?

[ ... ]

> +#define STRESS_SIZE		128	/* arbitrary test tuning */
> +#define ACLAIM_SETTLE_US	300000	/* settle: empirical, not spec */

[ ... ]

> +static int forge_address_claim(int raw, uint8_t sa, name_t name)
> +{
> +	uint8_t nb[8];
> +
> +	put_name(nb, name);
> +	if (send_raw8(raw, J1939_PRIO_DEFAULT, J1939_PGN_ADDRESS_CLAIMED,
> +		      J1939_NO_ADDR, sa, nb))
> +		return -1;
> +	/* give the kernel RX path a moment to process the claim */
> +	usleep(ACLAIM_SETTLE_US);
> +	return 0;
> +}

[Severity: Medium]
Could this fixed 300 ms sleep make the tests flaky?

The kernel maps a newly claimed address only when the ECU's ac_timer
fires:

net/can/j1939/bus.c:j1939_ecu_timer_start() {
	...
	/* Schedule timer in 250 msec to commit address change. */
	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
		      HRTIMER_MODE_REL_SOFT);
}

Until j1939_ecu_timer_handler() runs, j1939_name_to_addr() returns
J1939_IDLE_ADDR. j1939_ac_fixup() then fails with -EADDRNOTAVAIL on both
the src_name path and the dst_name path.

That leaves about 50 ms of slack. The soft hrtimer can be delayed, for
example when softirq work is pushed to ksoftirqd on a loaded VM, or on
debug or RT kernels. In that case the send after the sleep fails.

This affects the send in name_addressing and the final send in
address_claim_send. It also affects the baseline send_data() in
ac_conflict_probe(), so both ac_conflict_lose and ac_conflict_defend
would fail.

Would polling or retrying until a deadline be more robust here?

The comments also look inaccurate. ACLAIM_SETTLE_US is labelled
"empirical, not spec", but it has to be longer than the kernel's fixed
250 ms commit timer. The forge_address_claim() comment says it gives "the
kernel RX path a moment", but the sleep is really waiting for that timer.

> +
> +/* One independent transport-protocol round-trip; returns 0 on success. */
> +static int stress_child(int ifindex, uint8_t sa_tx, uint8_t sa_rx)
> +{
> +	uint8_t tx_buf[STRESS_SIZE];
> +	int tx, rx, rc = 1;
> +
> +	fill_pattern(tx_buf, sizeof(tx_buf));

[Severity: Low]
Every child sends the same payload here, because fill_pattern() uses only
the byte position:

	buf[i] = (uint8_t)(i ^ (i >> 8) ^ 0x3c);

send_recv_verify() only checks the length and runs memcmp() against that
same buffer.

Suppose a regression mixed up sessions. A wrong session lookup could
consume another session's TP.DT packets, or two receivers could get each
other's data. Would stress_concurrent_sessions still pass?

Adding a per-session byte to each payload (for example, one derived from
sa_tx) would make this kind of mixing visible.

[ ... ]

> +/*
> + * NAME based addressing reaches the socket bound to that NAME.
> + *
> + * The peer must have claimed its address before it is reachable by NAME, so
> + * inject an Address Claimed message for (SA_RX, NAME_RX) first. The sender
> + * uses a static source address and resolves the destination by NAME.
> + */
> +TEST_F(j1939_addr, name_addressing)
> +{
> +	uint8_t tx_buf[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
> +	uint8_t rx_buf[8];
> +
> +	/* static receiver on SA_RX; the forged claim maps NAME_RX -> SA_RX */
> +	self->rx = j1939_open_name(self->ifindex, J1939_NO_NAME, SA_RX, PGN_TEST);

[Severity: Low]
Is the header comment accurate? It says the transfer "reaches the socket
bound to that NAME". But the receiver is bound with J1939_NO_NAME, so
jsk->addr.src_name is 0.

As a result, j1939_sk_match_dst() skips the NAME branch:

net/can/j1939/socket.c:j1939_sk_match_dst() {
	...
	if (jsk->addr.src_name && skcb->addr.dst_name) {
		if (jsk->addr.src_name != skcb->addr.dst_name)
			return false;
	} else {
		...
		if (j1939_address_is_unicast(skcb->addr.da)) {
			if (jsk->addr.sa != skcb->addr.da)
				return false;
	...
}

The frame is delivered through the plain SA check instead.

The test does cover the TX side, where j1939_ac_fixup() resolves NAME_RX
to SA_RX. It never runs the RX-side NAME filter, though, so it would
still pass if that filter were broken.

Could the comment be reworded to match what is tested? Another option is
to bind the receiver to NAME_RX so the NAME match path runs as well.

[ ... ]

> +/* many concurrent transport-protocol sessions run without corruption. */
> +TEST_F(j1939_addr, stress_concurrent_sessions)
> +{
> +	pid_t pids[STRESS_N];
> +	int i, failed = 0;
> +
> +	for (i = 0; i < STRESS_N; i++) {
> +		pids[i] = fork();
> +		ASSERT_GE(pids[i], 0);

[Severity: Low]
If fork() fails partway through this loop, what happens to the children
that were already forked?

ASSERT_GE() runs the fixture teardown and aborts the test, so the
waitpid() loop below is skipped. The earlier children are neither killed
nor reaped. They keep running TP sessions with rx and tx sockets bound to
0x20 + i and 0x40 + i. The harness kills the process group only on
timeout, in __wait_for_test().

They do exit on their own once J1939_RECV_TIMEOUT_MS and the TP timeouts
expire, so this only matters when the test has already failed. They
could still overlap with the next test on the same interface.

Should the forked children be killed and reaped before the test fails?

> +		if (pids[i] == 0)
> +			_exit(stress_child(self->ifindex, 0x40 + i, 0x20 + i));
> +	}
> +
> +	for (i = 0; i < STRESS_N; i++) {
> +		int status;
> +
> +		if (waitpid(pids[i], &status, 0) < 0 ||

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014154435.3577983-1-o.rempel%40pengutronix.de
