Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002A14ABE
	for <linux-can@vger.kernel.org>; Sun, 19 Jul 2026 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784430831; cv=none; b=HmWb+zqKhfcV/1fUIO04HPsrv6PO2NKqPUgFYA2pZkmZT8t5n9HW8AH414Lkkgc26fU6BbCNzVbPvVxGvYQP78joC7DRH2/zxOmvQgSTOLDijvjp4x+39o0TkYtRoAsWghoflXgpJs4R5J9k6WfWocOUU+4uSBHqUvnW+BNbozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784430831; c=relaxed/simple;
	bh=SiNXG/EaRaCgAi7xM/fjGRsrKl14/i03ba0wVIWHewo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i77gZe/2UOMqj0l+vKC3JfLtNHCAeWAf0q7CSajWT9pVDzeeph/E1XADwibQzX+s+coxUcVrPFQPqlFnk8XLoBnn2sFIGhghds9ttJRi9Q5ECCnOTv130/4TCedY8ZRpzlz+sqwhuan2XHI4Es5G6/3eHf/INDnx6jl6xNEmtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhkyKSx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhkyKSx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0CA1F000E9;
	Sun, 19 Jul 2026 03:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784430830;
	bh=fu0Ka3ow6eMEOx+FU5Ra73V634z0qwpJOlyI7Ea+nak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DhkyKSx696jFg3LDEQ1nb+WieQs3DWM/AbCWOIkiW5IujkUQDoGdmYxaXqU+6xV2R
	 LSyQnfzN12kp2gn1mqQF1kTMctGs000BKtmnVcqhh4VGkSS/H7//3VbPsZZDyRlmOc
	 jDC2AoepBTT0PmyQJBp+vIMa7W+g7Z83VC7tj6khDamXIUw+8uIQX2H0g6YLip5V42
	 QIielxUiV8jj2O3EsKNm0SxORDiMhLiIQ6FcnTzkMnDc0U2BjsilRkrD9NZ4C0WT09
	 aN2DBUIzyBwJ5LW9LplQ+UQLdOif6x7EW880yujZmVhS7Vs8ApT0KLpwY9BsthUu5i
	 ougRjPJXWxkzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can v2] can: gs_usb: fix hardware timestamp state for
 mixed channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuangpeng Bai" <shuangpeng.kernel@gmail.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260719030000.3667449-1-shuangpeng.kernel@gmail.com>
References: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
 <20260719030000.3667449-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 03:13:49 +0000
Message-Id: <20260719031349.BD0CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data race and lock corruption due to unprotected initialization of=
 shared timestamp lock
--

--- Patch [1]: [PATCH can v2] can: gs_usb: fix hardware timestamp state for=
 mixed channels ---
commit 5294b98eba495191f8e49a8e183658cbb1702465
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

can: gs_usb: fix hardware timestamp state for mixed channels

This patch decouples the hardware timestamp state from active_channels. It
tracks timestamp-capable channels separately to fix initialization for
mixed-channel devices.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index ec9a7cbbbc696..9cc197803e0d7 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
[ ... ]
> @@ -980,10 +981,13 @@ static int gs_can_open(struct net_device *netdev)
> =20
>  	can_rx_offload_enable(&dev->offload);
> =20
> -	if (!parent->active_channels) {
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
> +		if (!parent->active_timestamp_channels)
>  			gs_usb_timestamp_init(parent);
> +		parent->active_timestamp_channels++;
> +	}
> =20
> +	if (!parent->active_channels) {
>  		for (i =3D 0; i < GS_MAX_RX_URBS; i++) {
>  			u8 *buf;

[Severity: High]
Can this corrupt the tc_lock spinlock if an RX callback executes concurrent=
ly?

Since gs_usb_timestamp_init() is now called independently of
!parent->active_channels, it can execute while RX URBs are already polling =
(if
a non-timestamp channel was opened first).

gs_usb_timestamp_init() re-initializes the lock and timecounter:

    spin_lock_init(&parent->tc_lock);
    spin_lock_bh(&parent->tc_lock);
    timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());

If a USB device injects an RX frame during this window, the active RX URB
completion handler (gs_usb_receive_bulk_callback) can process it. Because
__dev_open() sets __LINK_STATE_START before calling ndo_open(), the
netif_running() check in the callback will pass, and
gs_usb_skb_set_timestamp() could attempt to acquire parent->tc_lock at the
same time it is being re-initialized.

Is there a way to safely initialize this lock before URBs are active, or
initialize it only once during device probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719030000.3667=
449-1-shuangpeng.kernel@gmail.com?part=3D1
