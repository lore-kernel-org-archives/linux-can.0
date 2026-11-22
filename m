Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795313050;
	b=bYM8itCz/OW5QrTXAahnINHH01gu6sB//IhI8nLkmq4tKzaXBS9jqOvay8qAuljnejDu
	 /2zw8Je9xN7rZpSwg73YK2zyOqfxp1QRHPMbGqN1FHw6ksViyBm2Lax6172GDyGFigdi5
	 fCuekRqDZyCWbO3iV7kgWvFnOAJ/GHDw7vMSb6F2eNYon/syqCC6u6ziitCGUNRJbyesB
	 77JumArLQEWZT8UY3Fl2mKgUvJSQLNHtxC3kkKBPB14gaO+5dfzBy9UNGeyv2ZEnDVa0u
	 M3tPSouks/f9uDzJJdxwIQjOganArfkk2+8cf7umYk43kp8SKRPVm1j2hb3ZPjpA0qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795313050;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GcwleLErb+8DsCbFM/+M79somvSj0I0vdveBTlhNMJQ=;
	b=Ed1ixkB4DNOAy0KFD3bd0CL6zguW2noI6ZUKkTlx0u03rr9yHOpv/ioPTgIk8iUn1bh/
	 v4qUeEI5puk+u053vZ6ohjmL2t+KJEZC48Nr3EdByx7cP+XH5CWZgOt9NV4edJ1iLEAAD
	 FONW+aEpMl8d2HyNjaOw0t/QAYlQWmHNt5q2YIW87/Bzuuc77EETIrEE5jpopxaKhUiyq
	 ha0ej6FYnkio7EGMb+47fnkt1ICIGn3K8JhIpvoxTwyAXOdDMolOskm2BR7HOX7aiZkh8
	 6VAKwiPjkCFh6bZUfHRMifmp+WtKE3c/Kxo85zDBk0c+6V5DwRvTyURQt8Q5ZDhErJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXeGVjnP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECBA606A320
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXeGVjnP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF5F1F000C0;
	Sun, 22 Nov 2026 02:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795313049;
	bh=GcwleLErb+8DsCbFM/+M79somvSj0I0vdveBTlhNMJQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZXeGVjnPg3sN8R4T9i5Tnj9y4a6Y933EeAZwtxdsNm4tz2mv9qDQ0WrCgN/ooc1jV
	 CP1zBE90LaRS8AyggksZtFE7PQP38DTpci8Mhx3YLoGgTh+pKk70LZwpLNRAp6OEki
	 a5Na77B/rI3aGUTjs6LLTIi8dTe6Y26Mkv0NRTcEnicxpSG9WtTKC70lfinE14Uk0e
	 HuH4QLrwMsbVEQ8pj3kglTYwk1I7iJ4Sdiic8R9GdlHpCOBcQWeZGxd589a0dXyXGB
	 sCoEnfPhdFhxtt8l/2Sif8qt5mxT5IpVkHGg93vCVPt527ICVnZVhWuyMwoVrswuOW
	 6UELzdQAhzOAg==
Subject: Re: [PATCH v7 6/8] can: isotp: always start the rx timeout in
 ISOTP_WAIT_DATA state
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 mailhol@kernel.org, zhuling0805@qq.com, kuba@kernel.org
Date: Sun, 22 Nov 2026 02:04:09 +0000
Message-ID: <179531304900.3131.6873205153419606406@kernel.org>
In-Reply-To: <20261120-can-bcmlock-memcg-v7-6-f6b84f5257b1@hartkopp.net>
References: <20261120-can-bcmlock-memcg-v7-6-f6b84f5257b1@hartkopp.net>
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

- [Medium] In net/can/isotp.c, isotp_rcv_ff() now arms so->rxtimer for
  ISOTP_FC_TIMEOUT (1 s) as soon as a First Frame is received, and it…

--

can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state

This patch starts the rx timeout in isotp_rcv_ff() and isotp_rcv_cf()
whenever reception continues in ISOTP_WAIT_DATA, so the socket no longer
stays in that state indefinitely when no flow control frame is sent. It
also moves the consecutive frame length checks ahead of hrtimer_cancel(),
so an invalid CF is dropped without stopping the rx timeout.

Closes: https://lore.kernel.org/linux-can/179504035916.3136.12986898667697830880@kernel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 8229b6a69ecd0..0b7db1ead7a90 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -634,6 +634,10 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
>  	so->rx.sn = 1;
>  	WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
>  
> +	/* start rx timeout, isotp_send_fc() restarts it */
> +	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> +		      HRTIMER_MODE_REL_SOFT);
> +
>  	/* no creation of flow control frames */
>  	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
>  		return 0;

[Severity: Medium]
Could this abort valid transfers on a CAN_ISOTP_LISTEN_MODE socket?

In listen mode isotp_send_fc() is never called, so nothing restarts this
timer before the first CF. That means the listener's window for the
first CF is 1 s counted from the FF, not from the real receiver's FC.

The listener also never sees the real receiver's FC frames. isotp_bind()
sends only rx_id to isotp_rcv(). tx_id goes to isotp_rcv_echo(), which
drops anything that is not its own echo:

net/can/isotp.c:isotp_rcv_echo() {
    ...
	/* only handle my own local echo CF/SF skb's (no FF!) */
	if (skb->sk != sk)
		return;
    ...
}

The real peers can legitimately use a longer FF to first CF gap. The
Linux sender re-arms its timer for each FC.WT:

net/can/isotp.c:isotp_rcv_fc() {
    ...
	case ISOTP_FC_WT:
		/* start timer to wait for next FC frame */
		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
			      HRTIMER_MODE_REL_SOFT);
    ...
}

The receiver's N_Cr window also starts when it sends its FC, not when
the FF arrived. So a transfer with one or more FC.WT frames, or with a
slow FC followed by a slow first CF, can have a gap of more than 1 s
and still be compliant.

In that case the sequence would be:

isotp_rcv_ff()
    WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
    hrtimer_start(&so->rxtimer, 1 s)
    return 0 (listen mode, no FC)

  real receiver sends FC.WT (not visible to the listener)

isotp_rx_timer_handler()
    sk->sk_err = ETIMEDOUT;
    WRITE_ONCE(so->rx.state, ISOTP_IDLE);

isotp_rcv_cf()
    if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
        return 0;

Each CF of that PDU is then dropped, so the listener reports ETIMEDOUT
and loses a PDU that both real peers completed. Before this patch, the
listen-mode socket stayed in WAIT_DATA without a timer between the FF
and the first CF, so such a PDU was still reassembled.

The commit message says:

  In listen mode a first frame that is not followed by consecutive
  frames now leads to ETIMEDOUT, like a missing consecutive frame inside
  a block already does.

A gap inside a block does not include the FC round trip, but the FF to
first CF gap always does. The message does not mention that slow but
compliant transfers are now aborted for listen-mode users, and the
patch is tagged for stable.

Would it make sense to use a longer timeout for the listen-mode FF case,
or at least to describe this trade-off in the commit message? The later
patch in the series ("can: isotp: reject socket options while a transfer
is active") does not change this behaviour.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1%40hartkopp.net
