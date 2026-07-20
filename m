Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918D3DCDAB
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556620; cv=none; b=L4t9lDLEyVdnVYeq8PYY2B/Ov4RLWMvSCSxFaQyGoVvBDTcgXEJAYqGVFpMuOnO3L+wEEogRsMrstwSuB6IANchsDSs97lCGpvhsTki6zFS4+YfHzc/5txvRyuk2wIz7a78EmqOrUAbvaBJq+9xYLeXp3wbS6fTxfcoLE9eX/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556620; c=relaxed/simple;
	bh=HRYedK8UHw5oc/e7jWzLbk6HGMt+cAJzbzT0AVKkSmU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fwx/v82ExFZ6scuio3h41Sy4/FXQzxc+hOMtsS3eZTkP5KlhC9x5aWyZtp8Xoa52PO8YAYEwFDYmBZbdWVAU4i1fEgSEUB+lqyP5fSUj0oDmhh+fLt/6HzjOitx0qAWfESQqS5WQLK7hPGhg7yqwVdjEiO0Dv53+3dit9/kx9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYEOijb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYEOijb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753741F000E9;
	Mon, 20 Jul 2026 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556618;
	bh=1oMH73Ix1Y3EHDcEQ9QnHGtcmCFsBt9aLqoqCl3GgcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bYEOijb0BN1zK5jyArH0N2Um5AjhIf81wg5UGNnhWKy0ihaJbdo3WaHkYpQLcc1UQ
	 6FxpvZCEwkM68CByrZELzqgz5JqC5GxjvNH9YoGdIGckofipnlGQpPZxsJa5kQaRpe
	 K5zE1KcxJbWV624nZH8ozzCBg3wVY5YKeJfScXNEvuce3fx6n/4rU1QPnECTEzseIw
	 SC88Fm5kVeQS+y3XOxBeN8OjfOGyM/73WDJFuEdzJ1JKp+vwAEWWQ40SHvBMn2xnLm
	 ObA+fcw/DVKR3byWL/Zn8KfulMlPACSZOcYpfUzwG8QBsHlEcgDngCLxHKAGaKV+f0
	 gwA+kh0dmYC1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next 08/13] can: gs_usb: gs_update_state(): convert
 CAN state handling to can_change_state()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-8-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
 <20260720-gs_usb-new-features-v1-8-427a8013c380@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:10:18 +0000
Message-Id: <20260720141018.753741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The CAN_ERR_RESTARTED flag is unconditionally stripped from cf->ca=
n_id before being evaluated, completely ignoring firmware-signaled restart =
events.
- [High] CAN_ERR_RESTARTED frames are incorrectly dropped by gs_usb_should_=
handle_can_error() if they do not coincide with a CAN state change.
- [High] Dropping redundant CAN error frames silently bypasses the hardware=
-level RX overflow check and offload irq finish.
- [Medium] Early return in gs_update_state() leaves CAN_ERR_CRTL cleared, h=
iding RX/TX overflow errors from userspace.
- [Medium] Parsing CAN error states directly from the USB host frame reads =
uninitialized memory if the device sends a short error frame.

Pre-existing issues:
- [High] Failing to allocate an SKB causes the driver to return directly wi=
thout resubmitting the URB, starving the RX pipeline.
--

--- Patch [8]: [PATCH can-next 08/13] can: gs_usb: gs_update_state(): conve=
rt CAN state handling to can_change_state() ---
commit 0f07f8fda15070cb595e00084e739e3a1240c93b
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_update_state(): convert CAN state handling to can_change_st=
ate()

The gs_usb compatible firmware signals CAN state changes via CAN error
frames to the kernel. This commit converts the driver to make use of the
can_change_state() helper. It also implements functions to extract CAN
state and drop redundant CAN state error frames.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 473f125e20d8a..e41f91b56ab82 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -529,29 +529,31 @@ static void gs_usb_timestamp_stop(struct gs_usb *pa=
rent)
>  	cancel_delayed_work_sync(&parent->timestamp);
>  }
> =20
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
> +	const enum can_state new_state =3D max(rx_state, tx_state);
> +
> +	if (new_state =3D=3D dev->can.state)
> +		return;

[Severity: Medium]
Does returning early here hide RX/TX overflow errors from userspace? Since
CAN_ERR_CRTL is cleared from cf->can_id just above, if there is no state
change but data[1] contains an overflow error (like CAN_ERR_CRTL_RX_OVERFLO=
W),
the frame goes to userspace without the CAN_ERR_CRTL bit set, causing
userspace to silently ignore the valid error flags.

