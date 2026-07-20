Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE13DCD96
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556704; cv=none; b=eZgNfzsxAVEspHH8SFLTtObzg4yF04CvLAsPikF89XkKzMGXNAxN1Ly9Kbp9wnb4PpLM5myJHGbOnESSrU2S1PsIBhaCuoH/iOjaeUBUkoB4nPIk0zb3sSGedmOWxumdy5GWBF6Fr7gCd2bf/y3cRnFS06DehyBn2gcydc5u/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556704; c=relaxed/simple;
	bh=tEPy9iFWmYvjyrquCKk5zIXVcE5QSHIYKTQ9WK8iltI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eT1wXQnqRsKdpa8ed+BSsSQ35FymoNEdwB0QMMAfl3NeRlUiyVtCHZPhILW6iJayOLpUxFOl9hWJc4vaelTFPbmC3FKcCqNusMpCnYUqCpQLCgjk6h0aSiCMG8MWzd9Hwgxa0+vbrq/dK9hNO4m+DIy5GLMcxAZU80A5/KWZTrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S16duZbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S16duZbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119A91F000E9;
	Mon, 20 Jul 2026 14:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556703;
	bh=CH3QslxlCtmleFF+g45WMKOiZ7DeViR7Yc/4EvpizOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S16duZbvrlLbrjyrAJYIkGlxLN9Mx/Z9pP5nieJnSxLagH4XMJmpf21gZONrVdqYw
	 gRpRDhP5b5HqeQm60EoRUJJc+1fpMbG+9OYSVEDPttrUA9vTrUqnMT7QC01rRA/Uae
	 iY8oQ9wa6nJfx2EKAll9iYyE4o91bnn6cp/vto7zZRCL0j/qxsjbAkHp9iGDmGsg3W
	 AsvE8FC8LZnFwEX2T1oa2BZ+FEwhzbYclcPlqyntObeoSwzEu3UlIwiOhy7zcakPoc
	 flEy6x0oKg6Gkt43a0d4CXSvTscIpBKj5YM2edd7I8Bwd0vrK25S+3XvV+fHXc7jkH
	 5iKFRJqkUKebw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next 10/13] can: gs_usb: gs_update_state(): set
 CAN_ERR_CNT if device sends CAN error counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260720-gs_usb-new-features-v1-10-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
 <20260720-gs_usb-new-features-v1-10-427a8013c380@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:11:42 +0000
Message-Id: <20260720141143.119A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The driver unconditionally reads uninitialized memory from the URB=
 transfer buffer when processing malformed CAN error frames with a small DL=
C.
- [Medium] Valid CAN error flags (like RX/TX overflow) are silently dropped=
 from userspace if the CAN state does not change.
- [Medium] The CAN_ERR_RESTARTED flag is unconditionally cleared from the C=
AN ID and then immediately checked, causing explicit restart signals from t=
he firmware to be ignored.

Pre-existing issues:
- [High] If `alloc_can_skb()` or `alloc_canfd_skb()` fails, the driver abor=
ts URB processing without resubmitting the URB, potentially permanently sta=
rving the RX path.
--

--- Patch [10]: [PATCH can-next 10/13] can: gs_usb: gs_update_state(): set =
CAN_ERR_CNT if device sends CAN error counters ---
commit f1e0f1d0c2f80b9c65dc60e4897538baed5336ee
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_update_state(): set CAN_ERR_CNT if device sends CAN error c=
ounters

