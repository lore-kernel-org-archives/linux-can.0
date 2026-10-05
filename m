Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00B47CA6D;
	Mon,  5 Oct 2026 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202437; cv=none; b=QOS6Xu1qa8++SLkb1cJKVKykhZGLw4WWCRrj8sFPSBqnu44WpGPLbBBAiUysWFfCHqaxg81Uubulk5FvyyVEymb88ByEp6aE9lwcgEx2IcbEptgDZA6D2rtz04NIc2/xJ0buzTVJn02chPukhgXdVoXDUKZVhJVlrboJYnEDT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202437; c=relaxed/simple;
	bh=r7Sv4wIFqm7qudJ/euYu7ZH2CqbgZ2NOekGh5HOTAZM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pe0xdNMINxhjKTu0Kce7qaXOtLZzhG1/W1sUEUFEzxUTOtA8s9tPas7rULFXQL9iyAC3S1FBYzmukBFSI+joE/yoaUb86rTf+A+wAKtLI7axtTs3ab//xDFSI2Z4Yz6M4nHtwWmzIT8GiuWQt5J8MdRibaUXKXVSDL1lWrQ11G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9Brvrc7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Brvrc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2361C1F000FF;
	Mon,  5 Oct 2026 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202436;
	bh=HaxOqRZNQtlCr4xSQ7Wgtvu+rEvP4LtfY6r6Eu1y72c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f9Brvrc7UzVFtDBU06WwrEDxr+uudDum7aueMflRC/jph+A8OQeBHGSrul1wxsni4
	 gPy/gPPIhETzUrdn/Zk54ytj8EB0ce9kbkukxhL20Ds2lurwrUlyFeDaiLeJ1I7BcI
	 80sn6UPxfcSEbnkh/DTYehY0WiH0l4mEu+5CgavP+k025w7F/aRCqDkxYyONWcC8Pp
	 7SDv9ruJHLAMCQ4M+GECQ1cbU7lZ7k/Kt24nZJxi5yKRH227//2oqnY2e+UfCdyYK+
	 K3OuFRWHdjhpJeUx7Vzv/lWNF9cDpQBsk6DCS6XdxTR9SK1b2IkYP5FeRF/1ILr2oT
	 0yQUdpyRnkYJg==
Subject: Re: [PATCH can-next 05/10] can: gs_usb:
 gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation
 fails
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Mon, 05 Oct 2026 12:13:55 +0000
Message-ID: <179120243560.1406898.8221038750798681974@kernel.org>
In-Reply-To:
 <20261004-gs_usb-cleanups-and-fixes-v1-5-7b4b06244a77@pengutronix.de>
References:
 <20261004-gs_usb-cleanups-and-fixes-v1-5-7b4b06244a77@pengutronix.de>
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

- [Low] The commit "can: gs_usb: gs_usb_receive_bulk_callback(): check
  for overflow flag if SKB allocation fails" fixes a real bug but has no…

--

can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails

When SKB allocation fails in gs_usb_receive_bulk_callback(), this patch
jumps to a new check_overflow label instead of jumping straight to
resubmit_urb. As a result, the GS_CAN_FLAG_OVERFLOW handling still runs
when alloc_canfd_skb() or alloc_can_skb() fails.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 0a9c490c0c445..f40f825b7eb29 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -712,6 +712,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  		netif_wake_queue(netdev);
>  	}
>  
> +check_overflow:
>  	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
>  		stats->rx_over_errors++;
>  		stats->rx_errors++;

[Severity: Low]
Should this commit have Fixes: tags and a Cc: stable?

Before this change, gs_usb_receive_bulk_callback() skipped the
GS_CAN_FLAG_OVERFLOW block whenever alloc_canfd_skb() or alloc_can_skb()
failed. In that case:

- rx_over_errors and rx_errors were not incremented
- no CAN_ERR_CRTL_RX_OVERFLOW error frame was attempted

For classic CAN frames, the missed check goes back to the original driver.
For the FD branch, it goes back to the CAN-FD support:

  d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
  26949ac935e3 ("can: gs_usb: add CAN-FD support")

An earlier fix to these same lines has both of those Fixes: tags and
Cc: stable@kernel.org:

  68c5724ecd15 ("can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB
  on skb allocation failure")

Without matching tags here, stable trees that took 68c5724ecd15 would not
automatically get this follow-up fix for the overflow accounting.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77%40pengutronix.de
