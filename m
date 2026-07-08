Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042633F12EF
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524870; cv=none; b=cVTcD3K3orLo6X6k7ipWlowF/qDXw1gMyw8GIhyQzf3HhdPsUKwnZcsZk4zJC9G8ZnVIrfT9l9PlpcKK3wsgZPB7Ywfsbc6uowRWhp5yE90Hxyu8sM9BbG5UwgqrFHeH3gJvE1RN0Fmv7hp1+UQ99renbUxJJm4OKlzK2n/xtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524870; c=relaxed/simple;
	bh=hgfzkDOSiFWoe8jUiEfxdBdbo/6Auzhdrd9ypx4PfAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X2wYp+w35p5SuKJ7NugMmSTJ4dBZuvWlwH5p5Z+ZRQLz6UxC8fbmdCA4dDxsaEykD1fOA1OrvCLK1oqMjnOPnEtuffse0XoSXwHzImU0onjXk3yWNye55LUb6AL8gHE9eXslSFAXVZrvc9ZmuTwFxkg2iAbCGeR7ieeIM3eGk1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1PtTD50; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1PtTD50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0FF1F000E9;
	Wed,  8 Jul 2026 15:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524868;
	bh=z59vpj2usUS4BOrJoBpDfOm3BSEIOEOBdgDFPgyR9Wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1PtTD503lv7hoDo9IhQJQgf2CkYkmgaAbCIYO/o82a4jEW+9a9ibE7krtdJHu/mI
	 BdqJWU9ZVN2pLW3iFst57HrWpld/glQ6kj+bYcLlXq18VZ6HC1Xs39wrVs5Iv5XbPV
	 fbePKAZw7owW84zq1us3mRuGpUzOSxlsa7d+HdEOHITyPlvPJwKytvasPwU+AOHLcS
	 5Hbre6cJ5kN72aI6D30nvhxQLCipSl88gVH8f24Z67r79BSOSF87fWfp6eNNCqiaPk
	 9mtXfK3mmbNa/vMHavQLwT/naGU5ZdYNUDuc/xiSRwJW5EVpko9yi2+Cn59/q8cunZ
	 D0jrqcyBa5GbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] can: bcm: extend bcm_tx_lock usage for data
 and timer updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260708-bcm_fixes-v7-6-c78896b342e4@hartkopp.net>
References: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
 <20260708-bcm_fixes-v7-6-c78896b342e4@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:34:27 +0000
Message-Id: <20260708153428.2C0FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bcm_can_tx() drops bcm_tx_lock between reading the frame and incre=
menting currframe, leading to frame sequence corruption if reset concurrent=
ly.
- [High] Torn reads and race conditions when reading timer variables, count=
, and flags outside of the protective spinlock in bcm_tx_timeout_handler() =
and bcm_proc_show().
--

--- Patch [6]: [PATCH v7 06/10] can: bcm: extend bcm_tx_lock usage for data=
 and timer updates ---
commit 71db2892f1d82b77f3491796e67189db751f4bb1
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: extend bcm_tx_lock usage for data and timer updates

Stage new CAN frame content for an existing tx op into a kmalloc()'d
buffer and validate it there, mirroring the approach already used in
bcm_rx_setup(). Only copy the validated data into op->frames while
holding op->bcm_tx_lock, so bcm_can_tx() and bcm_tx_timeout_handler()
can no longer observe a partially updated or unvalidated frame.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -477,8 +483,17 @@ static enum hrtimer_restart bcm_tx_timeout_handler(s=
truct hrtimer *hrtimer)
>  {
>  	struct bcm_op *op =3D container_of(hrtimer, struct bcm_op, timer);
>  	struct bcm_msg_head msg_head;
> +	bool tx_ival1, tx_ival2;
> =20
> -	if (op->kt_ival1 && (op->count > 0)) {
> +	/* snapshot kt_ival1/kt_ival2/count under lock to avoid torn
> +	 * ktime_t reads racing with concurrent bcm_tx_setup() updates
> +	 */
> +	spin_lock_bh(&op->bcm_tx_lock);
> +	tx_ival1 =3D op->kt_ival1 && (op->count > 0);
> +	tx_ival2 =3D !!op->kt_ival2;
> +	spin_unlock_bh(&op->bcm_tx_lock);
> +
> +	if (tx_ival1) {
>  		bcm_can_tx(op, NULL);
>  		if (!op->count && (op->flags & TX_COUNTEVT)) {

[Severity: High]
This is a pre-existing issue, but does bcm_tx_timeout_handler() have torn
reads for timer variables?

Just after the lock is dropped in the hunk above, bcm_tx_timeout_handler()
creates a notification to the user:

bcm_tx_timeout_handler() {
    ...
    spin_unlock_bh(&op->bcm_tx_lock);

    if (tx_ival1) {
        bcm_can_tx(op, NULL);
        if (!op->count && (op->flags & TX_COUNTEVT)) {
            ...
            msg_head.count   =3D op->count;
            msg_head.ival1   =3D op->ival1;
            msg_head.ival2   =3D op->ival2;
            ...
}

Because ival1 and ival2 are multi-word structures read outside the lock,
could a concurrent bcm_tx_setup() holding bcm_tx_lock overwrite these fields
and tear the values sent to user space?

Also, does bcm_proc_show() have a similar issue since it reads 64-bit
kt_ival1 and kt_ival2 under only rcu_read_lock() on 32-bit platforms?

[ ... ]

> @@ -1028,11 +1045,23 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
[ ... ]
> +		spin_lock_bh(&op->bcm_tx_lock);
> +
> +		/* update CAN frames content */
> +		memcpy(op->frames, new_frames, msg_head->nframes * op->cfsiz);
> +
>  		op->flags =3D msg_head->flags;
> =20
> -		/* only lock for unlikely count/nframes/currframe changes */
>  		if (op->nframes !=3D msg_head->nframes ||
> -		    op->flags & TX_RESET_MULTI_IDX ||
> -		    op->flags & SETTIMER) {
> -
> -			spin_lock_bh(&op->bcm_tx_lock);
> +		    op->flags & TX_RESET_MULTI_IDX) {
> +			/* potentially update changed nframes */
> +			op->nframes =3D msg_head->nframes;
> +			/* restart multiple frame transmission */
> +			op->currframe =3D 0;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but does resetting currframe
here race with bcm_can_tx()?

Looking at bcm_can_tx(), it drops the lock between reading the frame and
incrementing currframe:

bcm_can_tx() {
    if (!cf) {
        spin_lock_bh(&op->bcm_tx_lock);
        memcpy(&cframe, op->frames + op->cfsiz * op->currframe, ...);
        spin_unlock_bh(&op->bcm_tx_lock);
    }
    ...
    can_send(skb, 1);
    ...
    spin_lock_bh(&op->bcm_tx_lock);
    ...
    op->currframe++;
    if (op->currframe >=3D op->nframes)
        op->currframe =3D 0;
    spin_unlock_bh(&op->bcm_tx_lock);
}

If a concurrent bcm_tx_setup() acquires bcm_tx_lock, writes new frames, and
sets op->currframe =3D 0 while bcm_can_tx() is busy sending the old frame,
bcm_can_tx() will re-acquire the lock and erroneously increment currframe
to 1.

Will this skip the newly programmed first frame and cause sequence
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v7-0-c78896b342e4@hartkopp.net?part=3D6
