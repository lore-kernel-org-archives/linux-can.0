Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517B377AB6;
	Mon, 24 Aug 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590226; cv=none; b=F6gOjolW5HQspWnn4aTNv1B6Cn0ML2lwD/dEdLxBesXVITQV5rej9XDlR2YrmZ4BZfCOJA1uz+ZSZhnVQBi2qLKEr9Wfhn69dCsVKvffdc3wEDXxj2uYLMEa4uEB3Z9Ia8t7Oxv/biXyZTVrNN7u9KPmNgMSeCPAzNg3Jc3NQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590226; c=relaxed/simple;
	bh=P2oE7NNSes296z+R5pgyux6238eLyzOHrVS++MTq3uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgIlk9bvcSjLPtwQ0Kcxy6FQVmGlJQ+M2znqb/5DBXjct5XmnlywFrcJR7hJCwqEfgEecHv+YvlN2AWvCVoUHaevhNZP1PnDnll/slhO1+3d6ZRFxvdInrbrSNbhvB9keq5N+yEXyqgprwVOHKplE35lAtfCK+L2i77Q7iYbKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMpEX+Qt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMpEX+Qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E601F00AC4;
	Mon, 24 Aug 2026 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590225;
	bh=6x+poQPlXHIZacgVgB4fgeSl2HAChqchH7MvBjpDI2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iMpEX+Qtz6jvGo9EWmZpxZYqB6Ugl2Z5v+PTtG0c9ajr3Cl3y0s/8iJ5ZT8IXvN+v
	 Z3LYrkQs2WdXPT6OfbylT7oZD5BJ4J8AWRHSkN2ZzXlN2Gn5eSWwueGcxUKGYbU9vd
	 4zIraJMNXInIBjIa/eLfpEvNkNUucgJFmRTdKxn7qi5RGoAUJFvkyPiJoqVYkvxRG0
	 k3u342qRW4puWBkvyG6kX1A5pqM0foDx0LJzGOpfSTbPOT/reCtr98vngX+AQybo4j
	 WEhbsJIckL5/ciVwOgLSVXtTSJb2A9zJXX8B3hjqO9JO2EF8Lc2OFkwZLp2gbPbGtg
	 yb4j8tPHi0njA==
Date: Mon, 24 Aug 2026 17:50:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com,
	vishalm@ti.com, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: can: m_can: add out-band-wakeup
 property
Message-ID: <20260824-public-mashing-252473f928c3@spud>
References: <20260821-temp-v3-0-9ac1f8806929@ti.com>
 <20260821-temp-v3-1-9ac1f8806929@ti.com>
 <20260821-regulate-recharger-2e984e9591ef@spud>
 <20260821190511.jwdgox4uocbf4brd@uda0506412>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xOCU88mvube+3/uL"
Content-Disposition: inline
In-Reply-To: <20260821190511.jwdgox4uocbf4brd@uda0506412>

--xOCU88mvube+3/uL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 02:05:11PM -0500, Kendall Willis wrote:
> On 17:45-20260821, Conor Dooley wrote:
> > On Fri, Aug 21, 2026 at 11:07:00AM -0500, Kendall Willis wrote:
> > > Add the out-band-wakeup property as a possible property. The property
> > > indicates that the device can wakeup the system even when its power
> > > domain is off.
> > >=20
> > > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > > ---
> > >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.ya=
ml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > > index 2c9d37975bedd652b3060ab11ba75c37565edaad..0663beaa532bcc4a71cd6=
ad01520a4dfea294d0c 100644
> > > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > > @@ -150,6 +150,8 @@ properties:
> > >      description:
> > >        List of phandles to system idle states in which mcan can wakeu=
p the system.
> > > =20
> > > +  out-band-wakeup: true
> >=20
> > Where is "-wakeup" defined genericly, or out-band-wakeup defined that
> > you're getting the property definition from?
>=20
> I sent a PR to define out-band-wakeup in the wakeup-source.yaml binding
> in dt-schema repo. I figured it made more sense to be defined in the
> wakeup-source.yaml binding to allow other drivers the option to use it.
>=20
> dt-schema PR:
> https://github.com/devicetree-org/dt-schema/pull/205

This sounds like something you should be able to determine from
device specific compatibles for these platforms. Not sure why they are
not used for this particular device, but this is an indication to me
that that is a mistake.

Cheers,
Conor.

>=20
> >=20
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > >=20
> > > --=20
> > > 2.34.1
> > >=20

--xOCU88mvube+3/uL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox2TAAKCRB4tDGHoIJi
0hLmAP9Ra5gvX6p8BDvYxw1Q1w9pBMtJ+ZapwpaLEeNEZLVMpAEA+5HAYGSoyAn6
GdsivqyvQscHdBPSDcd0Y3J+YYMwlgg=
=hTch
-----END PGP SIGNATURE-----

--xOCU88mvube+3/uL--
