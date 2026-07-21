Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC62571B8
	for <linux-can@vger.kernel.org>; Tue, 21 Jul 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645662; cv=none; b=TJwDQHklO/GXTXZlN0zwygHA0Tq7IKkDFhRbYwodoIznLPLrIiB76YHXd0r89PDORqLVjAufq4HMNUtsNSkv0v8FxLJNLdT2L/hoqfWdG/Ga84mc4lUY/NPrhO4MpogB69ZGn97Dn4w7Kpr48Is0uk8+OLMifC0Fjn2SzSk8Qko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645662; c=relaxed/simple;
	bh=rqH/q1Cb0+PK+92u6bK/OMThfcQitU50nDxppH/N5IY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FOxzlIwl3vd5rUlO4lZ9dHw+1fsAYIM2KOCvYkXI5zK8a2EkaSWijTNrphVGAqaqLc9Egw+Htvxbk7Ecx/P1hW8neWkS1j3uTdw2b1WdR+sCSoJpy9lHm7rA+rfXLp39HFPBaGWv8wgYn22OfJX7uDLz1tHFzrWuBX3SSEL3K0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DapM1S7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DapM1S7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2371F000E9;
	Tue, 21 Jul 2026 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784645660;
	bh=L1/1Q65PvRHtquZVfeataD3BYZc8d7iNnpUVtE4BS6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DapM1S7ZuV7g7iVMig8emO/SsQZA+/j+JDXWLBCT7Zx8q3GAOAXu9fK1/XvZrNwLP
	 vz63vtZq0hu93Y+FHZx3P/A/LsYQpFsRCAfUHGBKwwV/u5db2RIJhuyQfr/T71f4R0
	 kICIF6q1clHONVvWbFDahVa/Sn08byS7ydnFdl8rwUhu6V3kETnqfSfceCSSBMRQT0
	 V+yp4K9JHZ4f3FZV9sNXPHCXrJs1EFkHsGGfxx92jc5l/y1lJs5tCwpuXq3N5Eq6vg
	 dwvqp/IiZuu8Ma1pg4pfK3xguRV07fhNoUSdaG1rT3GKCS2z0Jd86fdJbMKwjEPx1Q
	 1Bb1+Dxokmnxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260721143727.29459-1-socketcan@hartkopp.net>
References: <20260721143727.29459-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:54:19 +0000
Message-Id: <20260721145420.3C2371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing acquire barrier in wait condition allows stale read of tx_=
result, spuriously failing transmissions.

Pre-existing issues:
- [High] Invalid Flow Control frames abort the transmission but falsely rep=
ort success to the sender.
--

--- Patch [1]: [PATCH v8] can: isotp: fix timer drain order, wakeup handlin=
g and tx_gen ordering ---
commit 2db87f7eca662e755db3d9c7c9c258bea453c5f2
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

This patch addresses multiple findings in the CAN ISOTP subsystem
regarding timer drain order, wakeup handling, concurrent transfer
generation tracking, and error reporting.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..6b3d4a429042e 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
[ ... ]
> @@ -450,11 +507,15 @@ static int isotp_rcv_fc(struct isotp_sock *so, stru=
ct canfd_frame *cf, int ae)
>  		sk->sk_err =3D EMSGSIZE;
>  		if (!sock_flag(sk, SOCK_DEAD))
>  			sk_error_report(sk);
> +		tx_err =3D EMSGSIZE;
>  		fallthrough;
> =20
>  	default:
>  		/* stop this tx job */
> -		so->tx.state =3D ISOTP_IDLE;
> +
> +		isotp_set_tx_result(so, so->tx_gen, tx_err);

[Severity: High]
This is a pre-existing issue, but does this code falsely report success
when an invalid Flow Control frame is received?

If the Flow Status is invalid (not CTS, WT, or OVFLW), it hits this
default case where tx_err is still its initial value of 0. It seems
this will store 0 (success) in tx_result and cause the sender to believe
the payload was successfully transmitted when it was actually aborted
due to a protocol violation.

> +		/* set to IDLE after publishing tx_result */
> +		smp_store_release(&so->tx.state, ISOTP_IDLE);
>  		wake_up_interruptible(&so->wait);
>  	}
>  	return 0;
[ ... ]
> @@ -1223,20 +1306,49 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
[ ... ]
>  	if (wait_tx_done) {
> -		/* wait for complete transmission of current pdu */
> -		err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_I=
DLE);
> +		/* wake up for:
> +		 * - concurrent sendmsg() claiming a new transfer
> +		 * - complete transmission of current PDU
> +		 * - shutdown state change in isotp_release()
> +		 */
> +		err =3D wait_event_interruptible(so->wait,
> +					       READ_ONCE(so->tx_gen) !=3D my_gen ||
> +					       /* read pairs with the tx_result writers, SMP-safe */
> +					       smp_load_acquire(&so->tx.state) =3D=3D ISOTP_IDLE ||
> +					       READ_ONCE(so->tx.state) =3D=3D ISOTP_SHUTDOWN);

[Severity: High]
Can this short-circuit evaluation skip the smp_load_acquire() barrier?

If a concurrent thread has already claimed the next transfer,
READ_ONCE(so->tx_gen) !=3D my_gen evaluates to true. The condition then
short-circuits, completely bypassing the smp_load_acquire() on so->tx.state.

Without this acquire barrier, can weakly-ordered CPUs speculatively execute
the subsequent read of tx_result inside isotp_get_tx_result() before the
read of tx_gen?

isotp_get_tx_result(struct isotp_sock *so, u32 gen) {
    u32 result =3D READ_ONCE(so->tx_result[gen % ISOTP_TX_RESULT_SLOTS]);
    if (isotp_get_tx_gen(result) !=3D gen) {
        ...
        return -ECOMM;
    }
}

If so, this might read the stale result of my_gen - 4, failing the internal
generation check and causing a successful ISOTP transfer to spuriously
return -ECOMM to the user.

>  		if (err)
>  			goto err_event_drop;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721143727.2945=
9-1-socketcan@hartkopp.net?part=3D1
