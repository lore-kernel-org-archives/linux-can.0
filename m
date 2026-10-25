Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792954240;
	b=1F/lB6QO9pdBtvo5pmSMuW5lupDzr3iS5KldbiqmwB30S08bPNbgqPcNRSHbkC3WX7dV
	 1iqejUMN50XyPUlOONsiq5b2YIEu3Kmi4smRCarzTFMW2SX9C2c6pRYyPkh4zrxbN6vR8
	 ZZw2hoFf+PET3K4rPWNxRUfeQXQV+wuSnpdKhdyoXX/qkzB/yznYTB7nqb4ZS+NNDTTxF
	 lJMwv+FydP/941Rm+o2UfP6VCf1PiJk8Hzqn7EHqfbU6Nxg47mSs3Dd38eX5E0zM1bTxU
	 wVqAdekbyMtmjXuWNfiU3WEBBh/sdUgxWRw+5Lyoig+0Fn3pkUMHRz+N3D7n+b3dztw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rrqCX8/YKS6TjB1an0j+xPlHUPIwF4t9BNove7rDneU=;
	b=3bWIuqx+Poj/kpPGgnt17KMdthNFsucoK28ICNOdY4SF9A1YP9xsswKtX6waoAnZkrF/
	 aA447oJub462WikoHxSLazkkG7/5N5i713S5jlawk7IjO4aHwFOP6Io7W71S4Qih201Iv
	 BmAplY9UFySGbs9MDQ5zcaoHWFnjZ/ePgeI5XoDImGE/ymFTO6lAgSthOpn265n49i/G/
	 HFIGUToHKUPh2W3ONNuIY5Tat1jALo0XGpBEEepIsNhaVf/OXsjXUuKQ5hiPkc0OpkwhT
	 98WjdOr/sIfUgcQHq+EGmIT9kA0Nc0zEegFE8uckfumTF7Ii/O14QbLKJ0OBBOkzatQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+HElPmr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B0606A31A
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+HElPmr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02FB1F01825;
	Sun, 25 Oct 2026 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792954239;
	bh=rrqCX8/YKS6TjB1an0j+xPlHUPIwF4t9BNove7rDneU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+HElPmrpCf1wejttpl5sn4f+o2dpUGnnPriEbdajk7dY4rhYWG2sfNJ00mcNEkFM
	 /6RGZkwSKeSCgYK6355eviQPxTiw85vEqsi3BMwQm/abaKK2aG75RcunBvrlVkmcpG
	 RTBPsTIahN3ZK9IfVdtFOSkLLLtGCFKyRp4a8TbUu6dtK+o/Y0a6rXX259I2x48NN7
	 LkKTid0QEIEfiBJrXxZhrWM6aN9Jv+evo5vWbQtD9V2v4c5uGBYEXt4PGTuWf6bQpl
	 hbUbHGAY+5rJNz0vovS4xGZtXhF6iQn9MLwqQhv6xdct9RWprNUOOXo8nT9stwYNfR
	 THGp5+/Nsf5eQ==
Message-ID: <sashiko-outbox-184352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] can: gs_usb: gs_usb_receive_bulk_callback(): check
 for overflow flag if SKB allocation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261025-gs_usb-fixes-v1-3-f74ebbd4da36@pengutronix.de>
References: <20261025-gs_usb-fixes-v1-0-f74ebbd4da36@pengutronix.de>
 <20261025-gs_usb-fixes-v1-3-f74ebbd4da36@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:50:39 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: gs_usb: wrong rx_errors increment in gs_usb_receive_bulk_ca=
llback()
--

commit de6c839020ea7849981f0dbb5e199313eeae8ce2
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB=
 allocation fails

When SKB allocation fails in gs_usb_receive_bulk_callback(), this commit
updates the RX statistics and jumps to check for the GS_CAN_FLAG_OVERFLOW
flag in the host frame before resubmitting the URB.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 985d6a9113d96..5687544af99c8 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -673,8 +673,12 @@ static void gs_usb_receive_bulk_callback(struct urb =
*urb)
>  	if (hf->echo_id =3D=3D GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
>  		if (hf->flags & GS_CAN_FLAG_FD) {
>  			skb =3D alloc_canfd_skb(netdev, &cfd);
> -			if (!skb)
> -				goto resubmit_urb;
> +			if (!skb) {
> +				netdev->stats.rx_dropped++;
> +				netdev->stats.rx_errors++;
> +
> +				goto check_overflow;
> +			}
> =20
>  			cfd->can_id =3D le32_to_cpu(hf->can_id);
>  			cfd->len =3D data_length;
> @@ -686,8 +690,12 @@ static void gs_usb_receive_bulk_callback(struct urb =
*urb)
>  			memcpy(cfd->data, hf->canfd->data, data_length);
>  		} else {
>  			skb =3D alloc_can_skb(netdev, &cf);
> -			if (!skb)
> -				goto resubmit_urb;
> +			if (!skb) {
> +				netdev->stats.rx_dropped++;
> +				netdev->stats.rx_errors++;
> +
> +				goto check_overflow;
> +			}
> =20
>  			cf->can_id =3D le32_to_cpu(hf->can_id);
>  			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
> @@ -728,6 +736,7 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
>  		netif_wake_queue(netdev);
>  	}
> =20
> +check_overflow:
>  	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
>  		stats->rx_over_errors++;
>  		stats->rx_errors++;

[Severity: Medium]
Should gs_usb_receive_bulk_callback() only increment stats->rx_dropped
(and not netdev->stats.rx_errors) when alloc_canfd_skb() or
alloc_can_skb() returns NULL?

In standard net_device_stats accounting (and in other CAN drivers under
drivers/net/can/), a host SKB allocation failure is a drop due to lack of
host memory rather than a link or hardware receive error, so only
rx_dropped is incremented.

Furthermore, if GS_CAN_FLAG_OVERFLOW is also set on the host frame when
allocation fails, jumping to check_overflow increments stats->rx_errors a
second time for the same frame:

    check_overflow:
        if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
            stats->rx_over_errors++;
            stats->rx_errors++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-gs_usb-fix=
es-v1-0-f74ebbd4da36@pengutronix.de?part=3D3
