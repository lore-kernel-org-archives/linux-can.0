From: Mark Brown <broonie@kernel.org>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Wed, 15 Nov 2017 15:39:40 +0000
Message-ID: <20171115153940.cxlacbcyl3jxiwex@sirena.org.uk>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
 <bfa971bb-1217-ed86-d1d8-e353ecc506aa@pengutronix.de>
 <20171115120754.GC3011@hc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wprfa2rwdtellclg"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43422 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932144AbdKOPjp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 15 Nov 2017 10:39:45 -0500
Content-Disposition: inline
In-Reply-To: <20171115120754.GC3011@hc>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Tim Harvey <tharvey@gateworks.com>, linux-spi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>


--wprfa2rwdtellclg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2017 at 01:07:54PM +0100, Jan Glauber wrote:

> To support this full duplex transfer the Cavium SPI controller needs
> to know the receive lenght before setting up the transaction.

> spi_transfer only includes the total length, so I don't see how this
> should work.

For a full duplex transfer the recieve length *is* the total length of
the transfer.  If there is a mix of tx, rx and full duplex then you need
multiple xfers in the transfer.

--wprfa2rwdtellclg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloMX7sACgkQJNaLcl1U
h9C/1Qf+JpW5b0U+OGAOXioYPOfMAswMf4jkY5DnHprbabg9g8cJXkvc0ZMw6Rkq
Umkek0U35ddlmx2+fVHFZTszLeB6+/8gly9esnCagw+sXlAuSzRzBL5sSD7TfS7Y
lapN3ThqJIOe2HhclMqJpfRPqeG/w+lZN5HiJ/F4Zg1V7LdGOEygVeT2kg4irhlm
T8uDpdoTEBjuu6CkYsH4zK8TIe6cldGVifFYg9Z/wOFl90cgWPvckv8M58veRp2/
t87oFhp+5Halj26VsnktmIomHOsW5TJWg1fL/9IOSByIUhK43+rIphX91x6zhgNX
27GHr4YV/mCQPwcHkEpFX6b28/wLCQ==
=LP3E
-----END PGP SIGNATURE-----

--wprfa2rwdtellclg--
