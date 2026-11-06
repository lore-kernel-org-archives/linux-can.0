Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943325;
	b=rU1L/wWc1tF4jVyo05E0JsPM2iBjTmhIxY2RX6yzKFPJM3kE4wJ+8cGbJTUCjsE6e8u5
	 nNLFwY9fNaEaiqfllBju1fyGcj7DjEGecXYdpgVp7gILISuLlbf0kec9bRj6pxum6wZR3
	 rrT0glPtEz/6SgWT30EsNnFVubfUtMFIGBjw4Emx9TWwP6j+K1ie51OcOKj5kON8zpJ9e
	 F9XgUv/DgKZz2jIBV9SpRY1KhJJo6AHiFyX8tmnIJ2ZWg1qtny/8rERW7UGp71g9LaZYb
	 Ka3rYBa/fEt+phmUX5TE1SRpVm3oMIa5jd1KnLfKJLszSisQLpLgVyehLLRodSx6wYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943325;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kmhmbn/3qV62eiFcovjYbHaz+ip5hZqUymUAJDjYxNA=;
	b=12MTUy1smdIC3I8odMC92GsSLZ6gvx6A568Lj24cT9Jnsa3v8foDjI6QDdU14i5PNMTJ
	 thSuh1RoMb+qbVjYsIlrca3SxmIl9/0LhL4u2v8gHMlP4Y8OoYu8Wv7ZxfpOUC1qDxG5s
	 EFEKtpMYwxpuhdGtxgwv8hPcZTOVoPHKB049pCU3W9P0RoRxvmu7AvDONZpW9llCtiphT
	 6B4io477+BSjNZF9WDiXmIHUcTgq6zh3bq69Gj579frlMPYyGSs1NGOiAx117vw5rAKZ6
	 y+8OgDkloIm4sDPy8K6PLNQsqTffDOHsEpJPiIOPZw1eUHFwbxKVrtzUO6bskcrTrXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV4eQLrm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE386606A338;
	Fri,  6 Nov 2026 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV4eQLrm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42471F008A2;
	Fri,  6 Nov 2026 05:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943324;
	bh=kmhmbn/3qV62eiFcovjYbHaz+ip5hZqUymUAJDjYxNA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BV4eQLrm5xaeODWv7XZtr9gQWi6hXW9K35jRj2ebj27rnQd9J7WZmZQYdCIxkQqWr
	 XvMvbeL8/3wStYA48zl0O8yO9KbG3vcFRjGPzFnZVVLzmHxq6uhffRdKL/sX4b6CMQ
	 ORXQD2QZeVy4DxBMXP/48/5UVNKMVfC/tXsvEaQfnG6/IiyOHwkMIw538Is8GGsKJD
	 N62goZSWYmxZOBz2HZExfNE9ZuXR1Z1TGAH0lGMW65J/B0cwy2XVqHhqMF4watBgNX
	 b4UPes98teN1BaCKpe+ZU+Qrt7juAZkO81ZmUX2iW/OGM1KNPp9NdJ4jqp89R7miID
	 sNp6jfl/anEcg==
Subject: Re: [PATCH can-next v2 6/9] selftests: can: add J1939 wire-format
 tests against CAN_RAW
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 05:35:23 +0000
Message-ID: <179394332338.488853.9794482304526541146@kernel.org>
In-Reply-To: <20261104-j1939-selftests-v2-6-cf797c83317b@pengutronix.de>
References: <20261104-j1939-selftests-v2-6-cf797c83317b@pengutronix.de>
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

- [Low] The comments on two helpers in
  tools/testing/selftests/net/can/test_j1939_wire.c say more than the…

--

selftests: can: add J1939 wire-format tests against CAN_RAW

This adds a selftest that checks J1939 single frames against a CAN_RAW
socket in both directions, for PDU1 (with the DP bit set) and PDU2. On TX
it checks the CAN id and payload of a J1939 send. On RX it checks the
payload, source address and PGN that the J1939 socket gets for an
injected frame.

> diff --git a/tools/testing/selftests/net/can/test_j1939_wire.c b/tools/testing/selftests/net/can/test_j1939_wire.c
> new file mode 100644
> index 0000000000000..ad542ed241c0b
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_wire.c

[ ... ]

> +/*
> + * Inject one CAN frame from the raw peer and check that the J1939 socket
> + * receives the same CAN_MAX_DLEN-byte payload, from SA_PEER and with PGN @pgn.
> + * Opens the J1939 RX socket into self->j1939 (the fixture teardown closes it).
> + * @bcast selects a broadcast (PDU2) socket and frame; @pgn and @da address the
> + * injected frame.
> + */
> +static bool rx_single_frame_ok(FIXTURE_DATA(j1939_wire) *self, bool bcast,
> +			       pgn_t pgn, uint8_t da,
> +			       const uint8_t payload[CAN_MAX_DLEN])
> +{
> +	struct sockaddr_can src;
> +
> +	if (bcast)
> +		self->j1939 = j1939_open_flags(self->ifindex, J1939_NO_NAME,
> +					       SA_LOCAL, pgn, J1939_OPEN_BCAST);
> +	else
> +		self->j1939 = j1939_open(self->ifindex, SA_LOCAL, pgn);
> +	if (self->j1939 < 0)
> +		return false;
> +
> +	if (!send_raw8_ok(self->raw, PRIO, pgn, da, SA_PEER, payload))
> +		return false;

[Severity: Low]
This isn't a bug, but is the "@bcast selects a broadcast (PDU2) socket
and frame" wording accurate?

In this function, bcast only decides between
j1939_open_flags(..., J1939_OPEN_BCAST), which sets SO_BROADCAST, and a
plain j1939_open().

The injected frame never sees bcast. send_raw8_ok() builds the CAN id
with j1939_canid(), and j1939_canid() picks the PDU class from the PGN
alone:

tools/testing/selftests/net/can/j1939_tests.h:j1939_canid() {
    ...
	/* the destination goes into the PS byte of the PGN field */
	if (J1939_IS_PDU1(pgn))
		id |= da << J1939_ID_PGN_SHIFT;
	return id;
}

The comment above tx_to_raw_send_recv_ok() has the same problem:

 * (the fixture teardown closes it) and connects it to (@da, @pgn); @bcast
 * opens a broadcast (PDU2) socket.

A socket has no PDU class there either. bcast only sets SO_BROADCAST, and
the frame format comes from the connected (@da, @pgn).

All four current callers pair bcast=true with PGN_PDU2 and bcast=false
with PGN_PDU1, so the tests work today. A later caller that goes by these
comments and passes bcast=true with a PDU1 PGN would get a frame with a
destination address, not a broadcast frame.

Both comments are still unchanged at the end of the series, in
"selftests: can: check SO_J1939_PROMISC receive effect".

Could both comments say that @bcast only sets SO_BROADCAST and that @pgn
selects the PDU class?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-j1939-selftests-v2-0-cf797c83317b%40pengutronix.de
