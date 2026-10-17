Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B527411FB1;
	Sat, 17 Oct 2026 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792265125; cv=pass; b=PaYLVh/YPGtOUPZnMPAxq3LIfQ7GmehWEasdpC+XOlbvesb1AaAJk9sFK13s3euhyVQezNliX2Yba3aKCcmAnVsfaFka9AASLdgSqzzBE1Ch3n5FtBlfC7iNc857Z9eS1OfR1XnzNiymj+sAa+/2RJImToHJ2AWThEkTrcyjthY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792265125; c=relaxed/simple;
	bh=kWNvz0ZyGI1nIQVZ7IQMASTVfQI19hA+zYmPa/MpPd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR0PgPEDZ4CGO6u4jfvKnygs7DlnuTWRWu2fjoOvxFej+d3qGh7RfoF3S/PeD0kFxojwsjLd9yv+3BXty/kcxjk+4pdZc3y3tuUKw9Pcp4ohSvRnzajowvK477iGD3wbNk5gekE+fs3fIv00qgdOpLJ31OF3pPsbcasyHiFotTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=eR3HsJse; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="eR3HsJse"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2EA90202283;
	Sat, 17 Oct 2026 21:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792265112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9JTU96DnY4t1QS9uJSwzJH6NtmBYkqhxixiFAMSyyE=;
	b=eR3HsJsezfUb5oZKBhgi5HSNZ/iCdVHZGC2ZnpngvaQtWqtSA+X/TcIuYUiWA4adnM4xCS
	3S0rrg5zMheKAbNuN/EkoiOdHTHVVEyBGBFuqR5LivQzvDt8l2W6nry9X83uyInVoWTT4G
	ohiVCrKqPJ+McB1IWZklgWKChJHCmIHPfnncsD67wBaX8O+LpuKrxryLgTwVcSsTzeVn4J
	V9RBn1wModQusrryEZurnk5sWehVWQLMSz/WWNOcWzgAcG1gX019FQh1qxywwTidj8yaaV
	05komyXD2yhh79mB+qebsGPARME4QGY7m2HxqxGPsC1DXmf/xLnajSlnMKyIcQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792265112; a=rsa-sha256;
	cv=none;
	b=g71CLk5MJ2tif/38BYFx797squtdmA/0VExs56fIQx2kXZdvTMguK41fUMepSlhkhtB8f5
	btS3pftfTK93TVAvkON9o4z7KAWgptR9FycSoihwuFHNhzTsk/V2QR9R0jDKjbDhdObWif
	bzYgD3jXW67K4hSK0xDHt4Pd+JtTdhWtqn/rqOPNZ/pv2yc9Dx7Di+F0ahZNkkyMka538h
	en2pGulJEr1RONw0/aWgED4uERDExRlBuLPxCUc1CbZYldjscDEUOjEXMirsaC+xzZ+iAa
	uEgSzbbC90Fz1kDV10e6hiHFuOzpyZqNjIQOUUMXIqo2gat5TJ/IaMrI2hLaow==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792265112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9JTU96DnY4t1QS9uJSwzJH6NtmBYkqhxixiFAMSyyE=;
	b=N4GW7E0995xMlxL5ECp3/1g3GfmZMzjvTQOrZHA6Y28OduXzj7jxZHR68nM0exlMhj/c5a
	VB8N6PsYVqj+JpXoC5dp8/reXdcXOakQ3h4h2DZos90mXmWgTwepyT+fZrzSznroYZ4LqV
	FhiPWwXMoNfOPZ7mm4/X7tmfGxsmKcaCiJoorC+mHDGTFnuyFYBcQ5/yLLYsbjK5klz5Hg
	FnHIeTrkkkZJzW9mPyfBOZvtlsiLhgvDrajIbKlcfXaCRqQVLw6p1eKmLzR4A0eUOvt3mU
	OkAsRkrx0tyv6DZTd7XF0/s620w4PzyExXWXraQCM4F64hcWEdLAc2xGT8wuCA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIA1o-006Snr-0C;
	Sat, 17 Oct 2026 21:25:12 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4C2235C6B51;
	Sat, 17 Oct 2026 10:25:37 +0000 (UTC)
Date: Sat, 17 Oct 2026 12:25:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Tu Nguyen <tu.nguyen.xg@renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: RE: [PATCH v4 2/3] can: rcar_canfd: Derive max_channels from the
 device tree
