Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC446A60A;
	Mon, 31 Aug 2026 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189245; cv=none; b=Tk76SwxVrkIvxqLI0NDDOY9T3Hc7b+ioE6deuLm0/aKfTmPuTQEKSBPwZ8Xtbm1a+sQjRGs9PF1GYlo7E53rDk8LCjG4pScLTdeiG74Hmoc6Zifq39WYNFVul0NSaKynVbuZbe40Gb8bPEAdjNFIMpl2Lw6sS5dO2ZUE2N61Nv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189245; c=relaxed/simple;
	bh=DqrbEY0aXBR5tKhbk1QNVpPlLj3aLfv3Bc8ezWVHJYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XInA7lflyCmfE7y5pnWFbr26544fSgCuBNXRkOREKGY/3lxBS92sg1FWjlwwYNK7SeyKfkbUTFDwwsQPkSNJYSIIyUqpgzgyKzBaCtcoOrwzT/TpklHq9XhIxDDOI//9jxijM47DVx73vXa/0ew29MqhoUuJl3vl/YHL+dKNhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FahFoa6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FahFoa6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1156B1F000E9;
	Mon, 31 Aug 2026 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788189244;
	bh=coDomFzLKuW4divIIXOeaioZHCWmeB95+WLqyp/Yr0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FahFoa6YA9EslxaVx1TgszBZvREJeICSFH3xJhuB3iI2aT74SVftGvj0QpBZi8ELQ
	 XWwQs4wYmHECSkMbyb1BAShFv1Zyk6z9kCm4Ox4DMBxyK9k195eYypl67CDyjiYiRF
	 pqnyagNCkZP7WPmOoIsuBvSsKaxY5PKr5EupMCWQ84dy9z7fnnm4GqohlRP/N63V0G
	 F4CAx6cupfnXfAfuMM+xpmz2mnw9p58xGqyYz/kfRUiNGWhHGd61ViFSiT2hM3tCTi
	 3WL6sYQV1RFsUN/QJ6reVmzp2uuNZeW1OFBdFv0rB1rOUgyn5GIQw0oCh4+S3oCnCY
	 atewofPFRRU8w==
Date: Mon, 31 Aug 2026 16:13:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kendall Willis <k-willis@ti.com>,
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
Message-ID: <20260831-guise-nastiness-23b5d1cbc25d@spud>
References: <20260821-temp-v3-0-9ac1f8806929@ti.com>
 <20260821-temp-v3-1-9ac1f8806929@ti.com>
 <20260821-regulate-recharger-2e984e9591ef@spud>
 <20260821190511.jwdgox4uocbf4brd@uda0506412>
 <20260824-public-mashing-252473f928c3@spud>
 <20260828-antique-lumpy-donkey-51ff42@quoll>
 <20260828-ladle-hurry-d6f63c45fd19@spud>
 <DL0SRC0352S9.2VXHSPLXP6QZR@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0VrU3kkrQj9JtflS"
Content-Disposition: inline
In-Reply-To: <DL0SRC0352S9.2VXHSPLXP6QZR@baylibre.com>

--0VrU3kkrQj9JtflS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 08:43:30PM +0200, Markus Schneider-Pargmann wrote:
> Hi,
>=20
> On Fri Aug 28, 2026 at 5:46 PM CEST, Conor Dooley wrote:
> > On Fri, Aug 28, 2026 at 11:07:29AM +0200, Krzysztof Kozlowski wrote:
> >> On Mon, Aug 24, 2026 at 05:50:20PM +0100, Conor Dooley wrote:
> >> > On Fri, Aug 21, 2026 at 02:05:11PM -0500, Kendall Willis wrote:
> >> > > On 17:45-20260821, Conor Dooley wrote:
> >> > > > On Fri, Aug 21, 2026 at 11:07:00AM -0500, Kendall Willis wrote:
> >> > > > > Add the out-band-wakeup property as a possible property. The p=
roperty
> >> > > > > indicates that the device can wakeup the system even when its =
power
> >> > > > > domain is off.
> >> > > > >=20
> >> > > > > Signed-off-by: Kendall Willis <k-willis@ti.com>
> >> > > > > ---
> >> > > > >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | =
2 ++
> >> > > > >  1 file changed, 2 insertions(+)
> >> > > > >=20
> >> > > > > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m=
_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> >> > > > > index 2c9d37975bedd652b3060ab11ba75c37565edaad..0663beaa532bcc=
4a71cd6ad01520a4dfea294d0c 100644
> >> > > > > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.ya=
ml
> >> > > > > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.ya=
ml
> >> > > > > @@ -150,6 +150,8 @@ properties:
> >> > > > >      description:
> >> > > > >        List of phandles to system idle states in which mcan ca=
n wakeup the system.
> >> > > > > =20
> >> > > > > +  out-band-wakeup: true
> >> > > >=20
> >> > > > Where is "-wakeup" defined genericly, or out-band-wakeup defined=
 that
> >> > > > you're getting the property definition from?
> >> > >=20
> >> > > I sent a PR to define out-band-wakeup in the wakeup-source.yaml bi=
nding
> >> > > in dt-schema repo. I figured it made more sense to be defined in t=
he
> >> > > wakeup-source.yaml binding to allow other drivers the option to us=
e it.
> >> > >=20
> >> > > dt-schema PR:
> >> > > https://github.com/devicetree-org/dt-schema/pull/205
> >> >=20
> >> > This sounds like something you should be able to determine from
> >> > device specific compatibles for these platforms. Not sure why they a=
re
> >> > not used for this particular device, but this is an indication to me
> >> > that that is a mistake.
> >>=20
> >> Yeah, it looks a bit too much replicating Linux PM detail. I can imagi=
ne
> >> that some devices on some board are capable of waking up the system ev=
en
> >> when power domain is off, but this does not look like a capability of
> >> the actual device, but power domain. Device does not have different
> >> wakeups. (by device I mean this individual schema - Bosch CAN)
> >>=20
> >> Happy to see some bigger picture through DTS or board layouts. Actually
> >> DTS, showing same Bosch CAN devices which are different on a board -
> >> some are wakeups and some out of band wakeups - would illustrate it
> >> better.
> >
> > As far as I could make out when I looked at the patch, "Bosch CAN" is an
> > IP that can be integrated on an SoC rather than a device on the board,
> > so I'm doubting that there's any difference in capability to wake up the
> > device caused by the board at all. If there is, it's between different
> > power domains on the SoC, as you say.
>=20
> m_can is an IP that can be integrated on an SoC. But it is also
> built into external chips, like the TI tcan chips that connect via SPI.
> There is also a PCI connected one. Also some SoC integrated m_can
> devices are coupled to the mcu and not the main processor and can't be
> fully accessed from the main processor, e.g. they are missing
> interrupts.

All of these things: soc integrations, each specific SPI connected SKU
and the PCI connected device should have specific compatibles. Per the
series adding these to devicetrees, it's all mcu connected instances
that are growing the property, and not devices on boards that depend on
how the specific board has been wired.


https://lore.kernel.org/all/20260820-smth-v1-1-e1738a38d58e@ti.com/

--0VrU3kkrQj9JtflS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapWaNgAKCRB4tDGHoIJi
0jkTAQCOUsS3T1tQxU+NW0CNMAgmu1+n0fnxdyVN0gZsY6k4aAD+PWgvo+ox/ois
rsu9E0DdhgZ2fRBlIN6loUS1Uc26Kwo=
=5aeG
-----END PGP SIGNATURE-----

--0VrU3kkrQj9JtflS--
