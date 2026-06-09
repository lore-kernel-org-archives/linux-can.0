Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0D43CED8
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2026 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031355; cv=none; b=FZsnxz2A6EYS3SQMJxDvjo45TVNgjtRU81Ax7fMp0TTY3FVpU/bdEGCRgcqrMqew/6i7qmxL/3Z1dgi6mmDIUgs2X4sbu7AurgPUYCFVY3AvhkgzirmqVok+ZMxsv67J6wXKz5vuNHtozZtrv7P+QiP2DkKu2tHBn2IIg9gy4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031355; c=relaxed/simple;
	bh=req+7xxZ9Uyl6/fFk0/z8if+qP8iq9XLWq89O0ic1A4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KiKn2CHv3FzXTftn8j5WI2x7EDhXDIkIpCUWiFoYONlDFcpZyDjT3lmmnl+8VwGaqpsIKBZNeC5brSIODZc6L4IrTEEfj8PRO5cLklHifknPr6Qp0l4KbZAUWwHEcCVs+mjsyp2He1aFTMvKdGKLf3i9tV+zD2anml0jN/Qikjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/oAW/CG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/oAW/CG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D621F00893;
	Tue,  9 Jun 2026 18:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031353;
	bh=zJLJnsuePPZsIxh7JO11imgAcIFquyJgXdpscR1m5Mc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K/oAW/CGUUN3em+zrtBccXQ1hfSjCQQPhrCgeRiWWr+btdSruP4uzUzxKQqBzoU9b
	 WLRwhvyG0ot1pjbzWhEogpIlyWuAfEn9Fh9VxdgJWVjTYL7pYd2USPSUQQKsJ24ONB
	 IlEW3BVetHOOl396NpLJI0htocgy2TSzFIF8IhhvgdaoVH+YEsjzEB4AFADAkGPjRr
	 AxiCc3copiKXuPclzvHeq4WyHD0aDueuWVVfq3JC09JFGcfrGn/2CfqBAk2P4yYHxJ
	 THAutQQsOCbA4aR5U3axcokY5FRsaMv+3kePGR1Sj90FEpdAP3ezU7dMHB64Jvep3G
	 AVn5rAg9I0osQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] can: bcm: add locking when updating filter and
 timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260522180758.51128-2-socketcan@hartkopp.net>
References: <20260522180758.51128-2-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:55:52 +0000
Message-Id: <20260609185553.61D621F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent RX_DELETE and CAN frame reception can cause a timer to =
be armed after it was canceled, leading to a Use-After-Free.
--

commit a1560c18e32869b3dc94d859252cf67b537b151d
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

KCSAN detected a simultaneous access to timer values that can be
overwritten in bcm_rx_setup when updating timer and filter content.

Fix the RX_SETUP update case by protecting the timer and filter updates
with a spin_lock_bh().

Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@g=
oogle.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..dbdf5d4f4ed7b 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -774,6 +788,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void =
*data)
> =20
>  rx_starttimer:
>  	bcm_rx_starttimer(op);
> +
> +	spin_unlock_bh(&op->bcm_rx_update_lock);
>  }

[Severity: High]
This is a pre-existing issue, but does this still leave a race condition
with bcm_delete_rx_op()?

Even with bcm_rx_update_lock held here, bcm_delete_rx_op() modifies
op->flags without taking bcm_rx_update_lock:

net/can/bcm.c:bcm_delete_rx_op() {
	...
	/* disable automatic timer on frame reception */
	op->flags |=3D RX_NO_AUTOTIMER;
	...
	bcm_remove_op(op);
}

And bcm_remove_op() cancels the timers and queues the object for RCU freein=
g:

net/can/bcm.c:bcm_remove_op() {
	hrtimer_cancel(&op->timer);
	hrtimer_cancel(&op->thrtimer);
	call_rcu(&op->rcu, bcm_free_op_rcu);
}

If bcm_rx_starttimer() reads the old op->flags value, can it be executed
after bcm_remove_op() has already canceled the timers? This would result in
the timer being re-armed on a soon-to-be-freed object, potentially leading
to a use-after-free when the timer fires.

Should bcm_delete_rx_op() also take bcm_rx_update_lock when updating
op->flags?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522180758.5112=
8-1-socketcan@hartkopp.net?part=3D1
