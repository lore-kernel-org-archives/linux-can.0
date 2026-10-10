Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C40459AEB
	for <linux-can@vger.kernel.org>; Sat, 10 Oct 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639837; cv=none; b=MzqQPHT5ctiGvl1wk1UlQeYszalDZLjoV9Zf1hIH2egXYasXmnVFqDJoCBUHXGVtCsnlJCegadN8JlIUsjhaVfE/RtMVdIlUqmqtU7WytR22oafz3poWFtSIegfzwL3vqh36QsWB3bx/+AI0f2SPagwfh+oIV5j8nkBhQc0kxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639837; c=relaxed/simple;
	bh=S5vJ3xJzt6wGJSRltoGHw9uimqJRAlpeYXoAu3nSrQQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LSkXPip8dVwPFJe8esEUho/27o1bnh9lrHeDPhlklXOzqaOnzZZK7LMHQ3LnqFSFeeEh7trVBeakUm0SBF/i/G6/zYiMuoWgIVceV1maPrJAZJOhkXj1kDkSzduK3VTTjjBUAM+U7yVfKv4yRsL2qIK5xQF8lubo727LqnGqIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akep67nT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akep67nT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E221F00893;
	Sat, 10 Oct 2026 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639836;
	bh=umhGpEqmE0wPbGm72u9C9bzOyxT+rjkwGmXNxSgOZFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=akep67nT+y+c0/AL+JWAMBR1G1laLQeilP9NlT17DqGlqxLYrTCQF9QQq1LKE9p5G
	 m0gjQs3QuJp+xWrpOw41VkDJkxPLXbnDGJ2VnoEb7Tahfg34MVjmrTOZZkiMTd75bn
	 b0/4tgZN+I7VEYpmHSyi9jH5kOFIiAoEnpMrbuBKfbkk9gNVpfCBk6ZbQm/RpaOIaT
	 Yn41gjkI5xhRr1xW3XfSbweOFsmoTJhwzmjDHBjmmQ0YOk8DJQywqpG7QcAWJcJVEb
	 BQRF8OdyZT0gdYUG9xySGchq/Sq23M10QbHISx+p9wiTROBzK+hmQtVYEAmwon96UD
	 zG0PatZLlKSvw==
Message-ID: <sashiko-outbox-166595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 07/37] can: isotp: check the frame type, not
 just the length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20261009134323.64064-8-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009134323.64064-8-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 13:43:55 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: out-of-bounds read and info leak due to missing pskb_may_pull=
()
--

commit 4554c7ecb146245b9cdb1ec3080629015d6b848e
Author: Kaixuan Li <kaixuanli0131@gmail.com>

can: isotp: check the frame type, not just the length

This commit updates isotp_rcv to check for correct CAN CC or CAN FD frame
content, rather than relying solely on the skb length. This prevents CAN XL
frames from being misidentified and processed improperly.

Link: https://patch.msgid.link/20260920035626.2581040-1-kaixuanli0131@gmail=
.com

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 1a272ce6a2bde..5e1c3971ebfce 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -756,6 +756,14 @@ static void isotp_rcv(struct sk_buff *skb, void *dat=
a)
>  	if (skb->len !=3D so->ll.mtu)
>  		return;
> =20
> +	/* check for correct CAN CC/FD frame content */
> +	if (so->ll.mtu =3D=3D CAN_MTU) {
> +		if (!can_is_can_skb(skb))
> +			return;
> +	} else if (!can_is_canfd_skb(skb)) {
> +		return;
> +	}
> +

[Severity: High]
Could this lead to an out-of-bounds read and information leak if the skb is
fragmented?

If a local user with CAP_NET_RAW sets up an AF_PACKET socket with a
memory-mapped TX ring (PACKET_TX_RING) and sends a CAN or CAN FD frame,
tpacket_fill_skb() can place the entire payload into page fragments, leaving
the linear portion empty.

Because there is no call to pskb_may_pull() to ensure the header is in the
linear area before accessing it, when the new code calls can_is_can_skb()
(or can_is_canfd_skb()), it casts skb->data and reads cf->len:

include/linux/can/skb.h:can_is_can_skb() {
    struct can_frame *cf =3D (struct can_frame *)skb->data;
   =20
    /* the CAN specific type of skb is identified by its data length */
    return (skb->len =3D=3D CAN_MTU && cf->len <=3D CAN_MAX_DLEN);
}

This reads uninitialized memory and beyond skb->tail into skb_shared_info.
Later in the receive path, isotp_rcv_sf() copies this out-of-bounds memory
into a new skb:

net/can/isotp.c:isotp_rcv_sf() {
    ...
    memcpy(skb_put(nskb, len), &cf->data[pcilen], len);
    ...
}

This delivers potentially sensitive kernel memory to the receiving socket.

>  	cf =3D (struct canfd_frame *)skb->data;
> =20
>  	/* if enabled: check reception of my configured extended address */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134323.6406=
4-1-mkl@pengutronix.de?part=3D7
