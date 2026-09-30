Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7FD45D921;
	Wed, 30 Sep 2026 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756130; cv=pass; b=rCZ0J4CS3T1YK7tpCzkmVZRvMYm15sc79Z9SxXX6B7QeAW1MPgs21ODWtseF6EULbfBi+GYhWobfz+JY/ZKFwCsuOGspdPHjdTO4utD72Fd2mB7Wyg04DAcumFmGjT0eiKFaHbF7tukdwN7VWgxxwAenE6Yq/UutVKIr/a5fZQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756130; c=relaxed/simple;
	bh=JpcD9eNjrkhENMVhrPhOr+OtsPKPAN5Xte9Aw/Udlfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m59yQoyIGSd5vNKUvX8o4oEzOm8MNK9ViD6xf6YnqT+1/f+4dnlxyGDMnj8lAIMitDhi3jAsYoy+IwTa8vlQ0lNduRkw0xrcTDOs3lZYo7AWI+lVp63Kqlbg/h+lEOCNaoc2brczU7d+jKxbISf2SrBtElyfa3yyOZL0mxeB4V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=GMSg/1sH; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="GMSg/1sH"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A3A97201547;
	Wed, 30 Sep 2026 10:15:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790756126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mtoZoq+i1gEwa6hIBJzocyjqUx3FGUM6zKuOS6i/f4k=;
	b=GMSg/1sHhWjwWy5nvCfGnWUV8UApoVh/Bb7/ne9pwUuHjEF4ZTRr1aTto9uBumQJlrhitC
	T2/tlwhAqSSuLqc/wtAYTMlJe/pE5WmRfCX4idFMgKQYDZfzK0qnf32blwJJE1dHUGxu73
	c3MCLIx0heitBN5vsqilfmUbRiKYdm1vZG1xZ1Ry310RBsikMrzNU7NbtkNCKSP+/hwvNl
	hWaqq4V6rk7NLFlLWJUXgyLLIxLuCt8pbHWO1rrfCJMDEel79ibm1oegWhVvNuzEB51rXD
	HbmNj159SajespsVclJakUJWVwMhVhDJ4i0lRcjooXmIxSHss9XmUUZgteAAuw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790756126; a=rsa-sha256;
	cv=none;
	b=PtJWdZg/7Jq7MdSrgrEf0O6vH2StYjVsLhUeaS8tZL0ph0+B4Guvtjt0ugM2P+NIrTBLYI
	ZLgpVBlLwHDh5wNZn9xAeG2At8EWMlfEwz/E0muc808I5dV4eBuOQcFQ+a4wDRHFVgv5L7
	o6M/p7X/O01TmMnC1GS8E1D6mfNpmyEzFgOfnPe7Hjod9oQETUQ6id+J8T7Y/5EDhaJIuk
	36Ea3oRzporRO62+tEDciWNIxEE6IZ2TmeTPcV1I/+4PtYhkrnor6Uj8uy9km3TbjVKIeF
	icdOg4WEpTKKhilrVUBPkCZHX9VJhCQH8W2VvOtyTnMeo1j7+s7w0yi3ejS1EQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790756126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mtoZoq+i1gEwa6hIBJzocyjqUx3FGUM6zKuOS6i/f4k=;
	b=dypEPj7WWm9cVbOjax79wZxdR4acjJRvGTXwEETWSEjwBvmYWSi9SKK2KBJQN9X74EHS1z
	SSoxikF+FU+X0JXweTejAKFYH29Lgo/ckbZ32m4FALqDv+b5g5raZ+FpK7u4gIjrhbmgN+
	k6fFkXbSIkKWpDqtZ1XodGurEffe3LbXhUZy0kPXy4n4RCLGJL62QwiHw60ktXGG+iMBRT
	ojRNTL94bM/nwWwK0EIGkCXxPHjpZTLYO+R4ERg4j7FOIoTebw+QWOoY6A3N+FqMfAYB+d
	F0eGat20ms4v0a2WHWjgQyiHCDkOwUdMMpHyUfVr86tHEjGFJqtXXZO5aDDTmg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBpTK-003WjC-1m;
	Wed, 30 Sep 2026 10:15:26 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CCE6E5B53BE;
	Wed, 30 Sep 2026 08:09:15 +0000 (UTC)
Date: Wed, 30 Sep 2026 10:09:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>
Subject: Re: [PATCH v2] can: peak_usb: Add bus error reporting for the
 PCAN-USB FD family
Message-ID: <20260930-exceptional-bronze-spider-2b3cf7-mkl@pengutronix.de>
References: <20260929-peak_usb-canfd-berr-v2-1-1a7005797c38@peak-system.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k524qxs5cvazkkbc"
Content-Disposition: inline
In-Reply-To: <20260929-peak_usb-canfd-berr-v2-1-1a7005797c38@peak-system.fr>


--k524qxs5cvazkkbc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: peak_usb: Add bus error reporting for the
 PCAN-USB FD family
MIME-Version: 1.0

On 29.09.2026 16:41:03, St=C3=A9phane Grosjean wrote:
> From: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
>
> CAN bus error reporting is currently missing for all PEAK-System
> USB-to-CAN FD devices. Add support for reporting bus errors by enabling
> bus error notifications in the firmware for each CAN channel.

To make it more clear, let's explain your decision to abort parsing if
the FW sends bogus data. What about something like this:

Abort parsing of the URB if the firmware reports an invalid channel.

> Signed-off-by: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
> ---
> Changes in v2:
> - Add a defensive check against single-channel adapters reporting an
>   invalid channel index.
> - Link to v1: https://patch.msgid.link/20260929-peak_usb-canfd-berr-v1-1-=
7abd585f877f@peak-system.fr
>
> To: Marc Kleine-Budde <mkl@pengutronix.de>
> To: Vincent Mailhol <mailhol@kernel.org>
> Cc: linux-can@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 89 ++++++++++++++++++++++++=
++----
>  include/linux/can/dev/peak_canfd.h         | 15 ++++-
>  2 files changed, 92 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index 0d46f4ce5dca..98f6943469b3 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -661,17 +661,71 @@ static int pcan_usb_fd_decode_error(struct pcan_usb=
_fd_if *usb_if,
>  	struct pucan_error_msg *er =3D (struct pucan_error_msg *)rx_msg;
>  	struct pcan_usb_fd_device *pdev;
>  	struct peak_usb_device *dev;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	u8 can_err_tx =3D 0;
>
>  	if (pucan_ermsg_get_channel(er) >=3D ARRAY_SIZE(usb_if->dev))
>  		return -EINVAL;
>
> +	/* Guard against bogus channel 1 reports from single-channel adapters */

A malicious FW can also send invalid channel information on multi
channel adapters, so let's update the comment here, too:

Abort parsing of the URB if the firmware reports an invalid channel.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--k524qxs5cvazkkbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarzDqAAKCRDMOmT6rpmt
0kAFAP43x/RyOGGFSp3oSKIBoUmdi/4v7Xtc7e3TaKzaZGCtAwD+I+4tCxJsvEUo
a7xXmsmgyZV968+N2DESUBje4alg3wg=
=6Hxr
-----END PGP SIGNATURE-----

--k524qxs5cvazkkbc--
