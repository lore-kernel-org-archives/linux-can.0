Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED63E5A09;
	Fri, 16 Oct 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134023; cv=none; b=kAeK1PWWZQRo84vj9CDYl+TzQZN7eSEdPDWp0jRn69fooTYWO19Buzdw7IUrdvJRgL3HCtACgd6ElhDp46gTYzeDjqZULfL6uwmNdgYzYGpP0gKXR72/G8F+EMvaMSbWsM7aArbOXTpwt2XVZGpDnLc/fS6hUhl8QAasDiXZkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134023; c=relaxed/simple;
	bh=Do6YjhU3I7HXW18+BJvR37KsjZCA905dHYlvgy77e7s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MhSDXXJsQQlR1ijQb5em6kkUJCWTbJGNi3EOh6+yirBRMII3/ceMpJqiVjCGhH4knQMLWKmjXP83IGgnOM2O3JLBOLGU1CtVC0hk4kW4NLmFHF1JV975w5crCgiuNRTMMUmDFUjUNfJEVkCc0xO/O+vvPLpighbeJLYlN6cl05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ryz3Gyfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ryz3Gyfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C591F000C9;
	Fri, 16 Oct 2026 07:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792134010;
	bh=OF5ULa6IJWX3C2R4SV7E2KBsDCBTRDWyiPVgL8acyIw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ryz3GyfjT/USJjFGQt3HzXxT8soHFKPIs3f88FkJFaU98fhLCYND3mIxqYh3jsHm2
	 036uMI4ZhygyUMLTILtDfpkJtsRtdtLJK8p8FuidubHLjIh73ywWEeqR0k7e/TgcH5
	 Jckj4boqVYwv5cjZ3288oHyCrPjei1sVdVivdhfjKj1mWRkg2s3I1cxIKZErRCgTI0
	 uzdVXgPPMVFplwPuDN9yCWPgee0irjUswcFATWetCDT3TenRy/DfLuRAdHhyiQ8r2e
	 UQd5jq1HzBA6xy501V4a2PLOMCCvxga1i15VhrApiTS7K6cW/9velzoFGZCjnnk8+F
	 V7t9h0M+8ImAw==
Subject: Re: [PATCH can-next v1 7/8] selftests: can: cover J1939 transport
 abort and timeout paths
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alexander.hoelzl@gmx.net, quchaosheng000406@163.com,
 penguin-kernel@I-love.SAKURA.ne.jp, kuba@kernel.org
Date: Fri, 16 Oct 2026 07:00:09 +0000
Message-ID: <179213400907.1406898.1428765402732531339@kernel.org>
In-Reply-To: <20261014154435.3577983-8-o.rempel@pengutronix.de>
References: <20261014154435.3577983-8-o.rempel@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The file header comment in
  tools/testing/selftests/net/can/test_j1939_multi.c (line 14) says the…
- [Low] tp_tx_rts_cts_timeout and tp_rx_timeout in
  tools/testing/selftests/net/can/test_j1939_multi.c time the kernel's…

--

selftests: can: cover J1939 transport abort and timeout paths

This commit adds TP-only edge-case tests to the J1939 multi-frame
selftests. One test covers a per-CTS block limit, two cover the RTS/CTS
and rx timeouts that should end a stalled session with a Connection
Abort, and one covers a received Connection Abort cancelling an incoming
session.

> diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
> index 1f27ee58f48c..069a9c8690b5 100644
> --- a/tools/testing/selftests/net/can/test_j1939_multi.c
> +++ b/tools/testing/selftests/net/can/test_j1939_multi.c
> @@ -5,7 +5,18 @@

[ ... ]

> + * Timing limitation: the abort/timeout tests wait with wide receive windows
> + * rather than tight bounds, because timing over vcan under QEMU is not tightly
> + * bounded. They catch a gross timer regression (e.g. a doubled timeout) but not
> + * a subtle shift; see the per-test comments.

[Severity: Low]
Does tp_rx_timeout() really catch a doubled timeout, as this comment
says? Its receive window is:

#define TP_RX_ABORT_WAIT_MS	(TP_T2_MS * 2)	/* generous; floor check is the real test */

That is 2500 ms, which is exactly a doubled T2.

The window also starts late. tp_rx_timeout() takes t0 only after
tp_rx_start_session() has dequeued the CTS. The kernel arms the rx timer
earlier, when it sends the CTS:

