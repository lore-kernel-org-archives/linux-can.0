Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606412110E
	for <linux-can@vger.kernel.org>; Sat, 25 Jul 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784982693; cv=none; b=So66K4zhmgsr+8Z6lHcLiplcNjh/6URUZEKStzwHlwiWmrnL6CgcNjrpQDCvrXTO8szKUihq0Z6nvejEm5CWC+TI9ySkZ8P0fnkzWR+nzvdfsqIgDc3xYxwLrQIarbqSVzgvOAm67AMSM5KOnPNSJtL7+EVCkxREBoSW3fNGJTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784982693; c=relaxed/simple;
	bh=4eByYShlaH9viDBu4yN4EpiFfSe0VfSpMvIS9JzjNzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uLBPNdDvB45Df4LCjR21ayBzcBPvFgqbffZoSvKEB0qQ1vo9zXMFykHtdfZWb+DwPkkgX2P0YrBZ0/2KoRzm/j6K0+b32KL2z5qmpU4QFoLvPdhrBDqCXx2GXncL1PWD5k3OcBKqGNb/r1g2mcRfQE0bEidhYpmaEnuAk0D9w+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvu2IlZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvu2IlZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BA71F000E9;
	Sat, 25 Jul 2026 12:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784982691;
	bh=wr3L4/DeR1KACoUeOJcKlH3cUBK8HG3F2JO4j58Zh88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gvu2IlZSTaHM/Ws3Odgq8rooWKlayDM3eiR86Y95YoLwOv3+YvfYeG4NjLKOX+kSG
	 rDfEJ+Cs30BOrNjuc96iM1GQmZ9LWxXWQDENbvnitkkhubhrdNkBYbDmKN+JqB+6d9
	 Q5By1mngvYeQzd1xActDpIiOaVTEBcbIiUJ9lxGflu+3Hk6kWUsk4RJ5vuSrbjasuU
	 VIH3X2a4uSQEvT4k83XvHUtU3x+2IGzPXAM4Xx8rdOMXHyP/EhSAfL6OpKjqWRmqcR
	 +LOz67UTgRdz8L/ZQ7i7koCNOSf9K8ceyAV6b7Va6ovnk+c9KKON4b1eDu8HF2Y86b
	 aYLMI+IKor0Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can test v11a] can: isotp: fix timer drain order, wakeup
 handling and tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260725122136.5032-1-socketcan@hartkopp.net>
References: <20260725122136.5032-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 12:31:31 +0000
Message-Id: <20260725123131.87BA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silent loss of asynchronous RX socket errors (e.g., timeouts, malf=
ormed PDUs) due to unconditionally draining `sk->sk_err` and discarding its=
 value in the `wait_tx_done` path.
--

--- Patch [1]: [PATCH can test v11a] can: isotp: fix timer drain order, wak=
eup handling and tx_gen ordering ---
commit d4df2bcefe9b5fda40207ed871b332c12c05bd52
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can: isotp: fix timer drain order, wakeup handling and tx_gen orde=
ring

This commit addresses several issues in the CAN ISOTP subsystem including t=
imer
drain ordering, wakeup handling on shutdown, and tx_gen checking. It introd=
uces
a generation-tagged result slot system to safely record transfer results.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
[ ... ]
> @@ -1223,20 +1321,49 @@ static int isotp_sendmsg(struct socket *sock, str=
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
> +		 * isotp_tx_gen_done() uses common tx.state/tx_gen read sequence
> +		 */
> +		err =3D wait_event_interruptible(so->wait,
> +					       isotp_tx_gen_done(so, my_gen));
>  		if (err)
>  			goto err_event_drop;
> =20
> -		err =3D sock_error(sk);
> -		if (err)
> -			return err;
> +		/* still our claim, but isotp_release() force-shut it down */
> +		if (smp_load_acquire(&so->tx.state) =3D=3D ISOTP_SHUTDOWN &&
> +		    READ_ONCE(so->tx_gen) =3D=3D my_gen) {
> +			err =3D -EADDRNOTAVAIL;
> +			goto err_event_drop;
> +		}
> +
> +		/* own completion, or tx_gen moved on - either way this is
> +		 * what isotp_get_tx_result() recorded for my_gen
> +		 */
> +		err =3D isotp_get_tx_result(so, my_gen);
> +
> +		/* drain to avoid stale error for a later poll()/SO_ERROR */
> +		sock_error(sk);
> +
> +		return err ? err : size;

[Severity: High]
Does discarding the return value of sock_error() here silently drop
asynchronous RX socket errors?

If a concurrent RX timeout or malformed PDU sets sk->sk_err to ETIMEDOUT
or EBADMSG, calling sock_error(sk) will unconditionally clear it to 0. Since
the returned value is ignored and the function prioritizes returning the TX
result or size, it seems the application will never be notified of these RX
failures via sendmsg(), poll(), or getsockopt(SO_ERROR).

Should we preserve or return this error if no TX error occurred?

>  	}
> =20
>  	return size;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725122136.5032=
-1-socketcan@hartkopp.net?part=3D1