Some gs_usb compatible firmware send the CAN error counters in CAN error
frames, but doesn't set CAN_ERR_CNT in can_id. Fixup the CAN error frame by
setting CAN_ERR_CNT, if RX or TX error counters are greater than 0.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index ec9a7cbbbc696..186abc95c9774 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -495,29 +529,35 @@ static void gs_usb_timestamp_stop(struct gs_usb *pa=
rent)
> -static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
> +static void gs_update_state(struct gs_can *dev, struct can_frame *cf,
> +			    enum can_state tx_state, enum can_state rx_state)
>  {
>  	struct can_device_stats *can_stats =3D &dev->can.can_stats;
> =20
> -	if (cf->can_id & CAN_ERR_RESTARTED) {
> -		dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +	/* clear CAN state information, will be set consistently by can_change_=
state() below */
> +	cf->can_id &=3D ~(CAN_ERR_CRTL | CAN_ERR_BUSOFF | CAN_ERR_RESTARTED);
> +	cf->data[1] &=3D ~(CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING |
> +			 CAN_ERR_CRTL_RX_PASSIVE | CAN_ERR_CRTL_TX_PASSIVE |
> +			 CAN_ERR_CRTL_ACTIVE);
> +
> +	/* some firmware sends CAN error counters but doesn't set CAN_ERR_CNT, =
fixup */
> +	if (cf->data[6] || cf->data[7])
> +		cf->can_id |=3D CAN_ERR_CNT;
> +
> +	const enum can_state new_state =3D max(rx_state, tx_state);
> +
> +	if (new_state =3D=3D dev->can.state)
> +		return;

[Severity: Medium]
If the CAN state does not change, we return early from gs_update_state()
here, but we've already stripped the CAN_ERR_CRTL flag from cf->can_id.

Does this silently drop valid CAN error flags, such as RX overflow,
preventing them from reaching userspace?

> +
> +	/* some firmware does automatically CAN bus off recovery, account for t=
his */
> +	if (cf->can_id & CAN_ERR_RESTARTED ||

[Severity: Medium]
Since we unconditionally cleared the CAN_ERR_RESTARTED bit from cf->can_id =
at
the start of gs_update_state(), won't this check always evaluate to false?

Does this cause explicit restart signals sent by the firmware to be ignored?

> +	    (dev->can.state =3D=3D CAN_STATE_BUS_OFF && new_state < CAN_STATE_B=
US_OFF)) {
>  		can_stats->restarts++;
> -	} else if (cf->can_id & CAN_ERR_BUSOFF) {
> -		dev->can.state =3D CAN_STATE_BUS_OFF;
> -		can_stats->bus_off++;

[ ... ]

> @@ -606,6 +646,90 @@ gs_usb_get_minimum_rx_length(const struct gs_can *de=
v, const struct gs_host_fram
> +static void
> +gs_usb_state_get_by_hf(const struct gs_can *dev, const struct gs_host_fr=
ame *hf,
> +		       enum can_state *tx_state_p, enum can_state *rx_state_p)
> +{
> +	enum can_state tx_state, rx_state;
> +
> +	/* extract CAN state from frame */
> +	if (hf->can_id & cpu_to_le32(CAN_ERR_CRTL | CAN_ERR_BUSOFF)) {
> +		const u8 err_crtl =3D hf->classic_can->data[1];
> +
> +		if (hf->can_id & cpu_to_le32(CAN_ERR_BUSOFF)) {
> +			tx_state =3D CAN_STATE_BUS_OFF;
> +			rx_state =3D CAN_STATE_BUS_OFF;
> +		} else {
> +			if (err_crtl & CAN_ERR_CRTL_RX_PASSIVE)
> +				rx_state =3D CAN_STATE_ERROR_PASSIVE;

[ ... ]

> +		}
> +
> +		const u8 tx_err =3D hf->classic_can->data[6];
> +		const u8 rx_err =3D hf->classic_can->data[7];

[Severity: High]
Does this code in gs_usb_state_get_by_hf() unconditionally read uninitializ=
ed
memory from the kmalloc'ed URB transfer buffer if a malformed CAN error fra=
me
with a small DLC is received?

Since the URB length check only ensures the header is present, accessing fi=
xed
offsets like data[6] and data[7] could read past the actual payload, leaking
uninitialized heap memory to the kernel log and causing erratic state
transitions.

> +
> +		netdev_dbg(dev->netdev, "host_frame: TX-state=3D'%s/%u' RX-state=3D'%s=
/%u' %s%s%s%s%s%s%s",
> +			   can_get_state_str(tx_state), tx_err,
> +			   can_get_state_str(rx_state), rx_err,

[ ... ]

> @@ -671,7 +791,11 @@ static void gs_usb_receive_bulk_callback(struct urb =
*urb)
>  	if (hf->echo_id =3D=3D GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
> +		struct sk_buff *skb;
> +
>  		if (hf->flags & GS_CAN_FLAG_FD) {
> +			struct canfd_frame *cfd;
> +
>  			skb =3D alloc_canfd_skb(netdev, &cfd);
>  			if (!skb)
>  				return;

[Severity: High]
This is a pre-existing issue in gs_usb_receive_bulk_callback(), but if this
allocation fails and we return directly, the URB is never resubmitted.

Could this permanently starve the RX path and kill CAN reception under
systemic memory pressure?

> @@ -685,6 +809,13 @@ static void gs_usb_receive_bulk_callback(struct urb =
*urb)
> =20
>  			memcpy(cfd->data, hf->canfd->data, data_length);
>  		} else {
> +			enum can_state tx_state, rx_state;
> +			struct can_frame *cf;
> +
> +			if (hf->can_id & cpu_to_le32(CAN_ERR_FLAG) &&
> +			    !gs_usb_should_handle_can_error(dev, hf, &tx_state, &rx_state))
> +				goto resubmit_urb;
> +
>  			skb =3D alloc_can_skb(netdev, &cf);
>  			if (!skb)
>  				return;

[Severity: High]
This is also a pre-existing issue in gs_usb_receive_bulk_callback().
Returning directly here without jumping to the resubmit_urb label means the
URB is permanently dropped from the active queue.

Could this lead to the same RX starvation issue mentioned above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-gs_usb-new=
-features-v1-0-427a8013c380@pengutronix.de?part=3D10
