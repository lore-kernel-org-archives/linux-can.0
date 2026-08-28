Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7507372EE4;
	Fri, 28 Aug 2026 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932028; cv=none; b=L/5m8twJQwqKhZw/guLx3lmWKG3IMHP4/TqcqITPcVUyvKgKBQIc4m5Lzhx90RJNnStrD3JJIAC+P5J7dSR5J87xcayqjNSzkKsfNFGdhQSgYhsteU+EwqY8sDuCMP/RjBiZhP2ZXrBbY0wGbml7N7k88wSu4JAr34n7UE3uo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932028; c=relaxed/simple;
	bh=9n3GMVHASBJlOdY01+HlIVjXCtXLY0HHZhso+k8GU98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNxvSUOmehBz1Ii4PHXHpDxIS1b2NunwIjd+kTwuUwJzd5TzsXzI6h6g/UsZIWVswg4cjLt+iZENWVDkksLvNIVU/uS66JAsLRIa7vuUxyMFDFjmcBfxfmkwGMOfyXqT/qXEfGNeEzi2IX02HEbnlXzDGhiUB2zILIp2fBF9U2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOslPNrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOslPNrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8AE1F000E9;
	Fri, 28 Aug 2026 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787932015;
	bh=oG4XzSrbBIQnwN0trQXME6j9eahVX1tKyL/6Zu2qJ54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KOslPNrKaId5FN7FYjGworIMoFLf4ctYktQ+kWdpNr9oU26SZz/kwuQezO+5LWuVy
	 L6TpchSU3OGBzAq0AgwDnJFFZU92mlFujF9opAGajvT0obuZ78Qc8ELMp7aoysdGCc
	 TNuUTdUrqaAxJA3jreWPyvgjVAO7I0KoH1RKfYnCNfvJuVJGR99NyOfJ41ewyed3LX
	 CxrgC7tqw9SNZXe+3/M7eqO/vx4Y0c+GTNmv7A1kGC59He/qtMee7TgOwpSOZKR6H+
	 tn8BVEbn2tMa7nd9UUQ00UCEahmAUFaIO5FLMeecdvNvO8m4IxI0aQ3cVij9s8Ggf4
	 p6qE1gDv+jCEw==
Date: Fri, 28 Aug 2026 16:46:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kendall Willis <k-willis@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
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
Message-ID: <20260828-ladle-hurry-d6f63c45fd19@spud>
References: <20260821-temp-v3-0-9ac1f8806929@ti.com>
 <20260821-temp-v3-1-9ac1f8806929@ti.com>
 <20260821-regulate-recharger-2e984e9591ef@spud>
 <20260821190511.jwdgox4uocbf4brd@uda0506412>
 <20260824-public-mashing-252473f928c3@spud>
 <20260828-antique-lumpy-donkey-51ff42@quoll>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DdnUpmEe7GeazCUr"
Content-Disposition: inline
In-Reply-To: <20260828-antique-lumpy-donkey-51ff42@quoll>

--DdnUpmEe7GeazCUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 11:07:29AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Aug 24, 2026 at 05:50:20PM +0100, Conor Dooley wrote:
> > On Fri, Aug 21, 2026 at 02:05:11PM -0500, Kendall Willis wrote:
> > > On 17:45-20260821, Conor Dooley wrote:
> > > > On Fri, Aug 21, 2026 at 11:07:00AM -0500, Kendall Willis wrote:
> > > > > Add the out-band-wakeup property as a possible property. The prop=
erty
> > > > > indicates that the device can wakeup the system even when its pow=
er
> > > > > domain is off.
> > > > >=20
> > > > > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_ca=
n.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > > > > index 2c9d37975bedd652b3060ab11ba75c37565edaad..0663beaa532bcc4a7=
1cd6ad01520a4dfea294d0c 100644
> > > > > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > > > > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > > > > @@ -150,6 +150,8 @@ properties:
> > > > >      description:
> > > > >        List of phandles to system idle states in which mcan can w=
akeup the system.
> > > > > =20
> > > > > +  out-band-wakeup: true
> > > >=20
> > > > Where is "-wakeup" defined genericly, or out-band-wakeup defined th=
at
> > > > you're getting the property definition from?
> > >=20
> > > I sent a PR to define out-band-wakeup in the wakeup-source.yaml bindi=
ng
> > > in dt-schema repo. I figured it made more sense to be defined in the
> > > wakeup-source.yaml binding to allow other drivers the option to use i=
t.
> > >=20
> > > dt-schema PR:
> > > https://github.com/devicetree-org/dt-schema/pull/205
> >=20
> > This sounds like something you should be able to determine from
> > device specific compatibles for these platforms. Not sure why they are
> > not used for this particular device, but this is an indication to me
> > that that is a mistake.
>=20
> Yeah, it looks a bit too much replicating Linux PM detail. I can imagine
> that some devices on some board are capable of waking up the system even
> when power domain is off, but this does not look like a capability of
> the actual device, but power domain. Device does not have different
> wakeups. (by device I mean this individual schema - Bosch CAN)
>=20
> Happy to see some bigger picture through DTS or board layouts. Actually
> DTS, showing same Bosch CAN devices which are different on a board -
> some are wakeups and some out of band wakeups - would illustrate it
> better.

As far as I could make out when I looked at the patch, "Bosch CAN" is an
IP that can be integrated on an SoC rather than a device on the board,
so I'm doubting that there's any difference in capability to wake up the
device caused by the board at all. If there is, it's between different
power domains on the SoC, as you say.

>=20
> Best regards,
> Krzysztof
>=20

--DdnUpmEe7GeazCUr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapGtZgAKCRB4tDGHoIJi
0qGmAP92rgbaMRQvJuWSPl4CPO4Jy2snrCn+oZiFpvtzxoXBxwD/Rr1rcXToj+fC
TkoqqP9x1N4eAT8m9hkWu6odSSduaQw=
=sVzk
-----END PGP SIGNATURE-----

--DdnUpmEe7GeazCUr--
