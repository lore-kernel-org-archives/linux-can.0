Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549725;
	b=xpdWsHFdRn1xBt2RdStuh6nvCeJjXxvCKcKl38MUH+QiSedl4/QhFfGUnJRmVH4DP3tW
	 m1ecKnJyQIZGA3sg4qpKfvMPyzcEmxknu/Dc8zPFt2m5k1KdgPJVroOFUoGQ+obAEamHW
	 lSiNPqGpEDCjkSOp01uU6ihuasdYlD36e6PRQfuIe9KaioWs03owYpVsFwLvx5tCnn56b
	 /VjFZkhnjQiWRxCy+iIMt+423IshBn3UfXwBarYFLBv6ztEs2qlcCBHhG8JWn5MkcLKip
	 z3RE2R1G1gvMcg1qo41o8WN3QEEejn4XiKaLvQ/dYfVWV8cTqdxYs0r0FkhltCeREjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549725;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=f0tfoDPeXWlHqzej2oB2Yoxq7N2r8FCUr0elWdc55Ws=;
	b=i0iNY3hxf+dw6soyw+bR0khBoai6Mz3JUIi/3G/lO85OrM1h5cRwmXBFMVeOkWniNxcO
	 KI+GIx0Ut9ZXAc47ZYcWycw4KG5zjyA8fDmi6puZ0541kFiu6ZOsjzrvAOxREGk1jIkZ9
	 jJt9HuSWlCRxNf9mAGyFtqrmGHxGAX/UGI4DQwQFahKU6O3Kfu7jJG2rFw5ujcGJwxtAS
	 R06T4PJoG3lXq7bmDj/+PjgKUvSnXGaYbKr7hVQ5cPsRS19jCEBzY1woRdNp8Gny61v2W
	 nuNRUoP1JF4JdKz2f3wYH8S74CA5zZ9n21OHXSVs1f7FRk+7nFBeLwC8+i2bgitYueQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8cXUfPW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C4606A8A0;
	Fri, 13 Nov 2026 06:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8cXUfPW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91DB1F000D0;
	Fri, 13 Nov 2026 06:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549724;
	bh=f0tfoDPeXWlHqzej2oB2Yoxq7N2r8FCUr0elWdc55Ws=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z8cXUfPWGtOAHMN62suecoKKASGV+mxijsNH9B6yd4g3y9XdsEquCmx+eyoN2R1iN
	 EU9pOdggS9f51v6Dj9aFgGVLwEEqb9RyVHVCLDRYUoBwp7F9Ndo2cbeC2qcT5Hnob+
	 oQ4DPCU5ehxemXUx5m8Nv/brm76NbVti/Q44Qy7tP57pDfWoQ0KcWg2rLAMmhcsaV2
	 4VZ77myXE+VZwek6yOnrfgqL2TOOwUKbe0gJCo1yu7SBxsEHkNSncSkxgVa8ZAyhAc
	 d807GNZryb8SQreJlLgEQLvSRgtx6QyIbj4EWCGprSVxIOnq92l1SejISV3tO7xCTi
	 2J3tchq2es3Mw==
Subject: Re: [PATCH can-next v3 7/9] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 13 Nov 2026 06:02:03 +0000
Message-ID: <179454972353.488853.9453703448480835098@kernel.org>
In-Reply-To: <20261111-j1939-selftests-v3-7-5a80277ab363@pengutronix.de>
References: <20261111-j1939-selftests-v3-7-5a80277ab363@pengutronix.de>
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

- [Medium] The patch adds four TP/ETP tests (tp_rx_from_raw,
  tp_tx_to_raw, etp_rx_from_raw, etp_tx_to_raw) that the author says can…

--

selftests: can: add J1939 TP/ETP multi-frame tests against CAN_RAW

