Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3843F0A9
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306766; cv=none; b=egX/CM1YVL20rOF82IsfJCx/x5uN/IQoJ7YvNFCXit2U4QTb0S+oqbzha4jZQescU9YuY1ktBt0kzIOsBzJJiIKjn+wXKlmjSe0P0kILie1/bFgx4YDflat+ve75biV0KkFJQAQ1aWbe2fOW9liBXTboEUpXvtrz5sBS4EuSUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306766; c=relaxed/simple;
	bh=IWY2sN9hM/tnd1ufydqDZJdGP3jfkawjIlRh6jG/86M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TOpNEjdJN58yZkrXzH5UhJ1Yg0mCjURVAjNS1TThnvNG0i68EhVOrVx4gq34WcGXcVidste7sReBh0tCzR5fbYnhl7sv4lnlM1Hkn/ilbkuIQvXvWcY08mJBV/wenEZYcqARQsq/X7XmIJfvJ3UozLWkTCQYiqDKDg0Z+BXcawE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwXaZhDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwXaZhDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C791F00A3D;
	Fri, 17 Jul 2026 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306764;
	bh=m5TxOIe+jBp/K/EiGgVEUvzu0jytEPcrWs0wHCKkCiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RwXaZhDKYIEzjP3wShpQHff/Pcp6X+M4lwcFXxYoNOj3faIRDJxJWgS15AD87lVbb
	 oB5do94r9NTdd2n4hQO+e1KiZz/DrrO95/0gA2rJrbQJiyAFSrkj3uXHIhUecIjIlU
	 E6K3/9zKMIleUEyQKPn3VXaN38zl3QTDo7xxwEbBHWH/GyqZjseK/0pVVF4Dnq1GpT
	 hbIMkroQ2asHf/RZ36fY9yEVwCBzmy3STWP9so8J4qQ1H2Rkt5PSg9ssfvLeK7Ou5/
	 l2XEUwsjnusuMGM+yohsQ9mPE0xheXaX6AMK/AR4HtX8//0knaaOqFhqwm2YtrzN/C
	 ioKp2Xhl9ek1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 18/19] can: isotp: fix use-after-free race with
 concurrent NETDEV_UNREGISTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260716155528.809908-19-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-19-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:46:03 +0000
Message-Id: <20260717164604.65C791F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent `setsockopt(CAN_ISOTP_LL_OPTS)` and `isotp_sendmsg()` c=
an cause `skb_over_panic` due to unlocked reads of `so->ll.mtu`.
- [High] Receiving a First Frame (FF) triggers a `kmalloc` with `GFP_ATOMIC=
` up to `max_pdu_size` (defaults to 8300 bytes, up to 1MB), which can exhau=
st the kernel's atomic memory pool.
- [Medium] The return values of `can_rx_register()` are ignored in `isotp_b=
ind()`, leading to silently dropped packets and kernel log warnings on sock=
et release.
--

--- Patch [18]: [PATCH net 18/19] can: isotp: fix use-after-free race with =
concurrent NETDEV_UNREGISTER ---
commit 9321d1d072ae2c3d91c2e9ffaeeff213350e562d
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER

isotp_release() looked up the bound network device via dev_get_by_index()
using the stored ifindex. During device unregistration the device is
unlisted from the ifindex hash before the NETDEV_UNREGISTER notifier
chain runs, so a concurrent isotp_release() could find no device.

Link: https://patch.msgid.link/20260712-isotp-fixes-v10-2-793a1b1ce17f@hart=
kopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index d30937345bcdc..44c044eb83e12 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -978,6 +980,14 @@ static int isotp_sendmsg(struct socket *sock, struct=
 msghdr *msg, size_t size)
>  			goto err_event_drop;
>  	}
> =20
> +	/* so->bound is only checked once above - a wakeup may have
> +	 * unbound/rebound the socket meanwhile, so re-validate it
> +	 */
> +	if (!so->bound) {
> +		err =3D -EADDRNOTAVAIL;
> +		goto err_out_drop;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but can this lead to an skb_over_panic due to
unlocked reads of so->ll.mtu?

If isotp_sendmsg() is called and passes the so->bound check, and a
concurrent NETDEV_UNREGISTER notifier clears so->bound:

CPU1                                CPU2
isotp_sendmsg()                    =20
  // passes so->bound check
                                    NETDEV_UNREGISTER notifier
                                      so->bound =3D 0;
                                   =20
                                    setsockopt(CAN_ISOTP_LL_OPTS)
                                      // passes !so->bound check
                                      memcpy(&so->ll, &ll, sizeof(ll));

Could isotp_sendmsg() then execute sock_alloc_send_skb() with the old
so->ll.mtu, and later call skb_put_zero() with the newly modified, larger
so->ll.mtu, causing a buffer overflow panic?

>  	/* PDU size > default =3D> try max_pdu_size */
>  	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {

[ ... ]

> @@ -1354,16 +1373,25 @@ static int isotp_bind(struct socket *sock, struct=
 sockaddr_unsized *uaddr, int l
>  	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
>  			isotp_rcv_echo, sk, "isotpe", sk);
> =20

[Severity: Medium]
This isn't a bug introduced by this patch, but should we be checking the
return values of can_rx_register() here?

If can_rx_register() fails (e.g., due to memory pressure returning -ENOMEM),
the error appears to be ignored, and the socket is incorrectly marked as
successfully bound.

When the socket is later closed, isotp_release() calls can_rx_unregister(),
which would fail to find the receiver entry and trigger a kernel warning.

> -	dev_put(dev);
> -
>  	/* switch to new settings */
>  	so->ifindex =3D ifindex;
>  	so->rxid =3D rx_id;

[ ... ]

Also, regarding a separate pre-existing issue in isotp_rcv_ff():

[Severity: High]
This is a pre-existing issue, but does receiving a First Frame (FF) trigger
a potentially large allocation in atomic context?

net/can/isotp.c:isotp_rcv_ff() {
    ...
    u8 *newbuf =3D kmalloc(max_pdu_size, GFP_ATOMIC);
    if (newbuf) {
        so->rx.buf =3D newbuf;
        so->rx.buflen =3D max_pdu_size;
    }
    ...
}

Since max_pdu_size can be up to 1MB, could an attacker broadcasting First
Frames with large PDU sizes rapidly exhaust the kernel's atomic memory pool?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D18
