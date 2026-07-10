Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7F126C03
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644039; cv=none; b=eAgD79A95CniDVowskXTDU/MDCC0NGIul/p6edFMEg/pJ1vAJydVkVv3K1ltAAwoQp+ZL5gWKhbW760wmOt8htJpy+PUCmWWuxplJ05Lb6tVGzauibY4a+Yp5d8NmxHgk/EAFaharTCgHUkGqCHcbIHqGmcQfO7wIS5BdZXUn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644039; c=relaxed/simple;
	bh=OTjoc+wbJVbEnXrIZtXCklm6A6tBRwvj6lTDF2tNI44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LRiYgGEFJ57kyU74k3/PdwK6ZQ6yDxYFEh0ljWnazbHJon/b9OmZvg9VvY6wag8h/RQagorXl0pT7HqvK4/fbhDo+a6R2dNep9b8/c8zpQTuem4wf5Iz8Fcmih+ggbhSkECYA+jETqQGg4xut6EveF+7FxhiytIFeEdE0c2h2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWMr0RYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWMr0RYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07511F000E9;
	Fri, 10 Jul 2026 00:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783644038;
	bh=S3EzaW3wTbKpNTyupLrkeNw4A0eSr3T/dhMdhVHI48M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWMr0RYUOehVRIyce+N/7mO9LXJhhRXw7cVXf4sf7LIf/iWPTHzefnxO0WNeqA6lY
	 P5FP3EISYyKjrsNdp+7K4PhV0OfvRmB5JrBlqeUugZF8IOrIB8Dk1t8BPWP3aVukgj
	 hwZvE18EiemUaIvaTLgkMLZkpntZoxIav4JeFZXwXU0bSMGpD9qi8xTiX3jmb3AhqN
	 W0bPOdTJIo9g5BBrlrIlEF4tAgvp6nzKz4Krq9PEM0ZQC65JTTJ+UTZgATA3qWAVjh
	 +wScfYwX8g3YMoVKAn1rFO+zupcqErJv0NvZAARJ1oPHtn4zUGj+N0eiYJmIVyx6N9
	 nbJsvwNnKg/NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/11] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v12-2-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
 <20260709-bcm_fixes-v12-2-61c06291bf1c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 00:40:37 +0000
Message-Id: <20260710004037.F07511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `bcm_rx_setup()` and `bcm_tx_setup()` use `list_add()` instead of =
`list_add_rcu()` when inserting into lists read via RCU.
- [High] `bcm_proc_show()` incorrectly iterates `bo->tx_ops` using the non-=
RCU `list_for_each_entry()` without holding the socket lock.
- [Medium] The NETDEV_DOWN handler in bcm_notify() reads bo->bound and bo->=
ifindex locklessly, racing with concurrent writers and invalidating the com=
mit's concurrency claims.
--

--- Patch [2]: [PATCH v12 02/11] can: bcm: fix lockless bound/ifindex race =
and silent RX_SETUP failure ---
commit a8c67f18d60953102178fb9e6b18b46fea68d7fe
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can: bcm: fix lockless bound/ifindex race and silent RX_SETUP fail=
ure

This commit addresses a race condition in bcm_sendmsg() where lockless
reads of bo->bound and bo->ifindex could lead to inconsistent states.
It moves the ifindex read and bound re-validation inside the socket
lock section to serialize with writers. It also fixes a silent failure in
bcm_rx_setup() when a target device concurrently disappears.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1323,6 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
> =20
>  				op->rx_reg_dev =3D dev;
>  				dev_put(dev);
> +			} else {
> +				/* the requested device is gone - do not
> +				 * silently succeed without registering
> +				 */
> +				err =3D -ENODEV;
>  			}

[Severity: High]
This isn't a bug introduced by this patch, but do bcm_rx_setup() and=20
bcm_tx_setup() use list_add() instead of list_add_rcu() when inserting into=
=20
lists read via RCU?

net/can/bcm.c:bcm_rx_setup() {
    ...
    list_add(&op->list, &bo->rx_ops);
    ...
}

net/can/bcm.c:bcm_tx_setup() {
    ...
    list_add(&op->list, &bo->tx_ops);
    ...
}

Since /proc/net/can/bcm iterates these lists under rcu_read_lock(), could a=
=20
concurrent reader traverse uninitialized list pointers due to the lack of=20
smp_store_release() barriers?

[ ... ]

> @@ -1535,7 +1564,12 @@ static void bcm_notify(struct bcm_sock *bo, unsign=
ed long msg,
>  				bo->bcm_proc_read =3D NULL;
>  			}
>  #endif
> -			bo->bound   =3D 0;
> +			/* Paired with the lockless fast-path check in
> +			 * bcm_sendmsg(); bo->ifindex itself is only ever
> +			 * accessed under lock_sock() so it needs no
> +			 * annotation.
> +			 */
> +			WRITE_ONCE(bo->bound, 0);
>  			bo->ifindex =3D 0;
>  			notify_enodev =3D 1;
>  		}

[Severity: Medium]
This is a pre-existing issue, but the comment states that bo->ifindex is=20
only ever accessed under lock_sock(). Does the NETDEV_DOWN handler in=20
bcm_notify() read bo->bound and bo->ifindex locklessly?

net/can/bcm.c:bcm_notify() {
    ...
    case NETDEV_DOWN:
        if (bo->bound && bo->ifindex =3D=3D dev->ifindex) {
    ...
}

Could a concurrent bcm_connect() or bcm_release() modify bo->bound and=20
bo->ifindex under lock_sock() while the NETDEV_DOWN event triggers this=20
lockless read, invalidating the comment's claims about access safety?

[Severity: High]
This is a pre-existing issue, but does bcm_proc_show() incorrectly iterate=
=20
bo->tx_ops using the non-RCU list_for_each_entry() without holding the=20
socket lock?

net/can/bcm.c:bcm_proc_show() {
    ...
    list_for_each_entry(op, &bo->tx_ops, list) {
    ...
}

If a user creates or deletes a TX operation via bcm_sendmsg() concurrently=
=20
with another thread reading /proc/net/can/bcm, could this cause data races=
=20
on list pointers because it lacks rcu_dereference() protection?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v12-0-61c06291bf1c@hartkopp.net?part=3D2
