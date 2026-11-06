Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943326;
	b=nMZAsIG+fgFS0y7oXMZZ5l/8Trel1O0PEi6wN7Xc17HWx5ftN95yLYQGNXQ15JlQfGeF
	 rRlDH/X+uirXmKvnWGScHQxbfMPISRVav0aZ1vBIAaW4C5Haxpj30pW9Vj2/9ZTKvKZ3c
	 Ke0j3idnrnIPGN5wwvBt/CoH0yaL+p3UkWHsXgYnaHT0fJ8s5EF9bqQIX19kWoMEup361
	 3Cm9iTI8SJ7vzL7Wxi+1BDoMJ8CpMzDjQw6bGsaG7OyZp/eH5GqDybLs7IcllPsO21TAf
	 oPogB3+/lN28wLm7bw/L0+tM71NZVx4+5jj6X7ghwf/DM3wYbjnGpwPZM+QXc+Rv+Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943326;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YCHcH3lkHIgik8hu8mF2f17aavQpAFUHasd7ssYZfFE=;
	b=ZEfOe03h3IIGQyf3izs6yEvjJLDXkRICv/OiPQ/FMDQ5e1vaFCjlbPXP1zPajgz60wNK
	 6Xi9xejZhIK2IhJr/10fDHU6hgIZDkrxjfBDvfV0qgOc4hFhFTn59tIpEunWKOHrjfQ0O
	 5bGGA5w9sQlOG/O/eQhB7hnVOD0BB8SXDtEIMYD9CtQqp9u6UPEKl17mjM6AHgM0WHgbr
	 WuUWO7r1NaYVpusqWmNZ9bwBe/XL39IAPWfdx/V31rv7y0Nk9gdycS9RsKGWwhL6Luw93
	 waarVA/goN3G1AUoHgByk9zyPAtkoi8uy5bgZGREITAx6AQ1mMANaXzxMhI1sqGDz8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AY6mPXb8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD9606D802;
	Fri,  6 Nov 2026 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AY6mPXb8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E35F1F008BE;
	Fri,  6 Nov 2026 05:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943326;
	bh=YCHcH3lkHIgik8hu8mF2f17aavQpAFUHasd7ssYZfFE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AY6mPXb8olaBowfCmzvfSO7eJEzkEa3MaVcowUdTgvejT3t7Jx8RWrz7fK4jOh8Mp
	 vKDX2um6aer25YWP1Im8vo8iUCXySghyaVtbf6xxFqyQ7hUETtW6Ze904+OwE3M+yP
	 6BI8vL9DEPH/K0h3E9PJkApcuy3JIcXI3Mz1JUo832H+SlNuck+OdqbKkb+YyLU361
	 Tc6b2RhuwdKyyhVZbrEjTJyDHecyugM4MHIQtLXsEk+srAVlFaPL85jDxflVxxRaNq
	 S6vDPtIj+H4e1gpe9LgRf7qnT1N3mqQOZG5ovfQytCeQ+p1cop2mLjIbG3230m4YA0
	 wyvrgKUY6tJEA==
Subject: Re: [PATCH can-next v2 7/9] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 05:35:24 +0000
Message-ID: <179394332470.488853.6816602469055239073@kernel.org>
In-Reply-To: <20261104-j1939-selftests-v2-7-cf797c83317b@pengutronix.de>
References: <20261104-j1939-selftests-v2-7-cf797c83317b@pengutronix.de>
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

- [Medium] All four new tests in
  tools/testing/selftests/net/can/test_j1939_multi.c (tp_rx_from_raw,…

--

selftests: can: add J1939 TP/ETP multi-frame tests against CAN_RAW

This adds TP and ETP round-trip selftests in both directions. A CAN_RAW
socket acts as the transport peer, so the frames are checked as they
appear on the wire. The TX tests also check that the TX-completion ACK
reaches the error queue only after the peer's EOMA.

> diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
> new file mode 100644
> index 0000000000000..88a283a3394e0
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_multi.c

[ ... ]

> +static bool tp_serve_cts_ok(int raw, const uint8_t *payload, size_t size,
> +			    unsigned int num_pkts, unsigned int cts_limit)
> +{
> +	unsigned int sent = 0;
> +	struct can_frame frame;
> +
> +	while (sent < num_pkts) {
> +		unsigned int cts_pkts, next;
> +
> +		if (!recv_kernel_cm_ok(raw, TP_CM, TP_CMD_CTS, &frame,
> +				       J1939_RECV_TIMEOUT_MS))
> +			return false;
> +
> +		cts_pkts = frame.data[TP_CTS_PKTS_OFF];
> +		next = frame.data[TP_CTS_NEXT_OFF];	/* 1-based */
> +		if (!cts_accept_ok(cts_pkts, next, sent, num_pkts, cts_limit))
> +			return false;
> +
> +		if (!send_tp_dt_burst_ok(raw, SA_LOCAL, SA_PEER, next, cts_pkts,
> +					 payload, size))
> +			return false;

[Severity: Medium]
Can this DT burst reach the j1939 stack before the stack has handled the
loopback echo of its own CTS?

can_rcv_filter() delivers to the raw socket's RX_ALL filter before
j1939_can_recv() runs. So the raw socket can see the kernel's CTS before
j1939 has handled the echo.

The DT frames sent here go through raw_sendmsg()->can_send()->netif_rx()
on the test thread's CPU. They can be processed before the echo.

j1939_xtp_rx_cts_one() sets the session state from the echoed CTS:

	session->last_cmd = dat[0];

If a DT arrives while last_cmd is still TP_CMD_RTS,
j1939_xtp_rx_dat_one() cancels the session:

	switch (session->last_cmd) {
	...
	default:
		netdev_info(priv->ndev, "%s: 0x%p: last %02x\n", __func__,
			    session, session->last_cmd);
		goto out_session_cancel;
	}

The ETP tests seem to follow the same pattern.

In etp_rx_serve_cts_ok(), the peer's DPO can be handled before the echo
of the kernel's ETP.CTS. The echo then sets last_cmd to ETP_CMD_CTS, and
the DT frames that follow cancel the session.

In etp_tx_serve_block_ok(), the next ETP.CTS goes out as soon as the
last DT of the previous block is read from the raw socket:

	cm_dat_init(dat, ETP_CMD_CTS);
	dat[ETP_CTS_PKTS_OFF] = cts_pkts;
	put_le24(&dat[ETP_CTS_NEXT_OFF], next);
	if (!peer_send_cm_ok(self->raw, ETP_CM, dat))

If that CTS is handled before the echo of the last DT, the echo hits the
default case in j1939_xtp_rx_dat_one() and cancels the session. This
window opens at every block boundary in etp_tx_to_raw.

The notes below the "---" line describe this:

  "can a multi test fail against a correct kernel?
   Yes, through one known race in the stack ... The fix belongs in the
   stack, not in these tests."

git drops that text when the patch is applied. Neither the commit log
nor test_j1939_multi.c mentions the race.

No patch in the series changes net/can/j1939/. test_j1939_multi.sh is
added to TEST_PROGS, so default kselftest runs can fail at random with
no explanation in the tree.

The later patch "selftests: can: cover J1939 transport abort and timeout
paths" adds tp_rx_cts_block_limit. It reuses tp_rx_roundtrip_ok() with
more CTS windows, which means more chances to hit the race.

Could the race be documented in the commit message or in a comment in
test_j1939_multi.c? Alternatively, could these tests wait until the
stack fix lands?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-j1939-selftests-v2-0-cf797c83317b%40pengutronix.de
