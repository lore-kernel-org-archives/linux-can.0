Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195603;
	b=SCLs0Xb1xSyomOly7j4vIGtQQ/xALEdV6Ik+IpJ4KxE3zeIM1O8uCCt8WufnsmfDAVy1
	 9y7k8aLMzd2PuUfh5zz2CSTPPyuB5xbm/Xm2V9Zvn46UhH8ZBQT+rLcPO8EhOEzSgMYmu
	 KUb+OA2+qlJVM8hoR1iPcV3R1GJNDnxgjk4vN1PTYR+Aea3NB77qsn4w2TmTA6CRNeAbG
	 ceseYkWi6YytYknirg79g4kenwurtrH1p5vB5EQ1cz7/NhGYOZLdB2rtljVb0YWhQrUyY
	 V8FEyLcdOoaCblCR/3nZV+0KAFzX+nkULf+Oj1oc43Kq7vxc9LT3ojMQ7F8Cp+tUODQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195603;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F3z4srfaEwOrWYIJw2J8IrKrlzLkjmosb1vpcORwMOU=;
	b=siCvsV2MoH4R/DIeoAznFG+pmTWXixnZ5aC424gSXDSwcpqw/jZo6IQF88tEH52Ydbd/
	 IN8JbJZIa9r/UWDC1FomTM+yM7hwgdf9Xw/TzP/j4LwUCe3DUNwR7p/g3fNHLoAvBg4vI
	 eU6SVoPjeKKeW/kS9F1aKYE9tgf08CzzZVhaxjIQRZEe2IZaAC4k/HC5tzmR6795G0QKE
	 7WfSRW+VdfaSj0E+KnCduU9Y0pgNcCX9e6VA06v3W3RkxcHn1A9FkQESFynVEY1j21/Nv
	 2DjzOEfq620a2yekR0xA64idEGoOq2K8Toeg+yIDAQ1as7BNAgv6YcG5j1JmgM6ku3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Df8bxpjN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB2606A333
	for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Df8bxpjN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3FF1F01482;
	Wed, 28 Oct 2026 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195602;
	bh=F3z4srfaEwOrWYIJw2J8IrKrlzLkjmosb1vpcORwMOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Df8bxpjNIEgVwYjiRGrJyCMWw8alp+p2Xkmp9PiYBhm/snoZvVZYkDjya4MIt1RHx
	 F3M3Q6vh11911Hx3rXgwvd4W/6MN8K1ziwgyAYpEAe5BpIIsy+aUrRNJNdmSW9kOru
	 8LUsH8xjIfXdbhBJ7rQV17OAUdReYE2acg0ScoKQMHngPEkyPKniGc275ZZm1xTKY/
	 34Kf0S/V75TTiKnN9qZIOZLkNfsvMdkpuzgdioxsSKxYx2EKq5/904CX1xPgn49xWR
	 KH7RJhxhH21BeB1RyC9BrtPMrC/ZTpjtZJ+dsJp9EQWGYBdOuDUWdzsW84qkWQysHU
	 jVpUV/Dxnz5GA==
Message-ID: <sashiko-outbox-187949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/1] can: bcm: limit RX operation resource usage
 per socket
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <50f8970ce7800947332f6203626abbe1933997eb.1793109154.git.zihanx@nebusec.ai>
References: <cover.1793089479.git.zihanx@nebusec.ai>
 <cover.1793109154.git.zihanx@nebusec.ai>
 <50f8970ce7800947332f6203626abbe1933997eb.1793109154.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:53:21 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] can: misplaced kernel-doc comment above can_rx_register_internal()
--

commit 6e185f899c0a564d22495ef1e055cc4b9c9b27f0
Author: Zihan Xi <zihanx@nebusec.ai>

can: bcm: limit RX operation resource usage per socket

This patch bounds the number and total allocation size of RX operations per
BCM socket to prevent kernel memory exhaustion. It also introduces
can_rx_register_with_release() so the socket's receiver count remains
charged until the RCU grace period completes.

Link: https://bugtracker.nebusec.ai/f/11134

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 34fe3b28d576f..a3f0ed35fbb52 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -441,15 +441,20 @@ static struct hlist_head *can_rcv_list_find(canid_t=
 *can_id, canid_t *mask,
>   *  -ENOMEM on missing cache mem to create subscription entry
>   *  -ENODEV unknown device
>   */
> -int can_rx_register(struct net *net, struct net_device *dev, canid_t can=
_id,
> -		    canid_t mask, void (*func)(struct sk_buff *, void *),
> -		    void *data, char *ident, struct sock *sk)
> +static int can_rx_register_internal(struct net *net, struct net_device *=
dev,
> +				    canid_t can_id, canid_t mask,
> +				    void (*func)(struct sk_buff *, void *),
> +				    void *data, char *ident, struct sock *sk,
> +				    void (*release)(struct sock *sk))

[Severity: Low]
When splitting can_rx_register() into can_rx_register_internal() and the
exported wrapper in net/can/af_can.c, can_rx_register_internal() is placed
directly beneath the existing kernel-doc comment for can_rx_register():

/**
 * can_rx_register - subscribe CAN frames from a specific interface
...
 */
static int can_rx_register_internal(struct net *net, struct net_device *dev,
				    canid_t can_id, canid_t mask,
				    void (*func)(struct sk_buff *, void *),
				    void *data, char *ident, struct sock *sk,
				    void (*release)(struct sock *sk))

Doesn't this cause scripts/kernel-doc (under W=3D1 builds) to warn that the
prototype is for can_rx_register_internal() instead of can_rx_register()
and that the release parameter is not described?

Should the kernel-doc comment be moved down to the exported
can_rx_register() wrapper (or updated to match the function it precedes)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793109154.gi=
t.zihanx@nebusec.ai?part=3D1
