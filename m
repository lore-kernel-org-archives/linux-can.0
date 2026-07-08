Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9641A798
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503450; cv=none; b=LxX2g4eUkvh8s9WSQEv6ODKnTO8DwYwKyiPP4/NoXOLMrma4Xly/Nwnw3R2bpQ/YL4Ly6kMQmXc8yBZ7PQTqvSgOUHTgKTerzW74DUV2r7i/cFcGsZcs7yt6RPmTTCxKFEiU/FWMddhn5elJ2aSmCZMCIfWbyvohdI9VkqwklZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503450; c=relaxed/simple;
	bh=GBkIigNTG0qphgx3S0s6JG7+ULhCG1snkzVFLAdBqXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IFOWblrSu7dmUQ7TwwEbItAw+DCN2pjxaulXrX3Zua42tE5WeXdn0wJSBw45t6Ko1MgT3y4Ldf5dq3g7QUbp75Zabr9CWb/q/KWneEhi+xMcO5XH7WStZCjEQJsofoIiaxcyvn45wnvA9XI2mYWEKp27ahhnVGP9HwaUFURDIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciVUTpwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciVUTpwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718AA1F00A3A;
	Wed,  8 Jul 2026 09:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503446;
	bh=tYv36JDuFDmwgojQqi9BdDqq9vjJx+mPEZ/T+kyZrY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ciVUTpwzKB4Z12yEIGnFN2CFN0Le3qczJLJyZrr5vzRcG74NVfpRxloSpvIjsNDVF
	 MSkuaB3xmRfLhc5HIqlCD2vifnpNV5HseBURcI7h4DB/pFEzXOagCx0TTie6almewP
	 FlOT/zQxbrIyuUO3kEpZkLN1qN+/B8zXsu9Ywsxx8cCAHLVJo9aX5UksNNZOKn7s94
	 4EBH9u/OFQiDs1VsAQ2xo4MPTS3ZuFTgsyvCwuaRZO7JGD+uQl4acqNE87s8GBkP7N
	 /dnITsOwDt+zcIpIKkOh2dKw+mpYtq+AvrtYPC/HhFxGQTIb0grF9ps0w+bs+R5+bM
	 8iQfuMX1uxTag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] can: bcm: add locking when updating filter and
 timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260708-bcm_fixes-v6-3-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
 <20260708-bcm_fixes-v6-3-80710a2bc398@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:37:26 +0000
Message-Id: <20260708093726.718AA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Torn reads of 64-bit ktime_t variables and op->count in bcm_tx_tim=
eout_handler.
- [Medium] Unprotected state modifications in bcm_rx_handler lead to data r=
aces when listening on all interfaces.
--

--- Patch [3]: [PATCH v6 3/9] can: bcm: add locking when updating filter an=
d timer values ---
commit 27c469169060f50f95adf2e7ea3b4871de414a2e
Author: Oliver Hartkopp <socketcan@hartkopp.net>

    can: bcm: add locking when updating filter and timer values
   =20
    KCSAN detected a simultaneous access to timer values that can be
    overwritten in bcm_rx_setup() when updating timer and filter content
    while bcm_rx_handler(), bcm_rx_timeout_handler() or bcm_rx_thr_handler()
    run concurrently on incoming CAN traffic.
   =20
    Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.G=
AE@google.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..af4bb4182bc29 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -461,7 +466,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(st=
ruct hrtimer *hrtimer)
>  	struct bcm_msg_head msg_head;
> =20
>  	if (op->kt_ival1 && (op->count > 0)) {
> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);
>  		if (!op->count && (op->flags & TX_COUNTEVT)) {

[Severity: High]
This is a pre-existing issue, but does bcm_tx_timeout_handler() read
kt_ival1, kt_ival2, and count without holding bcm_tx_lock?

A user application could concurrently update timer values via
bcm_sendmsg(TX_SETUP | SETTIMER) while the active hrtimer callback
bcm_tx_timeout_handler() executes in softirq context. This could result in a
torn read of the 64-bit ktime_t timeout values on 32-bit systems,
potentially causing incorrect timer expiry times. Data races on op->count
can also cause TOCTOU bugs resulting in missed or extra transmissions.

In bcm_tx_setup(), the timer interval values appear to be written without
acquiring bcm_tx_lock:

	if (op->flags & SETTIMER) {
		/* set timer values */
		op->ival1 =3D msg_head->ival1;
		op->ival2 =3D msg_head->ival2;
		op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
		op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);

[ ... ]

> @@ -729,9 +751,18 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  	/* update statistics */
>  	op->frames_abs++;

[Severity: Medium]
This isn't a bug introduced by this patch, but can op->rx_stamp,
op->rx_ifindex, and op->frames_abs be updated concurrently on multiple CPUs
before bcm_rx_update_lock is acquired?

If a BCM socket is bound to all interfaces (ifindex =3D 0) and multiple CAN
interfaces receive frames matching the filter simultaneously,
bcm_rx_handler() can run concurrently on multiple CPUs for the same bcm_op.
Could this lead to lost statistic increments, interleaved metadata, or a
torn read of the 64-bit rx_stamp on 32-bit systems?

> -	if (op->flags & RX_RTR_FRAME) {
> +	/* snapshot the flag under lock: op->flags/op->frames may be updated
> +	 * concurrently by bcm_rx_setup().
> +	 */
> +	spin_lock_bh(&op->bcm_rx_update_lock);
> +	rtr_frame =3D op->flags & RX_RTR_FRAME;
> +	if (rtr_frame)
> +		memcpy(&rtrframe, op->frames, op->cfsiz);
> +	spin_unlock_bh(&op->bcm_rx_update_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v6-0-80710a2bc398@hartkopp.net?part=3D3
