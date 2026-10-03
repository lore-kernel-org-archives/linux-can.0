Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2931618B
	for <linux-can@vger.kernel.org>; Sat,  3 Oct 2026 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068727; cv=none; b=cfQ2hWPYmwLbSoJPelMrXDgYcopVmPZmCBaaffenkuKeKlnRXSpUj0hQsXkKX13GAM4YSSwu7xBk1S/cXg8rvkSwpHLDgzsMC44POuwXvV4DY+Nr36U1/No497FRpXtKOd6e1HIWstp3/vvr777Zi1s7KpDA1j0Mg7tp8h1VQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068727; c=relaxed/simple;
	bh=g1pSQNa7cWgTDcWwmi0xSGXVhmCZWQkgS/bw9eB0498=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pGwP0c8OVTnaYhdCEMGilZQwlVVY8zzZmY5y04DidfbeS1JF9luZjiHeyKVB/j6lR9bD4N6Yen+mr36YN3TOMW2Ggj0i4wAGYFNgQYN+Xc8BIHR9WYtFjswCakrnrzlXe6+LN3QSZfUeNW+DThukrN4z6gwpIwvi3WblXjfbC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1ijTMwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1ijTMwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E501F0089B;
	Sat,  3 Oct 2026 23:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791068726;
	bh=aJhHVws4WOi1PPQ7goN+/3QAK2nlzPM+/iNHKnZTmU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1ijTMwOwVBgMlfY2d0uPo9SVC0JKjkPyKgX7vQZu75wCsfT+peogSaYxXsIvLCFp
	 Jmz2OubBGFJaR4G3sY2KCDJ2W8ssIVc1jyoappFC8bvQOkNo1Sie9fkqxwbeCMvzjW
	 TgX0MobCgMnBINZAIa7MNy5iVH/kVcbA68FUeVRtzPMve3YIdlES4EXBA1tLLRLUI+
	 C6BgcenduOH7uzxBves529SHv1PeRlC7zPWKIt3avaS/IpIxUAi5uVp27w/e1c3rPB
	 h8ovUVMuEqbfP3zrBZubIlobjYIm3y5q5a9+Kuh2dGHn16ZkFD9o/Ruxv/LWQkqH38
	 brIKSlDo9B8wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next 10/10] can: gs_usb:
 gs_usb_get_minimum_rx_length(): enforce data_length of 8 bytes for CAN
 error frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-10-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
 <20261004-gs_usb-cleanups-and-fixes-v1-10-7b4b06244a77@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 23:05:25 +0000
Message-Id: <20261003230525.B3E501F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] can: gs_usb: valid CAN error frames dropped due to inflated minimu=
m_length
- [Medium] can: gs_usb: missing cf->len update truncates CAN error frames
--

commit ee50d7ce750c8b15bfde5ea17af1803de6e6715b
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_usb_get_minimum_rx_length(): enforce data_length of 8 bytes=
 for CAN error frames

This commit updates the minimum RX length calculation for CAN error frames =
to
strictly expect 8 bytes of data. By definition, CAN error frames have a data
length of 8 bytes, so this aligns the data length calculation for error
frames with that specification.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 3c0464edb5d39..9ec6fed45b814 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -576,8 +576,12 @@ gs_usb_get_minimum_rx_length(const struct gs_can *de=
v, const struct gs_host_fram
>  			minimum_length =3D sizeof(hf->header) + data_length;
>  	} else {
>  		if (hf->echo_id =3D=3D GS_HOST_FRAME_ECHO_ID_RX &&
> -		    !(hf->can_id & cpu_to_le32(CAN_RTR_FLAG)))
> -			data_length =3D can_cc_dlc2len(hf->can_dlc);
> +		    !(hf->can_id & cpu_to_le32(CAN_RTR_FLAG))) {
> +			if (hf->can_id & cpu_to_le32(CAN_ERR_FLAG))
> +				data_length =3D CAN_ERR_DLC;
> +			else
> +				data_length =3D can_cc_dlc2len(hf->can_dlc);
> +		}

[Severity: High]
Does inflating data_length here cause valid, unpadded CAN error frames to
be discarded?

By forcing data_length to 8, the returned minimum_length will increase.
If a USB device sends a short, unpadded error frame where hf->can_dlc is
less than 8, the frame might be shorter than the newly inflated
minimum_length. The check in gs_usb_receive_bulk_callback() would then fail
and drop the frame:

gs_usb_receive_bulk_callback() {
    ...
    minimum_length =3D gs_usb_get_minimum_rx_length(dev, hf, &data_length);
    if (urb->actual_length < minimum_length) {
        stats->rx_errors++;
        stats->rx_length_errors++;
    ...
}

[Severity: Medium]
Could forcing data_length to 8 here also create a mismatch with cf->len
when the frame is constructed?

In gs_usb_receive_bulk_callback(), the frame length is initialized using the
unmodified hf->can_dlc, but the payload copying relies on data_length:

gs_usb_receive_bulk_callback() {
    ...
    can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
    ...
    memcpy(cf->data, hf->classic_can->data, data_length);
    ...
}

If the device sends an error frame with hf->can_dlc less than 8, data_length
is now forced to 8, meaning 8 bytes of payload are copied. However, cf->len
will be initialized to a value less than 8. This length mismatch would
truncate the error frame details exposed to the network stack and userspace
tools.

> =20
>  		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
>  			/* timestamp follows data field of max size */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-gs_usb-cle=
anups-and-fixes-v1-0-7b4b06244a77@pengutronix.de?part=3D10
