Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD197409266
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524902; cv=none; b=QEdgjf3pRidmd1M6CuLThZdKZFr+z6ubEL2McQWlN4k6/GRmRtpIbevd+pKIH5Jw2RugYGVscnjuJrk787T9XKqw2S2ISe2le398JatGo2Zzsml2xcQQEXA9ujyj4uhJ7Xi5ESA4b5eNEFs2icAbFaDQnBrJrkEq4FTUPkVkixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524902; c=relaxed/simple;
	bh=7p07mRwWAuxuNP2foXkhc6/xS1bWWfmYh00yza3bB9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jC+rfCiFj8MLk4Mr/GMEPzYGWvO3GI08NBhFe8sS9Ro1JkKUW9/qqGVylAOZQu3pm4NCWxqsvE/jlQAtpHUaU/PKFRrqKezzjhq3y73usHDtEsMHsy42ZOsCEmISnlnoSN9Pl2wuuXvuWCYv/1zYsHYEYsDK6dkmgqJLS0Rqw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVK/ayJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVK/ayJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EBF1F00A3A;
	Wed,  8 Jul 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524900;
	bh=BYLd675DPLAJmi2a9wG+E8vySfOO0dePhwUXM6VeQUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVK/ayJD97RWZdKKYnCZYDVPmzQ1YbpOVE8zg3r4g+nMInSMvxzBkLPTV1s0qhlr9
	 +XPFP1jz9ZtsqYXMyqWGoMGxvLs69Txh1VXn7ANmoaiDlBt1pvvK1FOiGxG5xqwRL4
	 SF2bN6n/oWEzCkmhG9JxyiyEsLFov1A5SgDccAugnsm7EgSi4HuwNR+cpyoec3raiD
	 /fWW8oCIWAGZ9CFDIw+hbRgTX2z9od6vloBaayKCr+vhC4QpFpaym1IQ/ub3X35cRj
	 IxF7VqzweiIXj4BU7wzSmGcKJQQVzJu4ZTmHn/sVLjkye6mmWgBzodqQeh3b2LCYTf
	 6uiUWCSH4u44g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260708-bcm_fixes-v7-4-c78896b342e4@hartkopp.net>
References: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
 <20260708-bcm_fixes-v7-4-c78896b342e4@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:34:59 +0000
Message-Id: <20260708153500.66EBF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The statistics reset logic introduces a race condition for RX op=
erations handling RTR frames, directly contradicting the commit's claim of =
preventing races.

Pre-existing issues:
- [Medium] Concurrent lockless updates to `op->rx_stamp` and `op->rx_ifinde=
x` cause data races and metadata corruption.
--

--- Patch [4]: [PATCH v7 04/10] can: bcm: fix CAN frame rx/tx statistics ---
commit df517d421b8dc860bfb7f92f0c455c27cf5d743e
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

This patch attempts to fix data races in the CAN broadcast manager's receive
and transmit statistics by using atomic operations. It introduces a helper
to update and reset statistics to prevent overflow.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index af4bb4182bc29..340b7fc89744e 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -290,6 +294,15 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  }
>  #endif /* CONFIG_PROC_FS */
> =20
> +static void bcm_update_stats(struct bcm_op *op)
> +{
> +	/* prevent statistics overflow */
> +	if (atomic_long_inc_return(&op->frames_abs) > LONG_MAX / 100) {
> +		atomic_long_set(&op->frames_filtered, 0);
> +		atomic_long_set(&op->frames_abs, 0);
> +	}
> +}
> +

[Severity: Medium]
If an application sets up an RX op with RX_RTR_FRAME enabled, and multiple
RTR frames arrive concurrently, could there be a race condition here?

Because bcm_update_stats() is called under bcm_tx_lock in bcm_can_tx() and
under bcm_rx_update_lock in bcm_rx_handler(), both functions can execute
for the same RX op when processing an RTR frame.

If multiple CPUs handle RTR frames concurrently, they might execute
bcm_update_stats() using different locks, causing a race on this reset
logic where valid increments are overwritten or frames_filtered temporarily
exceeds frames_abs.

>  /*
>   * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interfa=
ce
>   *              of the given bcm tx op
> @@ -344,7 +357,7 @@ static void bcm_can_tx(struct bcm_op *op, struct canf=
d_frame *cf)
>  	spin_lock_bh(&op->bcm_tx_lock);
> =20
>  	if (!err)
> -		op->frames_abs++;
> +		bcm_update_stats(op);
> =20
>  	op->currframe++;
> =20

[ ... ]

> @@ -748,16 +758,19 @@ static void bcm_rx_handler(struct sk_buff *skb, voi=
d *data)
>  	op->rx_stamp =3D skb->tstamp;
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: Medium]
This isn't a bug introduced by this patch, but does this lockless update of
rx_stamp and rx_ifindex cause data races?

When multiple CAN frames are received simultaneously on different CPUs (e.g=
.,
listening on all interfaces), these fields are updated outside the protecti=
on
of bcm_rx_update_lock.

This can lead to torn reads of the 64-bit timestamp on 32-bit systems, or
metadata mismatches where a CAN frame is sent to userspace with a timestamp
from a different frame.

> -	/* update statistics */
> -	op->frames_abs++;
> =20
> -	/* snapshot the flag under lock: op->flags/op->frames may be updated
> -	 * concurrently by bcm_rx_setup().
> +	/* snapshot RTR content under lock: op->flags/op->frames may be
> +	 * updated concurrently by bcm_rx_setup().
>  	 */
>  	spin_lock_bh(&op->bcm_rx_update_lock);
> +
> +	/* update statistics with lock analogue to bcm_rx_changed() callers */
> +	bcm_update_stats(op);
> +
>  	rtr_frame =3D op->flags & RX_RTR_FRAME;
>  	if (rtr_frame)
>  		memcpy(&rtrframe, op->frames, op->cfsiz);
> +
>  	spin_unlock_bh(&op->bcm_rx_update_lock);
> =20
>  	if (rtr_frame) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v7-0-c78896b342e4@hartkopp.net?part=3D4
