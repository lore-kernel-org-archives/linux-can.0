Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CF3E0725
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698163; cv=none; b=J7R8FWoBuNyFImvaIBZc9JfCabRYskSrUC3cKKa6kuobEMMg2EKz9T0ifEfZa6YPrRIzNyuwSfS1MR1KXQGgLkqC3eE2IqDTtsVKUVLlbNm5SzXCpaYEq88pgQgheUIVwk3K5vJTqYWkmUBFgjcIF3rBTxFKz2Zc0veHlTAuWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698163; c=relaxed/simple;
	bh=ZDUSkWZwahFeHpdDKe/5Sp4TB9U8aJMHjF1wJXX/gTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W1Idz1ESy0HFwh2ouyjcyH7HIqV8E5YITop8TQq2+ntpMCDjLbIM7vVqEJfRjrjjBFojNr8saF529gD0bCV9vma0+BoCXFwALCA9qime2VvmUp0l+DLQFe/hkgEFrNb85kpjQ4bfMSjyqhkvg0CfYXA6IEdriZldOyonK1BGMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/p01NFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/p01NFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94E51F000FF;
	Tue, 29 Sep 2026 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790698162;
	bh=egZ9T38Wi6rR/e0AtBhobjwrCRRp2D0yKkBDY59F4DU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/p01NFox24WNnVZxXtUy3GpgZr7WfPiJ3GXw2id/mcfLNuAR4B+0WiTkJaDMR504
	 ktAlbPJDa4sHwBEM65UBLQkATYR7tyWIo4DfoGhjXKUWSxRDJi9FC7BBlymCy3QhjM
	 hfEi6MKYHXOcfzH1WrasPMgZswuwpN49yl7GZBZwEH4oMWGzn+jBzSdDvE1Mn3jQuo
	 RJVMA2BjgBK3l7wG19fz5YUfkfyjfzksbuwcLIdvWkBz7zoerELIB468T/JdQvW4JG
	 Y53BZNConmQOusHYsRDVQ1/NHt1debHe/K0MTmaFepLhRnnZsydWaLtVUxZ5QcsHCC
	 lVBAumF7AY5TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] can: fix unique skb identifier regression under
 RPS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260929154125.3298-4-socketcan@hartkopp.net>
References: <20260929154125.3298-1-socketcan@hartkopp.net>
 <20260929154125.3298-4-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 16:09:21 +0000
Message-Id: <20260929160921.E94E51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: data race and extension corruption due to incorrect skb_clone=
d() check
--

commit 1ddbc558b8096bdaecb507a831137177beb7d0ad
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: fix unique skb identifier regression under RPS

This commit moves the per-skb unique identifier used for duplicate detection
into a CAN skb extension instead of using skb->hash. It aims to fix an issue
where RPS assigned a non-zero hash to CAN frames, preventing a unique ID fr=
om
being generated and causing legitimate frames to be dropped as duplicates.

Link: https://lore.kernel.org/linux-can/2859AD3D-C805-41A0-9036-C5E8EE15241=
9@clnt.de/

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index ef435f22ac933..4aa233d7e8a1d 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
[ ... ]
> -void can_set_skb_uid(struct sk_buff *skb)
> +void can_set_skb_uid(struct can_skb_ext *csx)
>  {
> -	/* create non-zero unique skb identifier together with *skb */
> -	while (!(skb->hash))
> -		skb->hash =3D atomic_inc_return(&skbcounter);
> -
> -	skb->sw_hash =3D 1;
> +	while (!(csx->can_skb_uid))
> +		csx->can_skb_uid =3D atomic_inc_return(&skbcounter);
>  }

[Severity: High]
If the extension block passed here is shared with another SKB, will this wr=
ite
to csx->can_skb_uid cause a data race and corrupt the clone's UID?

[ ... ]
> +static struct can_skb_ext *can_get_unshared_skb_ext(struct sk_buff *skb,
> +						    struct can_skb_ext *csx)
> +{
> +	/* create unshared CAN skb_extension for netem/mirred skb clones */
> +	if (unlikely(skb_cloned(skb)))
> +		return skb_ext_add(skb, SKB_EXT_CAN);
> +	else
> +		return csx;
> +}

[Severity: High]
Is skb_cloned() the correct check to determine if the extension block is sh=
ared?

If a CAN SKB is cloned (for example, via tc mirred) and its data buffer is
later unshared via skb_unshare() or pskb_expand_head(), the data buffer is
copied but the extension block remains shared because __skb_ext_copy() only
increments its refcount.

In this scenario, skb_cloned(skb) returns false because the data buffer its=
elf
is no longer shared. Returning csx directly here would bypass the COW refco=
unt
logic inside skb_ext_add() and pass a shared extension block to
can_set_skb_uid().

This seems like it could cause raw_rcv() to mistakenly identify legitimate
frames as duplicates and silently drop them. Should this rely directly on t=
he
refcount handling within skb_ext_add() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929154125.3298=
-1-socketcan@hartkopp.net?part=3D3
