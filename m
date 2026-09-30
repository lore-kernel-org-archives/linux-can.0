Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B012403EA1;
	Wed, 30 Sep 2026 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776290; cv=pass; b=n/yqgB1I0FruQWb6+JdUWispaPGoqgLTvRC63fOeWS+8pwoYcqSnMSXFLuOchFCPnAqOjmNnC+rOGm5D8GwoMFTN8PI8v7/BKbD/bjl+n6Q7wYFv9WeO6zW7tx6sdHYbHV62VDyBStuzGhbr+iiD115De+pYesogL/ynoTfJ0KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776290; c=relaxed/simple;
	bh=RhO43GmUmvOzGzhjbRldJz/+twOJX7oTG/V/JPZVl5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGCOfgweYeJr2nsxV/caOAqnetwDkOXMbOfoU2TdgTZCdaHpN0V4905kBmIP5X0Pfg9F3GDxLPpRvj6m2vRKAuqar5x4jpDOEOQ50YSHAW8GDaQIA3pSDlyqvDrs2NugvPdG/9MX/BW8PGinCiO/IvKzPVCIaXDf8B26kY5XJo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=U4AWhhrt; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="U4AWhhrt"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A19052004B4;
	Wed, 30 Sep 2026 15:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790776271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CveDxoUH2qOse8vjWTl+kAoZuO/zTAmB8DSUTPSEMgw=;
	b=U4AWhhrtj1rt0Q/5lWVGGo2iTEW/+lwbyj+m2f9qte2BzhzP8lGIVXUeyybMnuxcOABWBl
	HLBdKrjqNeVT2mE5xJiW5D0jv468swp9oFhFk/NX7Qxh6jgoJVv3+OojVI69Rf2p9C/Z8Z
	tIlWcVviukMMI+WwKVphGgI/FP7o+IK2iRVo5/aFFollgR2QlRW66asbkE4VTi/dPzdfMT
	TtXcRD8tnU3c3kyGGzalQWUrWv9ApWp7DTOganFrlSDqiBTJnY1skaF2vBqhPAWp39X7UG
	bBYAMuLe76H1gJF0ta2IXMZcV9yPY0HoSmm/aLfSn/VDqiSS07QzHMqKbTaGRQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790776271; a=rsa-sha256;
	cv=none;
	b=XLK18OhPawq4vH7bpf/hif4rROTkT+CXc3KQ5vp+YzF3hydSAejZWcYeznw44psIcwd0Mq
	JAvHIHJi3m/+Tfvj/j71kyz3E2JnXqkkjMSVx9W67s2PneDtJQdPc2CyW9oGV4+U9UapwN
	yx8mI/JNV9kdvrLrXxXwp4ls975wR9IBuor7h/wKhoJR5w3MYArz8bDIhWHTLanoIPdeg8
	+dtGZjn/7agILKXNGBxE4IndDHLGLDU/w5fDdOLFESXuX0BjbrAvlQtiClujn5vAdxwlaS
	YxJHQHKwiTehi4KwCPa8QeLqubHrryKgVJ3izPrFYZ97STA/hwjeeCZB7iVKtA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790776271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CveDxoUH2qOse8vjWTl+kAoZuO/zTAmB8DSUTPSEMgw=;
	b=bHIeuRq7sgebgNQbI/Cq4IgGTpuYnxZRwn6tUXKfoO/pzxBKkqlQol12mH40+uKptBwukp
	MTQVMuGrPN10ZjE0757WzPqD9tuealyjD2jrdwy8nqHmgUuv3qZw1dmJhJ4QStu9PrnIwB
	sUJYzCFwrU099ZtP8rluATtHi706gWWC6KwngxuGTfUdhvTW4qd/ajvmmOOBGUBdODBsup
	PqbuGURj4fN48V/FHFuSQFo2BmXLOHJEwcU4/5TQ06/JdQUuMMxaxe4sXBegxv3o3MqDXc
	03qLuPidhLsR9CKwXCAZeRcLgUgt9/HeGND7vPHz1K6KSs+kPAcCnRqsHUuAyg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBuiF-003ZE8-1m;
	Wed, 30 Sep 2026 15:51:11 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 383715B5801;
	Wed, 30 Sep 2026 13:51:11 +0000 (UTC)
Date: Wed, 30 Sep 2026 15:51:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>
Subject: Re: [PATCH] can: peak_usb: Add support of loopback mode to the
 PCAN-USB FD family
Message-ID: <20260930-foamy-nostalgic-elk-30d429-mkl@pengutronix.de>
References: <20260930-peak_usb-canfd-loopback-v1-1-fdcb87611fc6@peak-system.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ht2qscaexquqd7yq"
Content-Disposition: inline
In-Reply-To: <20260930-peak_usb-canfd-loopback-v1-1-fdcb87611fc6@peak-system.fr>


--ht2qscaexquqd7yq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: peak_usb: Add support of loopback mode to the
 PCAN-USB FD family
MIME-Version: 1.0

On 30.09.2026 15:34:48, St=C3=A9phane Grosjean wrote:
> From: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
>
> This commit adds loopback mode support for all PEAK-System USB-to-CAN FD
> interfaces.
>
> The implementation follows the same approach as the peak_pciefd driver.
> The only difference is local echo handling: on USB devices, transmit
> confirmations are provided through USB write acknowledgments rather than
> through the reception of a controller-generated loopback frame.
>
> Signed-off-by: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index 5840623662af..a00ce1f52341 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -934,6 +934,12 @@ static int pcan_usb_fd_encode_msg(struct peak_usb_de=
vice *dev,
>  	if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
>  		tx_msg_flags |=3D PUCAN_MSG_SINGLE_SHOT;
>
> +	/* Request controller loopback and mark the frame as self-received,
> +	 * matching the behavior of the peak_pciefd driver.
> +	 */
> +	if (dev->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +		tx_msg_flags |=3D PUCAN_MSG_LOOPED_BACK | PUCAN_MSG_SELF_RECEIVE;
> +
>  	tx_msg->flags =3D cpu_to_le16(tx_msg_flags);
>  	tx_msg->channel_dlc =3D PUCAN_MSG_CHANNEL_DLC(dev->ctrl_idx, dlc);
>  	memcpy(tx_msg->d, cfd->data, cfd->len);
> @@ -1266,7 +1272,7 @@ const struct peak_usb_adapter pcan_usb_fd =3D {
>  	.ctrlmode_supported =3D CAN_CTRLMODE_FD |
>  			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
>  			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
> -			CAN_CTRLMODE_BERR_REPORTING,
> +			CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LOOPBACK,

Can you keep the CAN_CTRLMODE sorted by their value?

Please make an incremental patch for the CAN_CTRLMODE_BERR_REPORTING,
I'll squash that...and add CAN_CTRLMODE_LOOPBACK in the appropriate
place.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ht2qscaexquqd7yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCar0TzAAKCRDMOmT6rpmt
0miBAQCy/OLaH2hBe2XPMRUy9bl42tKbcZykAarj/ZhUcxZb+gD/f1Flu4iMDo0b
RwaTD61uIpAg7v34FJF1zMTJ9Qv1IA0=
=JoSj
-----END PGP SIGNATURE-----

--ht2qscaexquqd7yq--
