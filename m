Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E78B3603EE
	for <linux-can@vger.kernel.org>; Tue, 21 Jul 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640220; cv=none; b=mXAckyTJeunAQ2qqnAKHVpaJTDoxYoknrekHsMKaE9+GvyTQVpUASlMLU51m8PcO8DL7mIjOq2KNDJI00aGXe3OOxyAEZAEQm1TrRB0JLxk9gN2rfoAg+GFfgIcZgWCIadioFHM2wPtimh6CERdLIWOIAw3Eg09ADfHMY7fzTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640220; c=relaxed/simple;
	bh=odvM+mck3qUOLaRCTu089UsumQ06zmD2e6HFNi898m0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=erg5IDp/m/metDiFOQoDUqolJWttN+L1tfoR68UORwgnDII5/5bZsEvejAlQvyjycYsc8V+TD5t1v1c1ophJsn2VPra95LAcPAaApYwmL/zPobtv34b8vOvqFzjI0WbOHNHtgXf89gPX4xArUBeJTaKrI5KqVCedI1wz+Lna9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKZ2cnVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKZ2cnVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C943C1F000E9;
	Tue, 21 Jul 2026 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784640219;
	bh=9tO3eqOYttMp102MFeZzbjqFYA52/irXve/SCi+Vd2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hKZ2cnVc++RIW7QGrx3gC0AyMS0gkJPLgjN0DJPyYP3QvLd+dm0eEo8NXM14booeU
	 nqMBrydSVAqk43T2ZYI3M1VDl3x+Tkrm62eK8Rqfttn9qO1WG99buAwak+hywgOdna
	 PFWIxg99W49OtvGPK1MgdV3PFHvflUauW3j2E8NbjabwQRX8GkxmWPYKFzaNG/PTGX
	 W/GAeQlc6u/tFo2jB4IGtDvGJiO/WMpi+6hcDlAZay3Dx9O9X8Te5thpupPEpP6p2J
	 VpF7TVzk2MQQgOsP5dysXdcPK4mZlgZ03byLgPrdtcGQI4bhdCDb7Lb9ng8cyYo+Xq
	 JTtyFtoMtqYtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260721130739.25415-1-socketcan@hartkopp.net>
References: <20260721130739.25415-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 13:23:38 +0000
Message-Id: <20260721132338.C943C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data race and missing memory barriers in lock-free tx_result deliv=
ery causing false transmission errors
--

--- Patch [1]: [PATCH v7] can: isotp: fix timer drain order, wakeup handlin=
g and tx_gen ordering ---
commit 542b44e72848ff961294d256e29571f2a35141b8
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can: isotp: fix timer drain order, wakeup handling and tx_gen orde=
ring

This commit aims to fix timer drain order, wakeup handling, and tx_gen
ordering in CAN ISOTP. It aligns lock-free state accesses and tracks per
generation transmission results.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..29a4db93876da 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -899,32 +963,33 @@ static void isotp_rcv_echo(struct sk_buff *skb, voi=
d *data)
[ ... ]
>  	if (so->tx.idx >=3D so->tx.len) {
>  		/* we are done */
> -		so->tx.state =3D ISOTP_IDLE;
> +		isotp_set_tx_result(so, so->tx_gen, 0);
> +		WRITE_ONCE(so->tx.state, ISOTP_IDLE);

[Severity: High]
Does this code need a memory barrier between setting the tx_result and
updating the state?

Without an smp_wmb() (or smp_store_release()) between writing the result
and setting the state to ISOTP_IDLE, could CPU reordering expose the IDLE
state prematurely? This might cause waiting threads to read a stale tx_resu=
lt
before it is properly updated.

>  		wake_up_interruptible(&so->wait);
>  		goto out_unlock;
>  	}

[ ... ]
> @@ -965,14 +1034,12 @@ static enum hrtimer_restart isotp_tx_timeout(struc=
t isotp_sock *so)
>  	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) !=3D old_state)
>  		return HRTIMER_NORESTART;
> =20
> -	/* we did not get any flow control or echo frame in time */
> +	/* detected timeout: report 'communication error on send' */
> +	isotp_set_tx_result(so, gen, ECOMM);

[Severity: High]
Because the state is explicitly changed to ISOTP_IDLE via cmpxchg() before=
=20
isotp_set_tx_result() is called, is it possible for a thread waiting in=20
isotp_sendmsg() to wake up when it sees ISOTP_IDLE and read an uninitialize=
d=20
or stale tx_result?

> =20
> -	if (READ_ONCE(so->tx_gen) =3D=3D gen) {
> -		/* report 'communication error on send' */
> -		sk->sk_err =3D ECOMM;
> -		if (!sock_flag(sk, SOCK_DEAD))
> -			sk_error_report(sk);
> -	}
> +	sk->sk_err =3D ECOMM;
> +	if (!sock_flag(sk, SOCK_DEAD))
> +		sk_error_report(sk);

[ ... ]
> @@ -1223,20 +1299,48 @@ static int isotp_sendmsg(struct socket *sock, str=
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
> +					       READ_ONCE(so->tx.state) =3D=3D ISOTP_IDLE ||
> +					       READ_ONCE(so->tx.state) =3D=3D ISOTP_SHUTDOWN);
>  		if (err)
>  			goto err_event_drop;
> =20
> -		err =3D sock_error(sk);
> -		if (err)
> -			return err;
> +		/* still our claim, but isotp_release() force-shut it down */
> +		if (READ_ONCE(so->tx_gen) =3D=3D my_gen &&
> +		    READ_ONCE(so->tx.state) =3D=3D ISOTP_SHUTDOWN) {
> +			err =3D -EADDRNOTAVAIL;
> +			goto err_event_drop;
> +		}
> +
> +		/* either our own claim completed normally, or so->tx_gen has
> +		 * since moved on to a new transfer - either way, our result
> +		 * is whatever isotp_get_tx_result() finds recorded for
> +		 * my_gen's so->tx_result[] slot
> +		 */
> +		err =3D isotp_get_tx_result(so, my_gen);

[Severity: High]
Does this read path also need a memory barrier?

When isotp_get_tx_result() reads the result after waiting, it does so witho=
ut a
subsequent smp_rmb() (or smp_load_acquire()) after checking tx.state. Could=
 the
CPU reorder and execute the read of tx_result before tx.state is actually
confirmed as ISOTP_IDLE? This might lead to isotp_sendmsg() reading a stale
tx_result on a successful transmission.

> +		return err ? err : size;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721130739.2541=
5-1-socketcan@hartkopp.net?part=3D1