Message-ID: <20261017-hopeful-cockle-of-fascination-69428a-mkl@pengutronix.de>
References: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
 <20261001075742.21961-3-biju.das.jz@bp.renesas.com>
 <20261016-moth-of-rampant-exercise-ecc0ee-mkl@pengutronix.de>
 <TY3PR01MB11346522BCCEDCEF941E75FD4869A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rz74lkomt4w6mt4u"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346522BCCEDCEF941E75FD4869A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--rz74lkomt4w6mt4u
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH v4 2/3] can: rcar_canfd: Derive max_channels from the
 device tree
MIME-Version: 1.0

On 17.10.2026 08:41:41, Biju Das wrote:
> > -----Original Message-----
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Sent: 16 October 2026 15:13
> > Subject: Re: [PATCH v4 2/3] can: rcar_canfd: Derive max_channels from t=
he device tree
> >
> > On 01.10.2026 08:57:38, Biju Das wrote:
> > > The maximum number of channels is currently hardcoded per SoC in
> > > struct rcar_canfd_hw_info. Since the DT describes the channels as
> > > child nodes of the controller, the count can be obtained at probe time
> > > with of_get_child_count() instead.
> > >
> > > Drop max_channels from struct rcar_canfd_hw_info and store the value
> > > in struct rcar_canfd_global, so it no longer needs to be maintained
> > > for each SoC variant. Update all for_each_set_bit() users over
> > > channels_mask to use gpriv->max_channels.
> > >
> > > No functional change.
> > >
> > > Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > the netdev sashiko is not happy.
> >
> > pw-bot: cr
> >
> > regards,
> > Marc
> >
> > --- Patch [20]: [PATCH net-next 20/37] can: rcar_canfd: Derive max_chan=
nels from the device tree ---
> > commit f2792c210c20d626154d87626c44459c153936fd
> > Author: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > can: rcar_canfd: Derive max_channels from the device tree
> >
> > This commit removes the hardcoded per-SoC max_channels from struct rcar=
_canfd_hw_info. Probe now computes
> > it with of_get_child_count() on the controller node and stores it in st=
ruct rcar_canfd_global. All
> > for_each_set_bit() loops over channels_mask now use gpriv->max_channels=
 as their bound.
> >
> > Link: https://patch.msgid.link/20261001075742.21961-3-biju.das.jz@bp.re=
nesas.com
> >
> > > diff --git a/drivers/net/can/rcar/rcar_canfd.c
> > > b/drivers/net/can/rcar/rcar_canfd.c
> > > index 74c3c3f20991..41c395118949 100644
> > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> >
> > [ ... ]
> >
> > > @@ -2145,14 +2139,18 @@ static int rcar_canfd_probe(struct platform_d=
evice *pdev)
> > >  	bool fdmode =3D true;			/* CAN FD only mode - default */
> > >  	char name[9] =3D "channelX";
> > >  	u32 ch, fcan_freq;
> > > +	u8 max_channels;
> > >  	int i;
> > >
> > >  	info =3D of_device_get_match_data(dev);
> > > +	max_channels =3D of_get_child_count(dev->of_node);
> > > +	if (max_channels > RCANFD_NUM_CHANNELS)
> > > +		return -EINVAL;
> >
> > Discovered by: gpt-6-astra, opus-5-5, opus-5 =C2=B7 Missed by: sashiko-=
gemini =C2=B7 Called a false positive by:
> > gpt-6-astra
> >
> > This isn't a bug for binding-valid DTs, but of_get_child_count() return=
s an int, and the result is stored
> > in the u8 max_channels before the range check. With 256 or more childre=
n the comparison sees the value
> > modulo 256
> > (256 becomes 0, 260 becomes 4), so the check would not reject such a no=
de.
> >
> > The binding only allows "^channel[0-7]$" children and sets
> > unevaluatedProperties: false. The truncated value is also still bounded=
 by RCANFD_NUM_CHANNELS before it
