Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47713A86C
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412940; cv=none; b=jYo8Q4B5mH/37H0+nvgdJ6hl/qBxOtLLPSxEE381GVtuIGTAyQtd13J0SRDly2iC4TeKfQbGPDoc4nc3hcGXtJ6KfQ85iZKOgzfn32s6uFsYja1Kt7JNmfsbYwnDovN69ZiJwLi0izy5fkNw5eRYrir6pIfLK9y3a6CcL6PKnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412940; c=relaxed/simple;
	bh=hPX8iZRcMUMPDER5GTeQe5IFInl/tdn8V7m7qxSjISI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U6cAPNOAWecdkl44K4oBMh2qOCWAEUzv6KiEhm+MhsKs/IGxEXpzhU0BBl4yzjcDlutqIf1uOfu7Gz2mEyiOmKuG5aRZ2zESCbf5+/oGdB/ATKcS3uQn7w3DYIcZDMwBpTCLYeCdJTu3JIvSRzoXLYFxEfxgxCFOqIudVnWFMSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3B3Vy0l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3B3Vy0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DC51F00A3A;
	Tue,  7 Jul 2026 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412939;
	bh=v4wyhhvNdY1i74fhHedvNHReN6e1CodZqhuk6kg0dSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3B3Vy0laZVcy5C4bEy0EY99it2D/9q1ziAR74riCCpFXl7GIjx2dYeHVkuK71+dB
	 r07zmKO4EQ9nArN6jxnkqCvSCTF+pfSf5NH2dhaJIAJPwLsWr9WeBvbWSD7wUpgltt
	 c4KU7LzQVTEpDE+ZVTGnD8MdOVUw2AHQZHe6U1Ho+C6mFEhlhw+kquR/5P8fq8f4fk
	 v9c20LRodGCIXIvkujJotctrdUg05nQNgow2dgB3dhATw+tFBku/X1uXhIKEqCoXXn
	 U4mybBw4AtknkQTqrlOqO4VY8E9t4/N73f0S7uNoRL285m4s0rfDcw81kATY/5Zyp/
	 B8RH5q62qoAyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] can: bcm: add locking when updating filter and
 timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260707-bcm_fixes-v2-3-96620c534b75@hartkopp.net>
References: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
 <20260707-bcm_fixes-v2-3-96620c534b75@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:28:58 +0000
Message-Id: <20260707082859.25DC51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The TX timeout handler reads 64-bit ktime_t variables and 32-bit s=
tate variables locklessly, creating data races that can lead to torn ktime_=
t reads and erratic timer behavior.
- [High] The CAN frame payload on the transmission side is copied into the =
SKB locklessly, allowing a concurrent update from userspace to overwrite th=
e frame while it is being transmitted, resulting in torn CAN frames.
--

--- Patch [3]: [PATCH v2 3/6] can: bcm: add locking when updating filter an=
d timer values ---
commit 5cea5eef9652435aa644979477f4e925e5e24c8f
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

This commit adds a new per-op bcm_rx_update_lock to protect timer and
filter data updates in the RX handlers against concurrent execution. It
also addresses an RTR flag clearing race by normalizing the frame content
during initial preparation instead of modifying the live frame.

Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@g=
oogle.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..1eabacad0b001 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -293,22 +294,23 @@ static int bcm_proc_show(struct seq_file *m, void *=
v)
>   * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interfa=
ce
>   *              of the given bcm tx op
>   */
> -static void bcm_can_tx(struct bcm_op *op)
> +static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
>  {
>  	struct sk_buff *skb;
>  	struct can_skb_ext *csx;
>  	struct net_device *dev;
> -	struct canfd_frame *cf;
>  	int err;
> =20
>  	/* no target device? =3D> exit */
>  	if (!op->ifindex)
>  		return;
> =20
> -	/* read currframe under lock protection */
> -	spin_lock_bh(&op->bcm_tx_lock);
> -	cf =3D op->frames + op->cfsiz * op->currframe;
> -	spin_unlock_bh(&op->bcm_tx_lock);
> +	if (!cf) {
> +		/* read currframe under lock protection */
> +		spin_lock_bh(&op->bcm_tx_lock);
> +		cf =3D op->frames + op->cfsiz * op->currframe;
> +		spin_unlock_bh(&op->bcm_tx_lock);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but can this lead to torn CAN
frames during transmission?

While the bcm_tx_lock protects the calculation of the cf pointer here, the
lock is dropped before calling skb_put_data(skb, cf, op->cfsiz) further
down in bcm_can_tx().

Concurrently, bcm_tx_setup() can overwrite the active op->frames buffer
using memcpy_from_msg() directly from userspace locklessly:

net/can/bcm.c:bcm_tx_setup() {
    ...
    cf =3D op->frames + op->cfsiz * i;
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Could this allow a partially updated CAN frame to be copied into the skb and
transmitted onto the network while the data is being mutated?

[ ... ]
> @@ -461,7 +463,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(st=
ruct hrtimer *hrtimer)
>  	struct bcm_msg_head msg_head;
> =20
>  	if (op->kt_ival1 && (op->count > 0)) {

[Severity: High]
This is a pre-existing issue, but can the lockless read of op->kt_ival1
result in a torn read on 32-bit platforms?

In bcm_tx_setup(), the 64-bit ktime_t variables kt_ival1 and kt_ival2 can
be updated concurrently from user space data. Evaluating these values
in bcm_tx_timeout_handler() and bcm_tx_set_expiry() without holding
bcm_tx_lock could yield arbitrary timer intervals.

Could this cause the hrtimer to stall indefinitely or fire in an immediate
tight loop?

> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);
>  		if (!op->count && (op->flags & TX_COUNTEVT)) {
> =20
>  			/* create notification to user */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v2-0-96620c534b75@hartkopp.net?part=3D3