> +
> +	/* some firmware does automatically CAN bus off recovery, account for t=
his */
> +	if (cf->can_id & CAN_ERR_RESTARTED ||

[Severity: High]
Will this check for CAN_ERR_RESTARTED ever evaluate to true? The
CAN_ERR_RESTARTED flag is unconditionally cleared from cf->can_id at the st=
art
of this function, so it appears this will silently ignore firmware-signaled
restart events.

> +	    (dev->can.state =3D=3D CAN_STATE_BUS_OFF && new_state < CAN_STATE_B=
US_OFF)) {
>  		can_stats->restarts++;

[ ... ]

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

[Severity: Medium]
Could this read uninitialized memory if the device sends a short error fram=
e?
If the USB device sends an error frame with a payload smaller than 2 bytes,
this unconditionally reads from the URB buffer, which might contain stale d=
ata
from previous USB transfers.

> +
> +		if (hf->can_id & cpu_to_le32(CAN_ERR_BUSOFF)) {
> +			tx_state =3D CAN_STATE_BUS_OFF;

[ ... ]

> +static bool
> +gs_usb_should_handle_can_error(const struct gs_can *dev, const struct gs=
_host_frame *hf,
> +			       enum can_state *tx_state_p, enum can_state *rx_state_p)
> +{
> +	gs_usb_state_get_by_hf(dev, hf, tx_state_p, rx_state_p);
> +
> +	/* If the CAN error counters are not 0, some firmware repeatedly send C=
AN state error
> +	 * frames, even if the CAN state does not change. Handle changed CAN st=
ates.
> +	 */
> +	const enum can_state new_state =3D max(*tx_state_p, *rx_state_p);
> +
> +	if (new_state !=3D dev->can.state)
> +		return true;
> +
> +	/* handle RX and TX overflow */
> +	const u8 err_crtl =3D hf->classic_can->data[1];
> +
> +	if ((hf->can_id & cpu_to_le32(CAN_ERR_CRTL)) &&
> +	    err_crtl & (CAN_ERR_CRTL_RX_OVERFLOW | CAN_ERR_CRTL_TX_OVERFLOW))
> +		return true;
> +
> +	/* handle TX timeout */
> +	if (hf->can_id & cpu_to_le32(CAN_ERR_TX_TIMEOUT))
> +		return true;
> +
> +	/* handle CAN bus errors */
> +	if (hf->can_id & cpu_to_le32(CAN_ERR_LOSTARB | CAN_ERR_PROT | CAN_ERR_T=
RX | CAN_ERR_ACK))
> +		return true;
> +
> +	return false;

[Severity: High]
Are CAN_ERR_RESTARTED frames mistakenly dropped here? If a frame has
CAN_ERR_RESTARTED set but no state change, it falls through to this point.
Since CAN_ERR_RESTARTED is absent from the hardcoded list of accepted error
flags, it seems these frames will be discarded entirely.

> +}
> +
>  static void gs_usb_receive_bulk_callback(struct urb *urb)
>  {

[ ... ]

> @@ -719,8 +790,13 @@ static void gs_usb_receive_bulk_callback(struct urb =
*urb)
> =20
>  			memcpy(cfd->data, hf->canfd->data, data_length);
>  		} else {
> +			enum can_state tx_state, rx_state;
>  			struct can_frame *cf;
> =20
> +			if (hf->can_id & cpu_to_le32(CAN_ERR_FLAG) &&
> +			    !gs_usb_should_handle_can_error(dev, hf, &tx_state, &rx_state))
> +				goto resubmit_urb;

[Severity: High]
Does jumping to resubmit_urb here bypass the hardware RX overflow checks? T=
he
check for hf->flags & GS_CAN_FLAG_OVERFLOW and the call to
can_rx_offload_irq_finish() happen later in this function, so dropping
redundant CAN error frames this way appears to silently lose piggybacked
hardware overflow events and delay offload processing.

> +
>  			skb =3D alloc_can_skb(netdev, &cf);
>  			if (!skb)
>  				return;

[Severity: High]
This isn't a bug introduced by this patch, but doesn't an early return here
leak the URB structure? If alloc_can_skb() fails to allocate memory, the
driver executes an immediate return instead of resubmitting the URB. This
bypasses usb_submit_urb() and depletes the active RX URB pool, which could
permanently stall the RX pipeline.

> @@ -732,7 +808,7 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
> =20
>  			/* ERROR frames tell us information about the controller */
>  			if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
> -				gs_update_state(dev, cf);
> +				gs_update_state(dev, cf, tx_state, rx_state);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-gs_usb-new=
-features-v1-0-427a8013c380@pengutronix.de?part=3D8