> > is used as an index bound, so nothing is accessed out of bounds.
> >
> > Would it be cleaner to keep the result in an int until after the compar=
ison?
>
> Agreed will use int until the comparison.
> >
> > Discovered by: opus-5-5, opus-5 =C2=B7 Missed by: gpt-6-astra, sashiko-=
gemini =C2=B7 Called a false positive by:
> > gpt-6-astra
> >
> > With max_channels gone from struct rcar_canfd_hw_info, this check again=
st RCANFD_NUM_CHANNELS (8) is the
> > only limit left. It is the family-wide maximum, not the channel count o=
f the specific SoC.
> >
> > Suppose a DT declared channel nodes the IP doesn't have, for example
> > channel2..channel7 on a 2-channel Gen3, RZ/G2L or RZ/T2H part. Then rca=
r_canfd_reset_controller(),
> > rcar_canfd_configure_controller() and
> > rcar_canfd_global_init() would program and poll the CCTR/CSTS, fcbase[c=
h].cfdcfg, FIFO and AFL registers
> > of channels that don't exist.
> > Before this patch those nodes were never looked up.
>
> DT binding check will fail in this case. Do we want to enforce capturing =
DT wrong usage
> in C code as well as it increases code size?

I think we trust the DT. Mention this in the commit message to keep the
bots happy. :/

[...]
> > >  	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
> > >  		fdmode =3D false;			/* Classical CAN only mode */
> > >
> > > -	for (i =3D 0; i < info->max_channels; ++i) {
> > > +	for (i =3D 0; i < max_channels; ++i) {
> > >  		name[7] =3D '0' + i;
> > >  		of_child =3D of_get_available_child_by_name(dev->of_node, name);
> > >  		if (of_child) {
> >
> > Discovered by: gpt-6-astra, opus-5-5, opus-5 =C2=B7 Missed by: sashiko-=
gemini =C2=B7 Ranked High by: gpt-6-astra
> >
> > of_get_child_count() returns how many child nodes there are, not the hi=
ghest channel index plus one. Can
> > channels be missed when the DT numbering has a gap?
> >
> > renesas,rcar-canfd.yaml matches "^channel[0-7]$" and only requires
> > channel0 and channel1, so a gap looks valid. Take a Gen4 DT with channe=
l0, channel1 and channel4, or a
> > board that removes channel2 with /delete-node/. Either way the child co=
unt is 3.
> >
> > The loop above then only looks up channel0 to channel2, so channel4's b=
it is never set in channels_mask.
> > Every later for_each_set_bit() loop is also capped by gpriv->max_channe=
ls. As a result channel4 is never
> > reset or configured, never registered as a netdev and never serviced by=
 the IRQ handlers. No warning is
> > printed.
> >
> > Before this patch the bound was info->max_channels (8 on Gen4, 6 on RZ/=
G3E), so such a channel was found
> > and probed. Does that fit with the "No functional change" statement in =
the commit message?
> >
> > All in-tree SoC dtsi files appear to use contiguous numbering, so only =
out-of-tree DTBs or overlays would
> > be affected.

With this change you add the requirement that the channels are used
contiguously and starting with the lowest. That was previously not the
case. How exotic is the use case, where not all CAN channels are used
and they are not contiguous, e.g. due to pinmux constraints of other IP
cores.

> > > @@ -2314,7 +2313,7 @@ static int rcar_canfd_probe(struct platform_dev=
ice *pdev)
> > >  	return 0;
> > >
> > >  fail_channel:
> > > -	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
> > > +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
> > >  		rcar_canfd_channel_remove(gpriv, ch);
> >
> > Discovered by: gpt-6-astra, opus-5-5, opus-5 =C2=B7 Missed by: sashiko-=
gemini =C2=B7 Ranked Critical by: gpt-6-
> > astra
> >
> > This is a pre-existing issue and was not introduced by this patch, but =
since this unwind loop is being
> > changed: if register_candev() fails, could the channel's net_device be =
freed twice?
>
> Should I send follow up patches to fix the pre-existing issues? Or re-spi=
n the series
> with fixing pre-existing issues first followed by supporting RZ/G3L?

What about dropping this patch, and, if needed, add the channel count to
the driver. Re-spin the series with the fix.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rz74lkomt4w6mt4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatNNHgAKCRDMOmT6rpmt
0nrmAPwOtE2ekJMX/qMZsg5h5RMd4fJ3498vDSEKtr4Fojy/1QEA9/ACXhREHdzd
vKDc/87Hj46k5GayH3sll4o7RP/mBAQ=
=AwvB
-----END PGP SIGNATURE-----

--rz74lkomt4w6mt4u--
