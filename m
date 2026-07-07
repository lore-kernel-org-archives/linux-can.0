Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497FD322C6D
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435996; cv=none; b=r8UsMe0KOSgA6sJA4MSXesnfp8cUdK+aE0r+U5xbQF5x5gTnjFqI+xi3oBnXSpWY9yTtkwGnIbRBmljT1GpqMecR+PGEXq8fUxK3h4KtI977IOpyFpbUV42+13g/UlLF0fL9Uhez/bbKSnGfPdw4VVi+gE5IgKopAn3ydwFCftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435996; c=relaxed/simple;
	bh=QVFSkbpn3wK7lJ6JWfMfFadUCBQSTSkVvtPeLEHUqcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lKBDjpwOWeC6f8CyAjYgvJL/VjDKRslgJyZKhnjoUWMO1eN+/6ZVuiBO+IUumWwaZc2X5jQ5f2C978K+PL/SPiSVpcVwgEcmXPE7PsNJ9MWqNbQr6QfpT/cfr748VPL/nBr0YCmfR1NmoN90avz9hRnTKtQKvCqHs4Juf+fgAas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G72VltwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G72VltwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC49F1F000E9;
	Tue,  7 Jul 2026 14:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783435995;
	bh=2Lfzbsw6lyRNQkES7+mbItF5EwO2TT68MOIUdxuZxsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G72VltwUYNPMnmDTAKbIbedD8iXFrULbdcMJ+SibbTWTCLfjZTfuTXDfB1GpdgAer
	 3IikXQWFODhEi2yj1DEKRWoYhtxst+G+TxKCEMcl2AWWLV+ZBaLKWD4UrIjRTuWn6V
	 d7UcaShe4/pJBY1hw2Y+WcmoL8Z4HWZje25aH3S7NIxPksnI//5MterCk2/iQW/NVn
	 fDaQEUq1gE7wUE3yyvhxBuRlPkDLxEDG/RkQKJQDyiYNFscPBZqirOtANUhhUeus8V
	 FpJvfYLDEu8M38ogs8zw2OGt1FvBHLc8d6CR4miLEnGDKtR5b61L+y+qXaVao4sdD9
	 hXWKFGHIlsvDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260707-bcm_fixes-v4-2-aa87b8b9d33f@hartkopp.net>
References: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
 <20260707-bcm_fixes-v4-2-aa87b8b9d33f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:53:14 +0000
Message-Id: <20260707145314.CC49F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected modification of RX operation buffers from process cont=
ext races with softirq receive handlers.
--

--- Patch [2]: [PATCH v4 2/7] can: bcm: fix lockless bound/ifindex race and=
 silent RX_SETUP failure ---
commit 9ced6bfc5d2fbc4191944246b0050dabfa00318e
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes a race condition between bcm_sendmsg() and socket state
modifications by moving the ifindex read inside the socket lock. It also
fixes a silent failure when a target device disappears concurrently during
RX_SETUP.

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
This isn't a bug introduced by this patch, but since we are modifying
bcm_rx_setup(), I noticed a potential race condition. Does the process
context modification of RX buffers race with the softirq receive handlers?

When a user application repeatedly updates a BCM RX_SETUP filter via
sendmsg(), it modifies op->frames and resets op->last_frames directly in
process context:

net/can/bcm.c:bcm_rx_setup() {
    ...
			err =3D memcpy_from_msg(op->frames, msg,
					      msg_head->nframes * op->cfsiz);
			if (err < 0)
				return err;

			/* clear last_frames to indicate 'nothing received' */
			memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
    ...
}

Concurrently, if a matching CAN frame arrives, will bcm_rx_handler() in
softirq context locklessly read op->frames and update op->last_frames?

net/can/bcm.c:bcm_rx_handler() {
    ...
		for (i =3D 1; i < op->nframes; i++) {
			if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D
			    (get_u64(op->frames, 0) &
			     get_u64(op->frames + op->cfsiz * i, 0))) {
				bcm_rx_cmp_to_index(op, i, rxframe,
						    traffic_flags);
				break;
    ...
}

Could this lead to torn reads or writes if the filter logic misfires while
these buffers are observed in an inconsistent state, potentially delivering
corrupted or duplicate CAN frames to userspace?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v4-0-aa87b8b9d33f@hartkopp.net?part=3D2
