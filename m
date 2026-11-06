Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943333;
	b=pOVTIeYRHF5UorIaSHE2trcGaJ/HGBmASBESk3D5NRlRGHMgYqe43C7Zv0bGgmJP2T66
	 9ejI2xozVbwvKXLZPqyndL17TuLKbCueNMO1KgiRyB6kfxMT3wDXmzdGPtW/9tImdT0n6
	 7XJ0bTE4JokesM/56bawTAiMPHIkQbag/4BU+atAjEyUC9LviCVzFSHvSgbH+TFGF9iJe
	 bi/d7OcskoIUJs8gm96lEn4Nnr+SLKOSyHSXDOEbAlZ5iknzN1gjCxpovrVyFmhZLo/+r
	 1zIXPz5Y6mTPjsZTG7iqt/T6zjpPby+6xrGmRohkX7YurUaxZ12vDP0769EEiMQpLeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943333;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oR45jZ8MrDX685bi4FPGnx1DblWLTg6bSBZ2c8luTN0=;
	b=R59ZVL03Qhmzt5tTqplqHMJhjJiZEvkzGPC/dzQmmoRyINnI/RtmhWdu9/AdKYuKi3RQ
	 ur9tMbXcSBFtpM05By4kXlxETkbqWpG25ZelJeUWTOL3g3OvWGgQaRsO56PRBbLjh8XXO
	 L0ySdS1dTDeU7YUqVuU714ptVmBRwFTIKXHPx0OQ5/JZA5PuVjPsRMYJx1uDo/ork1jWl
	 1oXlZ0aK/gu/x8pUdmIu9ZJCbTb7+jwth8ddygPoTDolkZLOlG3L/NTVymSRX4LFCiRM4
	 lYMBmM5X/B4thGnIYD8lB6x1uPCAdNF4covHAgWrw4izxqIMVhR2Vppm2qrvTwYlRkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Miaq4Rb2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F9606D811;
	Fri,  6 Nov 2026 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Miaq4Rb2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A43B1F00901;
	Fri,  6 Nov 2026 05:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943327;
	bh=oR45jZ8MrDX685bi4FPGnx1DblWLTg6bSBZ2c8luTN0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Miaq4Rb2mGgS6lT2H44hAOqJDDsmBBA+39ZEtB1AfjnpSRjbXettBV74FvwKtL/Ob
	 nZkt+hWyyzyWdy8Bu6s26oMAJzkEnQpmUmeyFnFofRpdzzr6qulaUERiC4BjZGjwS4
	 H1dx0d5iQihaqxuBKDn5dk9JapnqyRd9vy3tF/udsD84IL+02QLy+cU877sd8qFben
	 cgXN9uUqATj/4D9nRnxZEyyHrRTV9tLpEc/Gs18Nn1awr+21QGcN86nQrOULK88HBy
	 qrKXDgT6pjgyPI5brUJ3qSNDk542vMg3tq07aFy/gsIHC5ltWHjKnRY3uGFMR4n0t1
	 T0Z5QnKVykDVg==
Subject: Re: [PATCH can-next v2 9/9] selftests: can: check SO_J1939_PROMISC
 receive effect
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 05:35:26 +0000
Message-ID: <179394332621.488853.1609910990759756381@kernel.org>
In-Reply-To: <20261104-j1939-selftests-v2-9-cf797c83317b@pengutronix.de>
References: <20261104-j1939-selftests-v2-9-cf797c83317b@pengutronix.de>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In TEST_F(j1939_opts, promisc_receive)
  (tools/testing/selftests/net/can/test_j1939_opts.c), the post-promisc…

--

selftests: can: check SO_J1939_PROMISC receive effect

This adds a J1939 selftest that checks SO_J1939_PROMISC changes what the
RX path delivers. It sends two probe frames, each missing either the bound
address or the bound PGN, once before and once after enabling the flag.
Only the frames sent after enabling the flag are expected to arrive.

> diff --git a/tools/testing/selftests/net/can/test_j1939_opts.c b/tools/testing/selftests/net/can/test_j1939_opts.c
> index 10d0e37984027..bbf2698de7d94 100644
> --- a/tools/testing/selftests/net/can/test_j1939_opts.c
> +++ b/tools/testing/selftests/net/can/test_j1939_opts.c

[ ... ]

> +static const struct {
> +	uint8_t da;
> +	pgn_t pgn;
> +} promisc_probes[] = {
> +	{ SA_RX, PGN_B },	/* the bound address, another PGN */
> +	{ SA_OTHER, PGN_A },	/* another address, the bound PGN */
> +};
> +
> +/* SO_J1939_PROMISC delivers frames that do not match the bound (addr, pgn). */
> +TEST_F(j1939_opts, promisc_receive)
> +{
> +	uint8_t tx_buf[CAN_MAX_DLEN];
> +	uint8_t rx_buf[CAN_MAX_DLEN];
> +	int enable = 1;
> +	size_t i;
> +
> +	fill_pattern(tx_buf, sizeof(tx_buf));

[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(promisc_probes); i++) {
> +		ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
> +					    self->ifindex, J1939_NO_NAME,
> +					    promisc_probes[i].da,
> +					    promisc_probes[i].pgn))
> +			TH_LOG("sendto probe %zu failed: %d", i, errno);
> +		EXPECT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
> +				       J1939_NEG_RECV_TIMEOUT_MS), -1)
> +			TH_LOG("probe %zu was received without promisc", i);
> +	}

[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(promisc_probes); i++) {
> +		ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
> +					    self->ifindex, J1939_NO_NAME,
> +					    promisc_probes[i].da,
> +					    promisc_probes[i].pgn))
> +			TH_LOG("sendto probe %zu failed: %d", i, errno);
> +		EXPECT_TRUE(recv_verify_ok(self->rx, tx_buf, sizeof(tx_buf),
> +					   J1939_RECV_TIMEOUT_MS))
> +			TH_LOG("probe %zu not received despite promisc", i);

[Severity: Low]
Can this check confirm that the message it read is really
promisc_probes[i]?

tx_buf is filled once by fill_pattern(), so all four frames carry the same
payload. recv_verify_ok() passes src = NULL, and recvfrom_verify_ok() in
j1939_tests.h only checks the length and the payload:

tools/testing/selftests/net/can/j1939_tests.h:recvfrom_verify_ok() {
    ...
	ok = n == want_len && !memcmp(want, rx_buf, len);
    ...
}

This means a stale or duplicated message in the rx queue can pass the
check for a different probe. For example, on a buggy kernel:

1. The pre-promisc probe 1 ({SA_OTHER, PGN_A}) gets delivered after the
   300 ms J1939_NEG_RECV_TIMEOUT_MS window, so the
   EXPECT_EQ(recv_timeout(...), -1) check still passes.

2. Post-promisc probe 0 then reads that stale probe 1 message and passes.

3. Post-promisc probe 1 reads the real probe 0 and passes, even if
   promisc never delivered probe 1.

Both the leak before promisc and the missing delivery after promisc would
go unnoticed. A kernel that delivers duplicates could hide a missing probe
in the same way.

Under normal timing this does catch the regression the commit message
targets (flag stored but ignored), because every post-promisc
recv_verify_ok() times out.

The v2 notes say the test should "check the address and the PGN filter
each on its own". The kernel reports the PGN in msg_name, and the two
probes use different PGNs. Could the post-promisc loop call
recvfrom_verify_ok() with a struct sockaddr_can and check that
src.can_addr.j1939.pgn matches promisc_probes[i].pgn? Giving each probe
its own payload would work too.

> +	}
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-j1939-selftests-v2-0-cf797c83317b%40pengutronix.de
