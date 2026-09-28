Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAC36D51B
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617718; cv=none; b=cF32MdGQONDnpPaTedQFzWylSHiK9yikQqfI928ocfTs7zAeYr6aO1NkpgMh0txXInSZ5jY5d1EDlQOoudjtmuuHZsWu19aDQ7uOaxenRLqgw+q3u+G9E/0Pn2y2Vk8Du5L+khM8D1hqHj5sIiCSx5yV3QnOW18Z8znGH3H3iE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617718; c=relaxed/simple;
	bh=TTJVKIPAKBkHFbqZfgRBHx25tB50H2vwmuJ5quebqoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sCAsHND0pSXlLeaZMpc+CMn7mOO8yOuz2yyaydGtpInswziuuXq6BeYxzhlM+xRTYC9cMusXBCVmvcZBuSX2/v4Vg4u6QNBiotJUf7E0tVmQMPPefN9+lRf2cVaCsYtzpAqxpQp43ENzHzbmxfzmPKKTAVgq6htBvuNdGLgGX2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve4Eoe0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve4Eoe0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DDC1F000FF;
	Mon, 28 Sep 2026 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617717;
	bh=ETkW6ROnvPEVxx0S32L+nrwP0FFqULBV5IH2bFuCaZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ve4Eoe0UCZ1GDecjIX6gFqUoa4CDKwwwL2AtNn+xTZQtxHdQJJ0AzMgcUdVf78z0I
	 IfGbZqnEltz64YbNMintYR+6K33Z9czRUOjymM70fR5Skq1IBCy9Z8nPOBaOAdMdbU
	 iO6TJA0ZDH3mF/kiYdtdywbmf7HLuhRhGsQ00GFB3Uma3DAR/fb9L7Tfk3i0ztpqrq
	 8NgJchVLmQZPLV62TRv0al5qBIhuvT4QtdPRu5i9rh2TeS1T2lF43IwvkOQBxiR35J
	 wd0X/f/IZir2RqGEEkbESdidN3WHqX9xRGETJGbC69RPbw4ok6LH8iPNJU05SO+7FS
	 SHkwTS163XUuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] can: fix unique skb identifier regression under
 RPS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260928173105.51765-4-socketcan@hartkopp.net>
References: <20260928173105.51765-1-socketcan@hartkopp.net>
 <20260928173105.51765-4-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:48:36 +0000
Message-Id: <20260928174837.22DDC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: silent packet drops due to shared state mutation in skb exten=
sion
--

commit c8004f984caec4e36211ec16983dd32a18d7f101
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: fix unique skb identifier regression under RPS

This commit addresses an RPS regression where statically generated hashes
by the flow dissector cause legitimate frames to be discarded as duplicates
in raw_rcv(). It attempts to fix this by explicitly tracking the CAN skb UID
via a new CAN_EXT_UID flag in the skb extension (struct can_skb_ext), ensur=
ing
that skb->hash is overwritten only if the flag is not set.

Fixes: d4fb6514ff8e ("can: use skb hash instead of private variable in head=
room")
Reported-by: Joerg Willmann <joe@clnt.de>
Closes: https://lore.kernel.org/linux-can/2859AD3D-C805-41A0-9036-C5E8EE152=
419@clnt.de/
Cc: stable@vger.kernel.org

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index ef435f22ac933..26ce523693c5e 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -641,13 +641,18 @@ static int can_rcv_filter(struct can_dev_rcv_lists =
*dev_rcv_lists, struct sk_buf
>  	return matches;
>  }
> =20
> -void can_set_skb_uid(struct sk_buff *skb)
> +void can_set_skb_uid(struct sk_buff *skb, struct can_skb_ext *csx)
>  {
> -	/* create non-zero unique skb identifier together with *skb */
> +	if (csx->can_ext_flags & CAN_EXT_UID)
> +		return;

[Severity: High]
Could reading this shared flag to conditionally initialize a per-SKB local
field (skb->hash) cause legitimate frames to be discarded?

If a CAN frame is cloned on the egress path (e.g., via tc mirred mirroring =
to
another CAN interface), the original and the clone share the same skb_ext
structure. Both devices call can_put_echo_skb() to create loopback echoes,
which inherit the shared extension.

When these echoes arrive concurrently at can_rcv(), the first CPU sets
CAN_EXT_UID in the shared extension.

The second CPU sees the flag already set and returns without assigning a un=
ique
skb->hash. Because the second clone retains the static RPS software hash, if
the SLAB allocator reuses the memory address of a previously received frame,
raw_rcv()'s per-CPU uniqframe check will falsely identify the new frame as a
duplicate and drop it.

This appears to revive the RPS duplicate-drop regression this patch intende=
d to
fix.

> +
> +	/* Overwrite pre-calculated network hashes with a unique CAN UID */
> +	skb->hash =3D 0;
>  	while (!(skb->hash))
>  		skb->hash =3D atomic_inc_return(&skbcounter);
> =20
>  	skb->sw_hash =3D 1;
> +	csx->can_ext_flags |=3D CAN_EXT_UID;

[Severity: High]
Can this mutate the shared SKB extension in the RX softirq path without
locking or unsharing, causing a data race and altering state for other clon=
es?

Additionally, can_put_echo_skb() mutates csx->can_framelen on the TX path:

drivers/net/can/dev/skb.c:can_put_echo_skb() {
    ...
    csx->can_framelen =3D frame_len;
    ...
}

Because can_framelen and can_ext_flags share the same 4-byte memory region =
in
struct can_skb_ext, does this race with can_set_skb_uid() during concurrent
processing of mirrored clones?

>  }
>  EXPORT_SYMBOL(can_set_skb_uid);

[ ... ]

> @@ -687,8 +690,9 @@ static void can_receive(struct sk_buff *skb, struct n=
et_device *dev)
>  static int can_rcv(struct sk_buff *skb, struct net_device *dev,
>  		   struct packet_type *pt, struct net_device *orig_dev)
>  {
> -	if (unlikely(!can_get_ml_priv(dev) ||
> -		     !can_skb_ext_find(skb) || !can_is_can_skb(skb))) {
> +	struct can_skb_ext *csx =3D can_skb_ext_find(skb);

[Severity: High]
Might retrieving the SKB extension here without ensuring exclusive ownership
(e.g., via skb_ext_maybe_cow()) pass a potentially shared structure to a
mutator?

> +
> +	if (unlikely(!can_get_ml_priv(dev) || !csx || !can_is_can_skb(skb))) {
>  		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len=
 %d\n",
>  			     dev->type, skb->len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928173105.5176=
5-1-socketcan@hartkopp.net?part=3D3
