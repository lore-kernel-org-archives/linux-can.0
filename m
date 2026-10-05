Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E647F76A;
	Mon,  5 Oct 2026 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202440; cv=none; b=pA7sZH+SBqScXQeU3e6/Bz9Vkoa0m0FvpJqPVcvPfdIhrIL3tfeiIGiHCaCKu+++9czowAFn4nOJrA0ulFfTIaNkdTUy9ICKMPCCkyTI93waMqV2mnDdPYompbdgduNf0S9mLNzesP5IPCJZ+RnicPU9PpudsBnJ6NKgJRkHIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202440; c=relaxed/simple;
	bh=CMLYsUFen46WF4cVmtYxCWRanAtq6UJ2jTVFPfKu6bg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VcjYdjtbiAo1jtwlalUHoCUHP3m6CTkZU+DXdN4cckJJk6tP6CtwJtDUVgDc8WnS4FiU9LBG808cygNMC5teIeM6/zXyZuoY9uDPkqHb0KC2KZ/S0CqlZPSGO4WJGTducPPcwswjFcPCWT/2jkBgEqZNOLF8vHM+HD91EyWX/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgRge8l0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgRge8l0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A8F1F000FF;
	Mon,  5 Oct 2026 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202438;
	bh=DYpk9WY4SQbcuVOEQYZQLiDh/O7aM3qTQqeXViVQKKg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MgRge8l0I0FivhU4xivYDp81Fb0RQvR8KvqPRHhoWlJXmi2wmWLFjViHL8jUb0YOi
	 nCTyBaCM+msJVVM5z8SBdlw4Kpk6NKKyn3bgMbls0RKLdWeI5GMnrn6bqGM/tLlBVT
	 ITnDY6QGsBbZSXbov1Vm1cxr2WMSzQBHNG61bKJs1Exg5nUKnyUp4M6CCNrVJa86kw
	 aVARmWQCXeuHsnlCu/4R79nAu8/Gi1ejDw8RLMR3vfrB9ok8Sn1gLNf2FAxLziHLwt
	 1P0WxifDWJ83FPcYnwM7OCmAI/IWLxRWwKynCgvjNm1tDqHw3JUIcipjO4I2PTIAxB
	 S3ftLHbvv86xA==
Subject: Re: [PATCH can-next 07/10] can: gs_usb:
 gs_usb_receive_bulk_callback(): report channel number out of range error
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Mon, 05 Oct 2026 12:13:57 +0000
Message-ID: <179120243766.1406898.6206255223558959543@kernel.org>
In-Reply-To:
 <20261004-gs_usb-cleanups-and-fixes-v1-7-7b4b06244a77@pengutronix.de>
References:
 <20261004-gs_usb-cleanups-and-fixes-v1-7-7b4b06244a77@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message body of "can: gs_usb:
  gs_usb_receive_bulk_callback(): report channel number out of range…

Pre-existing issues:
- [High] In gs_usb_receive_bulk_callback()
  (drivers/net/can/usb/gs_usb.c), the channel check only tests the upper…

--

can: gs_usb: gs_usb_receive_bulk_callback(): report channel number out of range error

If the USB device sends a frame with an out of range channel number,
gs_usb_receive_bulk_callback() now logs a rate limited error before it
jumps to the device_detach label. Before this patch it detached without
logging anything. Nothing else changes.

> If the USB device sends an invalid channel, the device should not be
> silently detached; instead, the display an error message before detaching.

[Severity: Low]
This isn't a bug, but "instead, the display an error message" reads
wrong. Maybe "instead, display an error message before detaching"?

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 9a0635b9c2d44..85a10c43b6f73 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -627,8 +627,13 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  	}
>  
>  	/* device reports out of range channel id */
> -	if (hf->channel >= parent->channel_cnt)
> +	if (hf->channel >= parent->channel_cnt) {
> +		dev_err_ratelimited(&parent->udev->dev,
> +				    "channel number out of range (channel=%u, channel_cnt=%u)\n",
> +				    hf->channel, parent->channel_cnt);
> +
>  		goto device_detach;
> +	}
>  
>  	dev = parent->canch[hf->channel];

[Severity: High]
This isn't a bug introduced by this patch, but this check only tests the
upper bound. Can parent->canch[hf->channel] still be NULL when it is read
here?

The code right after this does:

	dev = parent->canch[hf->channel];

	netdev = dev->netdev;

gs_usb_probe() sets channel_cnt to cover all channels before any slot is
filled:

	parent->channel_cnt = icount;
	...
	for (i = 0; i < icount; i++) {
		...
		parent->canch[i] = gs_make_candev(i, intf, &dconf);

gs_make_candev() calls register_candev() before it returns. That means
can0 is visible to userspace while probe is still running the control
transfers for channel 1. Each transfer can take up to 1000 ms, and the
device decides how long it takes to answer.

If userspace brings can0 up in that window, gs_can_open() submits the RX
URBs:

	if (!parent->active_channels) {
		...

A device that reports icount >= 2 could then send a bulk-IN frame with
channel=1. The check above passes because 1 < channel_cnt. dev is then
NULL, and dev->netdev is dereferenced in URB completion context.

There is a related case when gs_make_candev() fails for a later channel.
The ERR_PTR is stored in the slot first:

	parent->canch[i] = gs_make_candev(i, intf, &dconf);
	if (IS_ERR_OR_NULL(parent->canch[i])) {

The rollback kills the RX URBs only when it destroys the earlier
channels. Until then, a frame for that channel would dereference the
ERR_PTR.

The device_detach loop has the same gap. Its test lets an ERR_PTR
through:

	if (parent->canch[rc])
		netif_device_detach(parent->canch[rc]->netdev);

Should this path also reject an empty slot, for example with
!parent->canch[hf->channel]? Another option is to stop storing ERR_PTR
values in canch[]. A third is to create all channels before any of them
is registered.

This check is still unchanged at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77%40pengutronix.de
