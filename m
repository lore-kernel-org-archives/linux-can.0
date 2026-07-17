Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136B2DCC13
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306761; cv=none; b=q58ZTFnM2kt6eR/IVO23VcdQutZJdVzi/1O4Mltc0oPg6hubwHQygEVXVpX2XByaxDvxD3qtR5F907DSgTIob4vWlcSVu3+DOTIKm4bArYvfejANpB0EpVD69jF0q90PKRsaAbDZjCmdgUuSLRK0LrQKigEuKBdAy9n3YEmHidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306761; c=relaxed/simple;
	bh=OSyAm2GF+9VwIROe8k/v2V22FCSgrbPI8pBB6mYrx8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G+nqherIKZi21r0JTSy+I65F5joVPtYxWxSSXrzOQ72sFSUpt2iJQmmNyg3t7k4ybp6WeLBMvptKACcWOVEkSXlxhhXsnIJZwz2j/SjN+H3avvKbc7caPDRMEKLTi0x1KRgXSkG6mzZu0VlGxzXu7N+kz53rSmS8jMg+nw8K1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkRdcDV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkRdcDV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9A11F000E9;
	Fri, 17 Jul 2026 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306760;
	bh=ksaBb+5+wi/rr40JO9GcH2Vn5lucmJ8zTI6XV5JewEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VkRdcDV4PqtJv0U/xbdUwC4dLGZScDpSVMsHJ1+YUD9AySeQgenXica7RlS4kN33v
	 UxgdZh+KRGq4i6rw/eKWL1/g640aLceWE/HDA8LvW99jiiLzT9MszqpQ8+Xm0M5bj2
	 nuOK03bsjV4N3nwFV1WDqrhDApa1z3nH7qQJLJ3vlWBcaSmG9R+nC++uGJy5TvOAXp
	 9kZWmEhpIOWNeCjjWvvSonnFnhGrPkRBX2I/jDJcZ8rIlgc7GlclYmDLnqjsX6JUOL
	 5OYzRkMcvwjPVg8jyj4jSowT8191DG44b9eALvKERodfOUR8bysV477/pHZp0OBJVf
	 IULvSBk9e1v0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 10/19] can: bcm: add missing rcu list annotations
 and operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260716155528.809908-11-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-11-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:45:59 +0000
Message-Id: <20260717164559.EB9A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] List corruption and Use-After-Free in bcm_rx_setup() due to un=
conditional list_add_rcu() and missing list_del_rcu() on existing operation=
s.
--

--- Patch [10]: [PATCH net 10/19] can: bcm: add missing rcu list annotation=
s and operations ---
commit 920bd90c8dec1b6179ef18a6d82400e3e89b0659
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit aims to fix RCU list annotations for CAN BCM sockets so that
bcm_proc_show() can safely traverse the operation lists. It moves the
list_add_rcu() calls to the end of the bcm_tx_setup() and bcm_rx_setup()
routines to ensure structures are fully initialized when published. It also
adds list_del_rcu() before freeing operations in bcm_release().

Link: https://patch.msgid.link/20260714-bcm_fixes-v15-5-562f7e3e42da@hartko=
pp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 03c98e4cc677d..5c1e83eeb4ff3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1449,10 +1450,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  					      bcm_rx_handler, op, "bcm", sk);
>  		if (err) {
>  			/* this bcm rx op is broken -> remove it */
> -			list_del_rcu(&op->list);
>  			bcm_remove_op(op);
>  			return err;
>  		}
> +
> +		/* add this bcm_op to the list of the rx_ops */
> +		list_add_rcu(&op->list, &bo->rx_ops);
>  	}
> =20
>  	return msg_head->nframes * op->cfsiz + MHSIZ;

[Severity: Critical]
If an existing operation is updated after an interface bounce, could this
cause list corruption or a use-after-free?

When a CAN interface goes down, bcm_notify() unregisters the receive
operation but intentionally leaves the bcm_op linked in bo->rx_ops. If
userspace later updates this existing operation via a new RX_SETUP message,
bcm_rx_setup() finds the existing operation and sets do_rx_register =3D 1.

If the subsequent re-registration fails (err !=3D 0), it looks like removing
list_del_rcu() here means bcm_remove_op() will free the operation via
call_rcu() while it is still linked in the bo->rx_ops list.

Conversely, if re-registration succeeds, won't the unconditional call to
list_add_rcu() corrupt the list pointers since the operation is already
linked in the list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D10
