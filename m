Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B835CBC3
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835453; cv=none; b=BaKR2qBecnVEwFS7ROFyxKyvmlV+roOrBO6MBWMo87H2ATgJaPMliHzGyAQC0VN/TnA1MHhRndO5QOShC2dse59SVOIO20TugAu2dqjh3X1ijdW75X1M4IkhC5E0I7ssicLfPUgEoItxOk/6PSMlXwjniRiKt4192U6/7FaJjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835453; c=relaxed/simple;
	bh=EolrZ81pOqq+ai7e3dZqT87ge9Euuwha9tOivwAwTBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUWO8pTCG5UBIIX5+dVIZmVRa5XnI+TS9FsUKlUDBNe/fAHflf2YROnsfpg8XUgdvMxVpowr5n9jKckQnPwEWiY+AchU1iuNiS4O32UzqD3m8wKHBylNevqDZlF7l/7NSR6Ujgdx4S/ik11eMKseEjxg1iekhQO1O7o4wr7cCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CF20C200F45;
	Thu, 27 Aug 2026 14:57:06 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzZfG-003bey-2N;
	Thu, 27 Aug 2026 14:57:06 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 815F358D8BC;
	Thu, 27 Aug 2026 12:57:06 +0000 (UTC)
Date: Thu, 27 Aug 2026 14:57:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org, Cen Zhang <blbllhy@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH net 12/14] can: kvaser_usb: validate command format
 before parsing in hydra receive path
Message-ID: <20260827-berserk-dynamic-bustard-961b90-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-13-mkl@pengutronix.de>
 <20260827121055.E1EF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="47tyunpu232hveq3"
Content-Disposition: inline
In-Reply-To: <20260827121055.E1EF51F000E9@smtp.kernel.org>


--47tyunpu232hveq3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 12/14] can: kvaser_usb: validate command format
 before parsing in hydra receive path
MIME-Version: 1.0

Hello Cen Zhang,

On 27.08.2026 12:10:55, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] The patch prevents a specific out-of-bounds read of `cmd->len` b=
y verifying at least 6 bytes are available, but it fails to enforce a safe =
minimum structural length for extended commands. A malicious USB device can=
 provide a trivially small `cmd->len` (e.g., 8), bypassing the buffer bound=
ary checks in the parser and leading to severe slab-out-of-bounds reads in =
downstream command handlers.

can you comment on this one?

regards,
Marc

>
> Pre-existing issues:
> - [Critical] Missing validation of the `echo_index` sentinel value allows=
 a malicious USB device to trigger a slab-out-of-bounds read and an arbitra=
ry kernel pointer write, leading to potential privilege escalation.
> --
>
> commit 36da6d5bcb0fd8b842d165066e47c1ff8b40c308
> Author: Cen Zhang (Microsoft) <blbllhy@gmail.com>
>
> can: kvaser_usb: validate command format before parsing in hydra receive =
path
>
> This commit adds bounds checking for command formats in the kvaser_usb hy=
dra
> receive path. It aims to prevent a slab-out-of-bounds read caused by mali=
cious
> USB devices sending truncated headers or zero-length commands.
>
> Link: https://patch.msgid.link/20260826013037.6933-1-blbllhy@gmail.com
>
> > diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/driver=
s/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> > index efbb7bed34c9d..efe7b3ef489bf 100644
> > --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> > +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> > @@ -536,6 +536,24 @@ static size_t kvaser_usb_hydra_cmd_size(struct kva=
ser_cmd *cmd)
> >  	return ret;
> >  }
> >
> > +/* -EAGAIN means incomplete; -EINVAL rejects zero to ensure progress. =
*/
> > +static int kvaser_usb_hydra_cmd_size_rx(struct kvaser_cmd *cmd,
> > +					size_t remaining, size_t *cmd_len)
> > +{
> > +	if (remaining < sizeof(cmd->header.cmd_no))
> > +		return -EAGAIN;
> > +
> > +	if (cmd->header.cmd_no =3D=3D CMD_EXTENDED &&
> > +	    remaining < offsetof(struct kvaser_cmd_ext, cmd_no_ext))
> > +		return -EAGAIN;
> > +
> > +	*cmd_len =3D kvaser_usb_hydra_cmd_size(cmd);
> > +	if (!*cmd_len)
> > +		return -EINVAL;
>
> [Severity: High]
> Does this length validation allow maliciously small extended commands?
>
> While this prevents cmd_len from being 0, it allows trivially small values
> (e.g., 8 bytes). If a malicious device places an 8-byte extended command =
at
> the very end of a 3072-byte USB bulk transfer, kvaser_usb_hydra_cmd_size_=
rx()
> will return 0 and set cmd_len to 8. Because pos + 8 =3D=3D len, the overa=
rching
> boundary check in the parser will pass, handing the 8-byte command to
> kvaser_usb_hydra_handle_cmd().
>
> Downstream handlers like kvaser_usb_hydra_rx_msg_ext() then blindly access
> payload fields extending far beyond 8 bytes (such as cmd->rx_can.kcan_hea=
der
> at offset 20). Does this code read out-of-bounds of the 3072-byte heap
> allocation?
>
> > +
> > +	return 0;
> > +}
> > +
> >  static struct kvaser_usb_net_priv *
> >  kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
> >  				   const struct kvaser_cmd *cmd)
>
> [ ... ]
>
> [Severity: Critical]
> This isn't a bug introduced by this patch, but while reviewing this file I
> noticed a pre-existing issue where an unvalidated echo_index can lead to
> an out-of-bounds read and arbitrary memory corruption.
>
> In kvaser_usb_hydra_tx_acknowledge():
>
> 	u16 transid =3D kvaser_usb_hydra_get_cmd_transid(cmd);
> 	...
> 	context =3D &priv->tx_contexts[transid % dev->max_tx_urbs];
> 	...
> 	skb =3D priv->can.echo_skb[context->echo_index];
> 	if (skb)
> 		skb_hwtstamps(skb)->hwtstamp =3D kvaser_usb_hydra_ktime_from_cmd(dev->c=
fg, cmd);
>
> When a TX context is free (or newly initialized), context->echo_index is
> set to the sentinel value dev->max_tx_urbs:
>
> 	context->echo_index =3D dev->max_tx_urbs;
>
> If a malicious USB device sends a spoofed CMD_TX_ACKNOWLEDGE with a trans=
id
> matching a free TX context, this code directly indexes priv->can.echo_skb
> using dev->max_tx_urbs.
>
> Since echo_skb is placed exactly at the end of the net_device memory block
> (via alloc_candev_mqs), an index of max_tx_urbs reads 8 bytes of garbage
> from the subsequent kernel slab object.
>
> If the read value is non-NULL, the driver dereferences it and writes a
> 64-bit timestamp derived from the attacker-controlled USB packet into mem=
ory.
> Can this be triggered by a malicious USB device?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826121036.27=
06424-1-mkl@pengutronix.de?part=3D12
>
>

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--47tyunpu232hveq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCapA0IAAKCRDMOmT6rpmt
0i10AQDLGoohF7rIlJ4o/bF61K1vn7CbmGYJc6I3co+likp6QgEAo7ihAUJuY90w
Z0KCj9+xnDPerUaWIg7WjZ+2SybSTQ0=
=3Ge4
-----END PGP SIGNATURE-----

--47tyunpu232hveq3--
