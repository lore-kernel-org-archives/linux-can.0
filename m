Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943322;
	b=np8VL0SgT5E+l+9NzPG93IC82yIIWrR4UUE7W54ANKbA3khfLHPAb+dld2AMvolSW7Gv
	 AbjsTeGnxGIIt0whsRnU+DKAs8wYaPbitlYkAfKknO74ImsrmRPS14z7oun16Brzflogi
	 JAQPoTSQt8xlQS82UptN7OVTaM7Z6F/Pslrah3mZLQxJwl+yQiLAHtUPw1dCy1qiDpHIH
	 9gu8n4Q1FPh+AqCy3sj88EvLSEwyKjXizj0wunFXwhz2XX8PU5GjcJJLDJehjLz+6osIu
	 L3xj+fZwKQsFRKayVaarofbjFJwxuUjaI8V1w6MXkfeHtatj97TrTb/cvWcibi1NDNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943322;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OOYVP+JrH/MejRBr0U9Q78+J6izmVGQ8vTbVJwy+l48=;
	b=Vt86yN67YgwfjtjznafOORIbPoczmliXHnEn/u31EG7NMIO97Qu12mZNF+rPjWhUj62H
	 Mtg6sGxcFTO+owKu32lcBYCntC4WezWQBtTPup2Ah0oTxEda9JB203XyTRC7CShILhiv0
	 ljSGRIs0j7WgF82oG0EUonv1QMpPfp0dGYfRO5j2dFtWMi/qadrvJbmXw/JtnwJbBCArw
	 74I9rH0kabP43HxUSfQ1nrh53pLTssLpZkdAUwfZcvkIB5paXg1pzPJqVF4ZpqT29c2Fa
	 0yxrW2ALzKyUJE4iTPXlR+POBbD6hqSQnerGE0BWVItq0eB0HtmwADIfGDzrZky/xkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXm23sMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F45606A32D;
	Fri,  6 Nov 2026 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXm23sMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1361F008A2;
	Fri,  6 Nov 2026 05:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943321;
	bh=OOYVP+JrH/MejRBr0U9Q78+J6izmVGQ8vTbVJwy+l48=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TXm23sMhPxscBoivAtrSVdhSx00uXma35aHFlXf91bv5PyiOUPNv5tuvzqk6YuI5j
	 vtcVuUpkvL5Yy87pt0ikeQ2EAyYCfaepah0LMHbDlEEOJY2QDNnDx95sAMbTDsRl2A
	 LXvm3TmBnEVJks18YQM9Lx7/SxCnXiuZYld8RY+tMgUfoACyBoRkPrdtMXS36lZu2r
	 7/Lzix2aXglvjULH7mk1+bRaz3HqyW9UhbsAPfQ+vXHtzwqAW+SwjtiIub3M2U6swK
	 MAd8XpoWGwBjlw/J5aLujsdqGkPfWqIp7oB9gsPNvY68h57wXLz/DOMNYoOAAsoKIB
	 pn0T0WKd0hdcQ==
Subject: Re: [PATCH can-next v2 4/9] selftests: can: add J1939 socket option
 and metadata tests
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 05:35:20 +0000
Message-ID: <179394332064.488853.14819383071528044530@kernel.org>
In-Reply-To: <20261104-j1939-selftests-v2-4-cf797c83317b@pengutronix.de>
References: <20261104-j1939-selftests-v2-4-cf797c83317b@pengutronix.de>
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

- [Low] The new selftest treats a kernel setsockopt contract violation as
  expected behaviour, so the test can never catch it.

--

selftests: can: add J1939 socket option and metadata tests

This adds a kselftest for J1939 socket options and send metadata. It
covers the SO_J1939_FILTER whitelist, SO_J1939_SEND_PRIO as seen on the
wire via a CAN_RAW peer, unconnected sendto(), a wrong-family bind,
SO_J1939_ERRQUEUE TX completion, and set/getsockopt round-trips of
several options.

> diff --git a/tools/testing/selftests/net/can/j1939_tests.h b/tools/testing/selftests/net/can/j1939_tests.h
> index 78eb35f5b6b06..639e000ac5e86 100644
> --- a/tools/testing/selftests/net/can/j1939_tests.h
> +++ b/tools/testing/selftests/net/can/j1939_tests.h

[ ... ]

> @@ -671,6 +673,71 @@ static inline bool recv_cm_cmd_ok(int raw, uint8_t want_pf, uint8_t want_da,
>  	return frame->data[J1939_CM_CMD_OFF] == want_cmd;
>  }
>  
> +/*
> + * Enable the error queue of s with SOF_TIMESTAMPING_TX_ACK only: a finished
> + * send then queues one TX-completion ACK, or an abort entry if the session
> + * fails (__j1939_sk_errqueue() in net/can/j1939/socket.c). The kernel reads
> + * these flags when the session ends, so this may come after the send.
> + */
> +static inline bool errqueue_enable_ack_ok(int s)
> +{
> +	int tstamp_flags = SOF_TIMESTAMPING_TX_ACK;
> +	int enable = 1;
> +
> +	/* setsockopt(SO_J1939_ERRQUEUE) returns the flag value, not 0 */
> +	if (setsockopt(s, SOL_CAN_J1939, SO_J1939_ERRQUEUE, &enable,
> +		       sizeof(enable)) < 0)
> +		return false;

[Severity: Low]
Should the test accept this as expected behaviour, or is this a kernel bug
the test should catch?

The comment matches what j1939_sk_setsockopt_flag() in
net/can/j1939/socket.c does today:

net/can/j1939/socket.c:j1939_sk_setsockopt_flag() {
    ...
	lock_sock(&jsk->sk);
	if (tmp)
		jsk->state |= flag;
	else
		jsk->state &= ~flag;
	release_sock(&jsk->sk);
	return tmp;
}

It returns the int that userspace passed in, not 0. For SO_J1939_PROMISC
and SO_J1939_ERRQUEUE that value goes back to userspace unchanged, so a
successful setsockopt() returns 1 instead of 0. A caller that checks
if (setsockopt(...)) will treat that success as a failure.

A negative optval such as -1 also sets the flag and then returns -1. The
caller then sees errno EPERM even though the state has changed.

This kernel behaviour dates back to 2018 (9d71dd0c700999), so this patch
did not introduce it. However, the check above only tests for < 0, and the
comment presents the positive return value as normal.

sockopt_roundtrip() in test_j1939_opts.c does the same:

	if (setsockopt(s, SOL_CAN_J1939, optname, &val, sizeof(val)) < 0)
		return -1;

As a result, getsockopt_promisc and getsockopt_errqueue cannot detect the
wrong return value on the set side. The file header still says they cover
"set/getsockopt round-trips" of these options.

The last patch in the series, "selftests: can: check SO_J1939_PROMISC
receive effect", repeats the pattern in promisc_receive. It uses
ASSERT_GE(setsockopt(...), 0) with a comment saying SO_J1939_PROMISC
returns the flag value (1) on success. No patch in the series changes
net/.

Could j1939_sk_setsockopt_flag() return 0 instead, with the tests checking
for == 0? If not, could the commit message at least say this is a known
deviation from the setsockopt() contract?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-j1939-selftests-v2-0-cf797c83317b%40pengutronix.de
