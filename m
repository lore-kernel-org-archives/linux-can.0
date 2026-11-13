Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549722;
	b=RlxAb1srSZIwl++H/itknZLij6hE9oq6pDIenHze1fYV3cuYJkjh2nL30gU9lZVDVlPh
	 wlYTEEAPJIdGh+2fK2VtkWfk/camGVYoWILgdAJ0BkroVU2xMyaZbRJMSTkUtRYJnwxMh
	 aMKQgKaUTHgvrzbH0pSymM24loyS2PrAA8ZfiJlSUmzYv6Y1A1e1O03QyP6yyBdAAWRC0
	 t9ecTiPpJpjYUe+jSpcKGUdlNw/zdfPSlQ/GYp0y7QVX5+h+oFjwe49xVb2F83ywBUNa4
	 I9/q1vaQ/aUS2gOlvCorL86rM/u7WriCMP+kGkgTfyV9jz7WpTMMD1IoCedk++sxokA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549722;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=K6zvnGY0P5T8jnGAmz9FIeINh2PuUNO8zJULkiDNf70=;
	b=IbkE1BMLYB1nVW9C4pWXmfe4f38I28YH9cQUaFGCvtL6DpuaT2mLx3vh9rsey/csBQ9I
	 31IljpQno7cwPIa5POHWDqciOjSEkJWcEwMD5Dc1/fmg+cr8dc41sWeDZ0mZiSh6asee9
	 8vyLMd2upChN0XCmnA9peZz5NpQw6Z2KQlcAeS6EHlF/7uYZR2Jrex+CAlhAdMfPM40QB
	 DEd3OwyZUy1cUy5T+0XcTBSkZa3jOlkebnaCdjIJ9EA8gYX086wG5VMc0iHSygkJRk0XX
	 qHLnmsLpDShNtP+koKg5hYSZZFMdfnL5zY3hqNWwQ42aV0GqeT+qHH4T1XS3N6mx70Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyAXp5uA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6E606A332;
	Fri, 13 Nov 2026 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyAXp5uA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0471F000C4;
	Fri, 13 Nov 2026 06:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549721;
	bh=K6zvnGY0P5T8jnGAmz9FIeINh2PuUNO8zJULkiDNf70=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UyAXp5uAA9aD3d09sHc2mbObqLWVBCeZttnGKHwNNL2ZfxY0uZqw7n12T/GZUqR41
	 hT/ikaz0/7RT1JjemMgUQz7jhD0qE7vi7B8FNCdi0rTRSx2saYJuelMlpJvE/wRbE2
	 OsbSNcWg+CZpSXRcr93oNYvPlsPKNOZUyWNG5fe1zK0lASluIZNiyLaY75m20MgyxX
	 5H/qWOW8madhKfPj3ru7o5dw4ReqfCJ+s7rPuAP8dyeGVHvynX7jQ/I+U/dCfd0H4u
	 a3prc4t3FjHnGnfCp/ns6bHFkvPLjGAsZJMaxVtgISyJanXgpp7/l0Q+RyYfVtSdld
	 RiAVAfzTa99tQ==
Subject: Re: [PATCH can-next v3 4/9] selftests: can: add J1939 socket option
 and metadata tests
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 13 Nov 2026 06:02:00 +0000
Message-ID: <179454972067.488853.7526857184540815405@kernel.org>
In-Reply-To: <20261111-j1939-selftests-v3-4-5a80277ab363@pengutronix.de>
References: <20261111-j1939-selftests-v3-4-5a80277ab363@pengutronix.de>
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

- [Low] In TEST_F(j1939_opts, filter_pgn)
  (tools/testing/selftests/net/can/test_j1939_opts.c), the check that…

--

selftests: can: add J1939 socket option and metadata tests

This adds a J1939 selftest that checks socket options and send metadata.
It covers the SO_J1939_SEND_PRIO priority seen on the wire through a
CAN_RAW peer, getsockopt round-trips, the SO_J1939_FILTER PGN whitelist,
unconnected sendto(), a wrong-family bind() and the SO_J1939_ERRQUEUE
TX-completion ACK.

> diff --git a/tools/testing/selftests/net/can/test_j1939_opts.c b/tools/testing/selftests/net/can/test_j1939_opts.c
> new file mode 100644
> index 0000000000000..a729e39c0be4f
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_opts.c
> @@ -0,0 +1,309 @@

[ ... ]

> +/* SO_J1939_FILTER whitelists PGN_A; PGN_A is received, PGN_B is dropped. */
> +TEST_F(j1939_opts, filter_pgn)
> +{

[ ... ]

> +	/*
> +	 * PGN_B must be dropped by the filter. Send PGN_A after it and read it
> +	 * back: a PGN_B that got through is read before PGN_A or is still
> +	 * queued after it.
> +	 */
> +	ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
> +				    self->ifindex, J1939_NO_NAME, SA_RX, PGN_B))
> +		TH_LOG("sendto PGN_B failed: %d", errno);
> +	ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
> +				    self->ifindex, J1939_NO_NAME, SA_RX, PGN_A))
> +		TH_LOG("sendto PGN_A failed: %d", errno);
> +	ASSERT_TRUE(recvfrom_verify_ok(self->rx, tx_buf, sizeof(tx_buf),
> +				       J1939_RECV_TIMEOUT_MS, &src))
> +		TH_LOG("PGN_A after PGN_B was not received");
> +	EXPECT_EQ(src.can_addr.j1939.pgn, filt.pgn)
> +		TH_LOG("PGN_B was received before PGN_A");
> +	EXPECT_EQ(recv(self->rx, rx_buf, sizeof(rx_buf), MSG_DONTWAIT), -1)
> +		TH_LOG("PGN_B was received but should have been filtered out");
> +	EXPECT_EQ(errno, EAGAIN);
> +}

[Severity: Low]
Do the two looped-back frames always reach the rx socket in send order?
The comment above assumes they do, and so does the v3 changelog entry
"check that the filter drops PGN_B with an ordering barrier, not a
timeout".

The J1939 session queue serializes the two transmissions. Each frame is
then sent from the session's hrtimer:

j1939_tp_txtimer()->j1939_simple_txnext()->j1939_send_one()->can_send()

On vcan without IFF_ECHO, can_send() in net/can/af_can.c loops the frame
back with:

	if (newskb)
		netif_rx(newskb);

This puts it on the backlog of whichever CPU is running at that moment.

If PGN_A is already queued, j1939_sk_queue_activate_next_locked() starts
its timer from the PGN_B timer's softirq. It normally stays on the same
CPU, so the order holds in that case.

If the PGN_B session has already ended before sendto(PGN_A), the PGN_A
session starts from sendmsg on the test task's current CPU. Suppose the
task has moved to another CPU and NET_RX on the first CPU has been
deferred, for example to ksoftirqd or on PREEMPT_RT. Could PGN_A then be
delivered first?

In that case recvfrom_verify_ok() returns PGN_A. The recv(MSG_DONTWAIT)
then returns -1/EAGAIN before a PGN_B that wrongly passed the filter has
been queued.

This can only give a false pass when SO_J1939_FILTER is broken, never a
false failure. Should the comment and the changelog say less about
ordering, or is there a stronger ordering guarantee the test can rely
on here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-j1939-selftests-v3-0-5a80277ab363%40pengutronix.de
