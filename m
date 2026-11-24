Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795514353;
	b=bqUDJUmYvihRhABXM1iwyDdQln/5f+UpUTPZe1hBBnaS491l2wopW7RTmRTUTjYsTXtz
	 8UHg5Z+a00k8O7Qp86O/tkWZjP2iEW2apaelejpO08EY0t3nfNrO4lZcgGyJ1P3Syx6/G
	 HXNSVZJBAlD++w7bckH+Dv0+Y9eLzdoNVaadu7xZxG+gFXBsWcIH2cJkvihAt/eHHZ+3o
	 v1R8hGC0kvT694k5fN+9vzX4vBkYUthWtqKTvBmlgijFvExV/bJs7w6Sl0zgRiHo0QpKA
	 QuYvaGWct8IZGkNBefSvd0uAq3jN+g0M/6Zfrvb0f5lyOM5mMjLark+VvPrVHCP6WGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514353;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=1pQ5bFG5w+48mTfuDVYhYlTntDZwsE0hfL9Cy1kqIeo=;
	b=u7b/Ga4tU9WuQ1FYE4YSw+OJiMDihvu6QN35SgDEwwgzXG65T7BoN87PtTXFEx0C5Kvb
	 DahVhhuQraBNJqBZzCi9Ss2lq0pvMhD1MuFtsO7Usdpk+vEQSzpXoYWnkNCsezlqtr5sA
	 ratxhJr6aVFPGyfqsPXdx4XdviRp7BeXWwATzkiaAemtQZIYipwcgWSqMEAtwZGeaSLH9
	 0/olof9XJk4H3F53qs+3hTese8vL24bW9IUeULPsGLPXjZ0SF+umJj4amYZgk/0neLeiX
	 rUeF0RIf1ZI8FvAb7Q6avQRoVMnZC6ug6JVlkLY8atNMxi26kfewgdeCm7Spk/fWb9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="SfA/LCQn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C2606A32A
	for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 09:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F07C2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SfA/LCQn
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1CFC9201A7B;
	Tue, 24 Nov 2026 10:59:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795514351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pQ5bFG5w+48mTfuDVYhYlTntDZwsE0hfL9Cy1kqIeo=;
	b=SfA/LCQnGWhZp1E13dbr/OAJsZ1aP8yDuaEm43hx90ET/HG6irr6OFIvbplKhaudA+LRwD
	TUIRIwzSsCsVMMAkQInMfp1ppM4of+X4seht+HVj0QmNJcz5RidX3frYc8KsJbC6z/Kbx3
	CBV1/tfQr47jmRY9gNzMoWwCM4SMBbLTta90aovOSBboLKInqcZDgrE2ty1FMKus1AB1Rm
	WylXR5DMrpEO/NLGB0/1MTwByNUBs3xstOdymc3e0OVE+9WWy07I8u3iSuZgyDxjsSwSQD
	YnCYUWqgh+yXWnvyOfDVaL96wLD+cRgijGWqZXaCLoAsM16XoXwz9sEkiVLy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795514351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pQ5bFG5w+48mTfuDVYhYlTntDZwsE0hfL9Cy1kqIeo=;
	b=EMH45YFMGgcGY4fugsfGQUdM37zJC/mgkontM2xPgvvN/vD6jVIOOEfHLS8SaMAtA7Am+l
	XY8IGEMMwK77fyaDQFXGHSrlCOQLx02PoAHVSCLeeF8UydavFKsKauK9xqZNLg+dWL53os
	l6/7GKWGX8fVImfDpQBSsDXVPrdH1H3nT70Enp9ceFaUx/HaZspLkfyxTjhIC3TjQB9yAG
	yEFmOGSH49JcWD8I7IpjGT8JERbQnNHmAF+f2IeCqkdVxbNxoKZHdlk5qhqTa+aAWplVoY
	kBIlQtyz8WDcn1kDxutNakAW7aYrKBjgMtx99tgOZwR7OHNm3o1kg3/ajbzsxg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795514351; a=rsa-sha256;
	cv=none;
	b=ARvj6/eBzQo7V2Kk4B9kzIaOv1ChpFT9WWRJWtZS14vrfKVVC+vh9021NSUb5V4kSjsXAa
	INCZxyT2TddTOsb7vgE8NZDW/cchw1wW8x5QfmTXhMJSbod85estqEnim+94j246x44kWR
	vY0Q/Yat8AoWT9rQdIdhQp3NIBcMiZmMV1pIwCuQA3rgBUQ51A7IXjaizUB0SMg1ExfIc5
	3hfJg/xUwTQrJc9xGhLY+wogLTvg7cZNodYLZvInOQQ1GBlN/b+GFvVaeiNci0eyQTUHSU
	/2z3SSbOaH6ymRrscXRzMQinMOVXfn4dmeyabIPCv/eNGt8Y5o2uDFCqxrOu2w==
Date: Tue, 24 Nov 2026 10:59:10 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
	Eric Evenchick <eric@evenchick.com>, Maximilian Schneider <max@schneidersoft.net>, 
	Wolfgang Grandegger <wg@grandegger.com>, kernel@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v9 06/13] can: gs_usb: add support for context
 analysis
Message-ID: <20261124-married-literate-axolotl-8272ad-mkl@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
 <20261121-gs_usb-fixes-v9-6-db121d488945@pengutronix.de>
 <awVcnlkUDarUx5Y7@google.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uvkpkwjpt4aishng"
Content-Disposition: inline
In-Reply-To: <awVcnlkUDarUx5Y7@google.com>


--uvkpkwjpt4aishng
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v9 06/13] can: gs_usb: add support for context
 analysis
MIME-Version: 1.0

On 24.11.2026 09:45:02, Vincent Donnefort wrote:
> [...]
>
> > -static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(=
&dev->tc_lock)
> > +static u64 gs_usb_timestamp_read(struct cyclecounter *cc)
> > +	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)
> >  {
> >  	struct gs_usb *parent =3D container_of(cc, struct gs_usb, cc);
> >  	u32 timestamp =3D 0;
> > @@ -1037,7 +1040,7 @@ static int gs_can_open(struct net_device *netdev)
> >  		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
> >  			rc =3D gs_usb_timestamp_start(parent);
> >  			if (rc) {
> > -				if (rc =3D=3D -ENODEV) {
> > +				if (rc =3D=3D -ENODEV)
>
> Could this make the series non-bisectable?

Yes, I've already fixed this in v10.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uvkpkwjpt4aishng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawVf7AAKCRDMOmT6rpmt
0uorAQCItDMPYMGSe196HOgQmAY8GggdjKzsxERzAgN6gzwA5wD9FvodJaZGRRKf
Vjeym5kIdrUNaiPXxrawA+OpJ/K8pw8=
=GvTd
-----END PGP SIGNATURE-----

--uvkpkwjpt4aishng--