net/can/j1939/transport.c:j1939_session_tx_cts() {
    ...
	ret = j1939_tp_tx_ctl(session, true, dat);
	if (ret < 0)
		return ret;
    ...
	j1939_tp_set_rxtimeout(session, 1250);
    ...
}

Suppose T2 regressed from 1250 to 2500 ms. The abort would go out at
about T_cts + 2500 ms. The recv_ctl_cmd() deadline is t0 + 2500 ms, and
t0 is later than T_cts. So the abort would arrive inside the window or
right at its edge, and the test would usually pass. Any regression below
2x (for example 1250 -> 2400 ms) would always pass.

The comment on tp_rx_timeout() itself ("the upper bound is a generous T2
multiple, so timer shifts within it escape") also contradicts the header.
Only tp_tx_rts_cts_timeout(), with its 2000 ms window, matches the
header's claim. The last patch in this series doesn't change this file.

Could the header claim be limited to the TX test? Alternatively, the RX
window could be set below 2 * T2, for example 2000 ms as in the TX test.

> + *
> + * Coverage limitation: a received Connection Abort is exercised RX-side only;

[ ... ]

> @@ -313,6 +332,69 @@ TEST_F(j1939_multi, tp_tx_to_raw)

[ ... ]

> +TEST_F(j1939_multi, tp_tx_rts_cts_timeout)
> +{
> +	uint8_t payload[TP_SIZE];
> +	struct timespec t0, t1;
> +	struct can_frame frame;
> +	long elapsed_ms;
> +
> +	fill_pattern(payload, sizeof(payload));
> +
> +	ASSERT_EQ(tx_start_session(&self->j1939, self->ifindex, payload,
> +				   sizeof(payload), self->raw, J1939_PF(TP_CTL),
> +				   TP_CMD_RTS, &frame), 0);
> +
> +	/* Deliberately send no CTS; expect the kernel to abort within 2000 ms. */
> +	clock_gettime(CLOCK_MONOTONIC, &t0);
> +	ASSERT_EQ(recv_ctl_cmd(self->raw, J1939_PF(TP_CTL), SA_PEER, &frame,
> +			       2000, TP_CMD_ABORT), 0)
> +		TH_LOG("kernel did not send a Connection Abort within 2000 ms");
> +	clock_gettime(CLOCK_MONOTONIC, &t1);
> +	elapsed_ms = timespec_diff_ms(&t0, &t1);
> +	/* must not fire instantly: the T3 timer has to run before the abort */
> +	ASSERT_GE(elapsed_ms, 800)
> +		TH_LOG("abort fired after only %ld ms, timer did not run", elapsed_ms);

[Severity: Low]
Is t0 measured from the right reference point here? The kernel arms T3
when it transmits the RTS, not when userspace reads it:

net/can/j1939/transport.c:j1939_session_tx_rts() {
    ...
	ret = j1939_tp_tx_ctl(session, false, dat);
	if (ret < 0)
		return ret;
    ...
	} else {
		j1939_tp_set_rxtimeout(session, 1250);
	}
    ...
}

tx_start_session() has already dequeued the RTS before
clock_gettime(&t0) runs. So elapsed_ms is 1250 ms minus the delay
between the kernel transmit and t0.

If the test task stalls for about 450 ms or more before t0, the abort
from a correct kernel arrives in under 800 ms. ASSERT_GE(elapsed_ms, 800)
then fails even though the kernel is fine. If the stall is over 500 ms, a
doubled T3 (2500 ms) would also fit inside the 2000 ms window. The
comment above this test says that case should be caught.

tp_rx_timeout() has the same pattern. j1939_session_tx_cts() arms the
1250 ms rx timer right after it transmits the CTS. t0 is taken only after
tp_rx_start_session() has consumed that CTS, and the same 800 ms floor
applies.

The header comment says vcan timing under QEMU is not tightly bounded,
and that is where stalls like this are most likely. Would kernel socket
timestamps on the RTS/CTS frame and on the abort give a more reliable
measure of the timer interval? The last patch in the series doesn't
change this.

> +	/* the T3 expiry must be reported as a timeout abort */
> +	EXPECT_EQ(frame.data[1], ABORT_REASON_TIMEOUT);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014154435.3577983-1-o.rempel%40pengutronix.de