This adds TP and ETP round-trip selftests in both directions. A CAN_RAW
socket acts as the transport peer, so the frames are checked as they
appear on the wire. The TX tests also check that the TX-completion ACK
reaches the error queue only after the peer's EOMA.

> diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
> index 21898e645ced7..99113184a525a 100644
> --- a/tools/testing/selftests/net/can/Makefile
> +++ b/tools/testing/selftests/net/can/Makefile
> @@ -9,6 +9,7 @@ LOCAL_HDRS := j1939_helpers.h j1939_tests.h ../../clock-helpers.h
>  TEST_PROGS := \
>  	test_j1939_addr.sh \
>  	test_j1939_base.sh \
> +	test_j1939_multi.sh \
>  	test_j1939_opts.sh \
>  	test_j1939_wire.sh \
>  	test_raw_filter.sh \

[ ... ]

> diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
> new file mode 100644
> index 0000000000000..aec96e83305cf
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_multi.c
> @@ -0,0 +1,682 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * J1939 multi-frame wire selftests: TP and ETP against CAN_RAW.
> + *

[ ... ]

> + * Known stack race: the stack updates a session from the loopback echo of
> + * its own CTS, RTS and DT frames, and the CAN_RAW peer can read that echo
> + * before the stack has handled it. A peer frame that follows quickly can
> + * then cancel the session, so these tests can fail at random. The fix
> + * belongs in the stack; this file does not work around it.

[Severity: Medium]
test_j1939_multi.sh goes straight into TEST_PROGS. Will a default
kselftest run then see random failures from this race that cannot be told
apart from real regressions?

The raw peer always gets the echo first. raw_init() sets a zero can_mask,
which puts the raw socket on rx[RX_ALL]. j1939 registers on rx[RX_FIL].
can_rcv_filter() walks the two lists in that order:

net/can/af_can.c:can_rcv_filter() {
    ...
	/* check for unfiltered entries */
	hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_ALL], list) {
		deliver(skb, rcv);
    ...
	/* check for can_id/mask entries */
	hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_FIL], list) {
    ...
}

In the RX tests, tp_serve_cts_ok() and etp_rx_serve_cts_ok() send the DPO
and DT frames as soon as they read the kernel's CTS. If the stack has not
handled the echo of its own CTS yet, last_cmd still holds the RTS. The
peer's DT then lands in the default case here:

net/can/j1939/transport.c:j1939_xtp_rx_dat_one() {
    ...
	switch (session->last_cmd) {
	case 0xff:
		break;
	case J1939_ETP_CMD_DPO:
    ...
	default:
		netdev_info(priv->ndev, "%s: 0x%p: last %02x\n", __func__,
			    session, session->last_cmd);
		goto out_session_cancel;
	}
    ...
}

In the TX tests, tp_tx_to_raw() and etp_tx_serve_block_ok() send a CTS
right after they read the kernel's RTS or the last DT of a block. If the
peer's CTS is handled before the RTS echo, last_cmd becomes CTS. The late
echo then cancels the session:

net/can/j1939/transport.c:j1939_xtp_rx_rts_session_active() {
    ...
	if (session->last_cmd != 0) {
		/* we received a second rts on the same connection */
    ...
		j1939_session_timers_cancel(session);
		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
    ...
}

A late echo of the last DT of a block can also arrive after the peer's
next ETP.CTS. That echo hits the same default case in
j1939_xtp_rx_dat_one().

This file comment is the only note about the race in the tree. The Q/A
under the --- line gets dropped when the patch is applied, and the commit
message does not mention the race. At the end of the series ("selftests:
can: check SO_J1939_PROMISC receive effect") the comment is the same and
test_j1939_multi.sh is still in TEST_PROGS with nothing to work around
the race.

Could these tests stay out of the default run, be marked as expected
failures, or wait for the stack to handle each echo before the peer
replies, until the stack is fixed? Could the commit message also mention
the race?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-j1939-selftests-v3-0-5a80277ab363%40pengutronix.de
