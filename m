Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E637BE7D
	for <linux-can@vger.kernel.org>; Mon,  6 Jul 2026 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303406; cv=none; b=uS/RjauksGVSnjzlRb88nqZw1f8TuiLnThlfriG/Axds6fpZyBvf9Vt/BfWhTtxDR574wNCkcERmbFoGaiezP6l/cVRpOGP6JZzW3X9HQYQt0hM9Ki6L9IvFGCihkMlkqSR4ZiC6Bho1iNHim3ZGC9ajvTP7ImUtz2UNG3k5QaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303406; c=relaxed/simple;
	bh=b6rRuQpLaHH5hvgAP3hzMsPhGKv1cnyiTgi1iLZxKmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gPnh4vJqoOMpIRMrCz9BCbyQlIF+dfCtaTP+siwYwtf+UxIdwWvKpki+5EE4/Qh+kBjPhNayl2AxhQ4/akrZaQxP6+L4EuIyBKzHFhQSO83zAjCvh9gwH8KQSpZL175f/hMGgPjyzbZJS2AXOkC9T7f9yihA23kf5z+7p23Pnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzypvMY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzypvMY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0DA1F000E9;
	Mon,  6 Jul 2026 02:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303405;
	bh=oMnRV6hah1q5gFtTTO8m5XJfWdQVKOC5oCfcQ6WwTZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CzypvMY6aQUin6ITTNglglhMxO5hvVhPt2AL2I4GRW0PLNOriGw9gbvP4dihSCj3u
	 lpJbisKVYVmImemuPIGd65tCeVmuNRhrsG7G2LMkjGy6GTcpPrGI8NlOgyIWoaT778
	 fQFQ7iQNdkq+6WunPi7RvuEdAgG6zHtEsIytgtFUDzC43LbCurlSjJWLrAjWpKgwqe
	 BiI3PWE4Wy2yNzfP8qrdQx3hNg7ce9JCTwezEdITjKjFHsILjL23nhBS0UMDMMuFZS
	 FpKFBBz/wFd7Ta9nAaQH2d2Gj69pPft6gs4KiMlwHzCnEeO2C4d2+kya9Z5gofn1xu
	 CLqg4EYbHOAvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] can: usb: etas_es58x: Fix RX buffer leak on URB
 resubmit failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260706014601.415445-1-lgs201920130244@gmail.com>
References: <20260706014601.415445-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:03:22 +0000
Message-Id: <20260706020323.8C0DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The TX URB is accessed after it is freed when es58x_submit_urb() f=
ails, leading to a double free and Use-After-Free.
- [High] usb_free_coherent() is called from an URB completion handler (atom=
ic context), violating IRQ context safety rules.
--

commit fe545bd17f0a8dbd30c2399351f0a4beb7cf3f76
Author: Guangshuo Li <lgs201920130244@gmail.com>

can: usb: etas_es58x: Fix RX buffer leak on URB resubmit failure

es58x_read_bulk_callback() resubmits the RX URB after processing a
received packet. If the resubmit succeeds, the URB remains anchored and
will be handled by the normal RX path or by teardown.

> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/ca=
n/usb/etas_es58x/es58x_core.c
> index b259f61098083..e1724ae79c5a1 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -1476,7 +1476,6 @@ static void es58x_read_bulk_callback(struct urb *ur=
b)
>  		dev_err_ratelimited(dev,
>  				    "Failed resubmitting read bulk urb: %pe\n",
>  				    ERR_PTR(ret));
> -	return;
> =20
>   free_urb:
>  	usb_free_coherent(urb->dev, urb->transfer_buffer_length,

[Severity: High]
This is a pre-existing issue, but does removing this return statement expan=
d a=20
bug where usb_free_coherent() is called from an URB completion handler?

es58x_read_bulk_callback() executes in atomic context. usb_free_coherent()
wraps dma_free_coherent() which may sleep on some architectures when unmapp=
ing
memory.=20

Can this cause a "BUG: scheduling while atomic" panic during RX resubmit
failure?

[Severity: High]
This isn't a bug introduced by this patch, but does the transmit error path=
 have=20
a double free when es58x_submit_urb() fails?

If usb_submit_urb() fails during packet transmission:

drivers/net/can/usb/etas_es58x/es58x_core.c:es58x_submit_urb() {
	...
	usb_unanchor_urb(urb);
	...
	usb_free_urb(urb);
}

The pointer is only set to NULL on success, leaving it dangling on failure:

drivers/net/can/usb/etas_es58x/es58x_core.c:es58x_xmit_commit() {
	...
	ret =3D es58x_submit_urb(priv->es58x_dev, priv->tx_urb, netdev);
	if (ret =3D=3D 0)
		priv->tx_urb =3D NULL;
}

Then es58x_start_xmit() jumps to xmit_failure and calls=20
es58x_flush_pending_tx_msg(), which uses the dangling pointer:

drivers/net/can/usb/etas_es58x/es58x_core.c:es58x_flush_pending_tx_msg() {
	...
	usb_anchor_urb(priv->tx_urb, &priv->es58x_dev->tx_urbs_idle);
	...
	usb_free_urb(priv->tx_urb);
}

Can this lead to a use-after-free and memory corruption?

>  			  urb->transfer_buffer, urb->transfer_dma);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014601.4154=
45-1-lgs201920130244@gmail.com?part=3D1
