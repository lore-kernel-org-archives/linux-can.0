Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943321;
	b=qhp0okjvLbL33Znqd+6l25lWMGtn4BMxcezJVwJAxSjPiEdZLDNmJ4El87MR48tw7nZ9
	 8dhuQ3FmtNwGd2pQDV0S37YPBzAdiy7UEfy6gl6K1sp2jLd3umAtYEMhxO9qUW8LTxncV
	 sCJAYmI5mkLWVMxpjJo2SmGj4vKNLyGPvuPwBKixj/jrM6qhDXzzUnp1u8lFp6mSS6j/V
	 5h9XltXw+x4MUlzk0J7hTRfzgv+jswajFxHMIEKyNuuteDb75ei7HMTFjR3eOtA51rfuP
	 U39IFAf2Sb9cXQnAfZIOIdCJNmRZUM9TOnP38hy8bckoje9sXaXSHYMaKt+PxAVJ9KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943321;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pX+NvG8+Kj0J1k2J8K2rs6MLsIUkVgGLa6ndvTHhW3w=;
	b=R0R0oEwuel+olwJ5T8nFmVTqOeBDmLxK09fLNckJh8YBv/bxeKc/KV+j+IWGDc2E+gTk
	 zbEFX0p6ZUotWuSYgfPlNSbGhXUcplxRx55QP2OjvbYRAYG+mOI5oDgZwLMTXRawuz38T
	 I5UG3JlLbYju3jYcfH74TgNQ5wXMXMObryy/Dc0+G/6ccP6OfUHitUs2ZHH5UemDlvqMJ
	 Q2RWYpemMnJyXbOVHvnN2eU9HyBDUnRE+kBkpb6A1rIa3L7HYYJN3KaHIuF+IbSlh5X+3
	 5ipMtGK+2wu/yDyT+vxAr2LtteIxJp80so0g8DVdfq5tO2/yNTqRPwlF65Q94/H+I5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olGuOgYN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93B3606A331;
	Fri,  6 Nov 2026 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olGuOgYN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B525B1F008A1;
	Fri,  6 Nov 2026 05:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943320;
	bh=pX+NvG8+Kj0J1k2J8K2rs6MLsIUkVgGLa6ndvTHhW3w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=olGuOgYN4aR9a968WbIjAySkVeCpR8qDz2lKZ5W6UcoG5UUrZ/9fOqlaKfM8st5v9
	 niO1N/rQHoWuhVStsdQY6IVuiqubwcTSdNVvO5WhQrqYGTeET2LfjNv6bLK+aEvq9d
	 I4XRv4JkXyRtcWowgyWZB13YAyohHHSpzVLP5vTmCHbnSsb/OKG2L4XBQiqTWIR+ip
	 hvqkZr8JPRUfanRJZ/nhgEg8Dt3qjrOLbJ2oWNQXun2NE1P7nxWzi7m4g36Gw4x9v7
	 SL3Pc7ERJyFyMlh2Lou+AO/cZeozGjhP0jy8LIhE1Q+U9uxfH/O8GaB5DiBlb7SwDB
	 tj8e7pNitDq9w==
Subject:
 Re: [PATCH can-next v2 3/9] selftests: can: add J1939 base functional tests
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 05:35:19 +0000
Message-ID: <179394331932.488853.13385068395595078685@kernel.org>
In-Reply-To: <20261104-j1939-selftests-v2-3-cf797c83317b@pengutronix.de>
References: <20261104-j1939-selftests-v2-3-cf797c83317b@pengutronix.de>
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

- [Low] The `bam_broadcast` test in
  tools/testing/selftests/net/can/test_j1939_base.c sends a TP_SIZE…

--

selftests: can: add J1939 base functional tests

This adds a selftest for the SAE J1939 socket interface. It opens a CAN_J1939
sender socket and a receiver socket on vcan. It checks payload integrity for
single frame, TP and ETP sizes, the boundaries between them, and single-frame
and BAM broadcast.

> diff --git a/tools/testing/selftests/net/can/test_j1939_base.c b/tools/testing/selftests/net/can/test_j1939_base.c
> new file mode 100644
> index 0000000000000..d01f4c2c186cb
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_base.c

[ ... ]

> +static bool roundtrip_ok(FIXTURE_DATA(j1939_base) *self, size_t size)
> +{

[ ... ]

> +	errno = 0;
> +	ok = send_recv_verify_ok(self->tx, self->rx, tx_buf, size,
> +				 J1939_RECV_TIMEOUT_MS);

[ ... ]

> +/* BAM (broadcast transport). */
> +TEST_F(j1939_base, bam_broadcast)
> +{
> +	ASSERT_TRUE(pair_up_ok(self, SA_RX, J1939_NO_ADDR, PGN_PDU2, true));
> +	EXPECT_TRUE(roundtrip_ok(self, TP_SIZE));

[Severity: Low]
Is J1939_RECV_TIMEOUT_MS long enough for the whole BAM transfer in
bam_broadcast?

roundtrip_ok()->send_recv_verify_ok()->recvfrom_verify_ok() waits with a
single poll() for the fully reassembled message:

tools/testing/selftests/net/can/j1939_tests.h:recvfrom_verify_ok() {
    ...
	if (poll(&pfd, 1, timeout_ms) > 0)
		n = recvfrom(s, rx_buf, len + 1, 0, (struct sockaddr *)src,
			     &src_len);
    ...
}

The kernel paces broadcast transport at a fixed 50 ms. The first delay comes
after the BAM CM frame:

net/can/j1939/transport.c:j1939_session_tx_rts() {
    ...
	if (dat[0] == J1939_TP_CMD_BAM) {
		j1939_tp_schedule_txtimer(session, 50);
    ...
}

Every broadcast DT frame except the last one adds another 50 ms:

net/can/j1939/transport.c:j1939_session_tx_dat() {
    ...
		pdelay = j1939_cb_is_broadcast(&session->skcb) ? 50 :
			j1939_tp_packet_delay;
    ...
}

TP_SIZE is 128 bytes, which is 19 DT packets. So delivery can't finish in
less than about 50 + 18 * 50 = 950 ms. send() returns once the session is
queued, so the poll() starts at about the same time as the session. That
leaves about 1050 ms of the 2000 ms as headroom for a slow VM.

The comment in j1939_tests.h describes the timeout as a wait for one frame:

/*
 * How long to wait for an expected frame. Not a protocol timer: a guess with
 * room for a slow VM.
 */
#define J1939_RECV_TIMEOUT_MS	2000

For BAM, though, it limits the whole message, and about half of it goes to
the protocol's own pacing.

Could this fail spuriously on a loaded KASAN or lockdep QEMU-TCG runner, where
the soft hrtimers that drive the 19 packets are deferred to ksoftirqd?

The timeout also doesn't grow with the message size. If TP_SIZE were raised
above about 280 bytes (more than 40 BAM packets), wouldn't bam_broadcast fail
every time?

The unicast TP and ETP tests aren't affected, since j1939_tp_packet_delay
defaults to 0. J1939_RECV_TIMEOUT_MS, its comment, and the bam_broadcast size
are unchanged at the end of the series.

Would it make sense to scale the timeout with the number of BAM packets, or
to use a separate, longer timeout for broadcast transport?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-j1939-selftests-v2-0-cf797c83317b%40pengutronix.de
