Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61FF313527
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609681; cv=none; b=bDoeFewbGEUi2SJt7NBQeHJo+WAAVWXhh1+u6pUDFcUvkSA/CVgJE5B012MXbxwCBAXOigIjb71cs+VjDM2OFOEcYcbe6SaigHcCRwYZlPLJye6CUEMJFn/zqCk2jQkOXUQuarVgyIXRk2wqx50z/Z1EKPbrod1Yzj5lx5kAC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609681; c=relaxed/simple;
	bh=r2sgnOaU9i/eXnGEtRm88/HB9NOmRd1tLUkWSIqS/EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIwXqnODtXd3kstDj0coKzkP2vO8h0o+0UKAfAbnGvbwdjDj6x7pNOIZ6cc8oBBJ+E7IM8njJO7AIGzQxXuVjDvlWr/0Dv0JwnALGvos8hCYUB20jHX0a63g2Jzr69WeWvQ0xb9xk30EV7UnRfIGxJRhhkNt6luhQdA+Usp4dJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C91E22001E0;
	Thu, 09 Jul 2026 17:07:55 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1whqLz-000w29-2K;
	Thu, 09 Jul 2026 17:07:55 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7001C5642D4;
	Thu, 09 Jul 2026 15:07:55 +0000 (UTC)
Date: Thu, 9 Jul 2026 17:07:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit
 URB on skb allocation failure
Message-ID: <20260709-hilarious-mighty-dog-2f9e49-mkl@pengutronix.de>
References: <20260709-gs_usb-resubmit-urb-v1-1-4dd40030cc84@pengutronix.de>
 <20260709080517.1D38A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="isvqqekab3emlqxa"
Content-Disposition: inline
In-Reply-To: <20260709080517.1D38A1F000E9@smtp.kernel.org>


--isvqqekab3emlqxa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit
 URB on skb allocation failure
MIME-Version: 1.0

On 09.07.2026 08:05:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Concurrent execution of TX completion and RX echo processing=
 leads to a Use-After-Free of the echo SKB.
> --
>
> --- Patch [1]: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): resub=
mit URB on skb allocation failure ---
> commit bae50a2d39a4f003135f3c48bca851334bf95f56
> Author: Marc Kleine-Budde <mkl@pengutronix.de>
>
> can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocati=
on failure
>
> If the allocation of the SKB in gs_usb_receive_bulk_callback() fails, the
> driver returns from the callback without resubmitting the URB in order to
> receive further USB in URBs. This commit changes the behavior to try to
> resubmit the URB instead of returning.
>
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index ec9a7cbbbc696..82508a8650959 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -674,7 +674,7 @@ static void gs_usb_receive_bulk_callback(struct urb=
 *urb)
> >  		if (hf->flags & GS_CAN_FLAG_FD) {
> >  			skb =3D alloc_canfd_skb(netdev, &cfd);
> >  			if (!skb)
> > -				return;
> > +				goto resubmit_urb;
> >
> >  			cfd->can_id =3D le32_to_cpu(hf->can_id);
> >  			cfd->len =3D data_length;
> > @@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb=
 *urb)
> >  		} else {
> >  			skb =3D alloc_can_skb(netdev, &cf);
> >  			if (!skb)
> > -				return;
> > +				goto resubmit_urb;
> >
> >  			cf->can_id =3D le32_to_cpu(hf->can_id);
> >  			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
>
> [Severity: Critical]
> This is a pre-existing issue, but is there a use-after-free race condition
> in this function regarding the echo SKB?
>
> If the USB RX and TX completion callbacks run concurrently on different C=
PUs,
> and a TX URB fails (e.g., due to disconnection), gs_usb_xmit_callback()
> locklessly frees the SKB and sets the slot to NULL:

This is a bit academic to me. If The TX completion fails due to a
disconnect, I think the RX completion would fail with a disconnect, too.

Also the RX echo is generated the device, after the TX has been send to
the device.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--isvqqekab3emlqxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCak+5SAAKCRDMOmT6rpmt
0qW7AP9ZOy/2oC4bFiuEgF1+IlOSreOmaRDustN0pfkhtEDPwgD+OzZvpzZ9zkTd
uWzXJmA4LKAnZqHdjPvTRsE4XfJNaQI=
=HmM+
-----END PGP SIGNATURE-----

--isvqqekab3emlqxa--
