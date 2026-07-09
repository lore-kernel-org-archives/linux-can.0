Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C664657F1
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620599; cv=none; b=UiifNi+xPVhENOtB8Kbbk8Fs/1YfWbACsMfkRHHhzodYzyDqm392/7M1p6UiIg+sdeeK4jOB2beK2axPqSalXjfiF+Ij5Pj+qA4X+lm19dOc8nx2pzMKeYO1jbGKsvGEPbGwYjx1nmeMmIrpvSK8ZzhkpqC6uy9pXuXn94TmnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620599; c=relaxed/simple;
	bh=wwQAHVQ29BmdX6PM4BW7Wp6P0JwnAzMmn5HV5UyQRGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cMsTekkdDOwDZNHeXuw3BOhV097Q2gQs1dSQ52JFZECtbyqSd5svwunjDjMiLNYlhoOlv0hxDodAuFdrE7Q41apikeNbHXXFCUAlBx4Cdpcx6js6iYTnrsX8pEpXwP1xVtBIioGu+bYyRNNVjf5uV+njyuCUlQew+OW5lJ2WAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm1jR0qq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm1jR0qq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B2B1F000E9;
	Thu,  9 Jul 2026 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620598;
	bh=237cRHXgOdEmCMJHNIBTsdmNPiuvTVDpN7ke09asIng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cm1jR0qqO/+2KTbWIRdpuhRDz+dTmuCZNybDnKHJO07n1phFHKtAiJ78SK4U+UgD/
	 535tdRGNqH2fLvmFOlRQ3we4oxREhfjX5AMOi2gbK13KTof11oS+bCgvOWw0OE/W1I
	 u6TF6XKuSsVCFWSlABgVlEX5WCMdnI8v5DxnkurwpLO7yxFRYB2z5/zyqtikBlBZ0r
	 wigFJEKKW011/ojRFggVOx/X9d3fqE9xe6wWldBcfZPCU5hftyKrBedo6hxbbMJ3Ev
	 sLsS8Q4Z2aIHtu/5eAOnTINwbDGb9p0xS0p45v+dt+B8K24Y3ggTfu7rmLnp/2RWEr
	 IFdJQLZMPeuqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/11] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v11-2-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-2-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:09:57 +0000
Message-Id: <20260709180958.63B2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless data race in BCM operation updates corrupts active TX/RX =
CAN frames.
--

--- Patch [2]: [PATCH v11 02/11] can: bcm: fix lockless bound/ifindex race =
and silent RX_SETUP failure ---
commit 86f16dbfed96fce9e0564ffdb9d5e63f4ec62cce
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes a race condition in bcm_sendmsg() by moving the bo->ifind=
ex
read and bo->bound check under the socket lock. It also ensures bcm_rx_setu=
p()
returns -ENODEV when the target device concurrently disappears.

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
> =20
>  		} else

[Severity: High]
This is a pre-existing issue, but does bcm_rx_setup() modify the active
op->frames array locklessly on the RX side?

Looking at the earlier part of bcm_rx_setup():

    /* update CAN frames content */
    err =3D memcpy_from_msg(op->frames, msg,
                          msg_head->nframes * op->cfsiz);

Could this data race with the softirq reader bcm_rx_handler() while it is
actively processing frames?

[ ... ]

> @@ -1436,20 +1463,21 @@ static int bcm_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  			struct net_device *dev;
> =20
>  			dev =3D dev_get_by_index(sock_net(sk), ifindex);
> -			if (!dev)
> -				return -ENODEV;
> +			if (!dev) {
> +				ret =3D -ENODEV;
> +				goto out_release;
> +			}
> =20
>  			if (dev->type !=3D ARPHRD_CAN) {
>  				dev_put(dev);
> -				return -ENODEV;
> +				ret =3D -ENODEV;
> +				goto out_release;
>  			}
> =20
>  			dev_put(dev);
>  		}
>  	}
> =20
> -	lock_sock(sk);
> -
>  	switch (msg_head.opcode) {
> =20
>  	case TX_SETUP:

[Severity: High]
This is also a pre-existing issue, but does bcm_tx_setup() write to the
active op->frames array locklessly before validating the frame length?

When TX_SETUP is called, bcm_tx_setup() copies user data:

    cf =3D op->frames + op->cfsiz * i;
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

    if (op->flags & CAN_FD_FRAME) {
        if (cf->len > 64)
            err =3D -EINVAL;

If an invalid length is provided from userspace, it is written to op->frames
first. The function catches the error and returns -EINVAL, but the
corrupted frame remains in the array.

Concurrently, can the high-resolution timer callback bcm_can_tx() transmit
this corrupted frame?

bcm_can_tx() reads the frame contents outside of bcm_tx_lock:

    spin_lock_bh(&op->bcm_tx_lock);
    cf =3D op->frames + op->cfsiz * op->currframe;
    spin_unlock_bh(&op->bcm_tx_lock);

    skb_put_data(skb, cf, op->cfsiz);

Could this pass an unvalidated cf->len down to the hardware driver and
potentially overflow device buffers? An attacker creating a cyclic
transmission via TX_SETUP, then issuing a concurrent TX_SETUP update with
an invalid length, might be able to trigger this condition.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D2
