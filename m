From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: flexcan.c: Correctly initialize mailboxes
Date: Tue, 02 Sep 2014 16:53:15 +0200
Message-ID: <5405D9DB.7050101@pengutronix.de>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>	<1409133487-23367-2-git-send-email-david@protonic.nl>	<54059ADC.60309@pengutronix.de>	<20140902123725.01808f36@archvile>	<5405A31E.1060403@pengutronix.de> <20140902133255.42a73441@archvile> <5405AC3D.5040508@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HK3HVKHuC9cExjob8wthXVN7r47CGIvjg"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50984 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbaIBOxU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 10:53:20 -0400
In-Reply-To: <5405AC3D.5040508@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HK3HVKHuC9cExjob8wthXVN7r47CGIvjg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2014 01:38 PM, Marc Kleine-Budde wrote:

>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index 3f21142..f028c5d 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -62,7 +62,7 @@
>>  #define FLEXCAN_MCR_BCC			BIT(16)
>>  #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
>>  #define FLEXCAN_MCR_AEN			BIT(12)
>> -#define FLEXCAN_MCR_MAXMB(x)		((x) & 0xf)
>> +#define FLEXCAN_MCR_MAXMB(x)		((x) & 0x1f)
>>  #define FLEXCAN_MCR_IDAM_A		(0 << 8)
>>  #define FLEXCAN_MCR_IDAM_B		(1 << 8)
>>  #define FLEXCAN_MCR_IDAM_C		(2 << 8)
>> @@ -735,9 +735,11 @@ static int flexcan_chip_start(struct net_device *=
dev)
>>  	 *
>>  	 */
>>  	reg_mcr =3D flexcan_read(&regs->mcr);
>> +	reg_mcr &=3D ~FLEXCAN_MCR_MAXMB(0xff);
>>  	reg_mcr |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
>>  		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
>> -		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS;
>> +		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
>> +		FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
>>  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
>>  	flexcan_write(reg_mcr, &regs->mcr);
>> =20
>> Eh! This looks wrong! The MAXMB field is 7 bits wide according to the
>> reference manual (bits 0-6)... but the reset default value is supposed=
 to be
>=20
> ...according to the imx6 reference manual. The size of the MAXMB field
> depends on the actual IP version.

On mcf5213 (some old coldfire, not supported by this driver)
it's 4 bit wide.
On mx25, mx28, mx53 it's 6 bits wide.
On mx6{q,sdl}, vf610 it's 7 bits wide.
I'm not sure about the powerpc based cores as I don't have the data sheet=
s.

I cannot find a data sheet, where it has a width of 5 bit.

I'll prepare a patch to fix it.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HK3HVKHuC9cExjob8wthXVN7r47CGIvjg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQF2dsACgkQjTAFq1RaXHP8oQCeIZf5E3rbZN79y1XgDf5pyE7b
AD4AmgI5AXpv1RIyR88MQzewZ+Y73Td4
=tCEA
-----END PGP SIGNATURE-----

--HK3HVKHuC9cExjob8wthXVN7r47CGIvjg--
