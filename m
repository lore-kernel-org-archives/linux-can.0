From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Thu, 11 Apr 2013 09:49:53 +0200
Message-ID: <51666B21.10109@pengutronix.de>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DVSXUBKFQUXMUXOHEKEL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42559 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab3DKHtz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Apr 2013 03:49:55 -0400
In-Reply-To: <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mylene Josserand <Mylene.Josserand@navocap.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DVSXUBKFQUXMUXOHEKEL
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/11/2013 09:39 AM, Mylene Josserand wrote:
> Hi Marc,
>=20
> Le 10/04/2013 17:30, Marc Kleine-Budde a =E9crit :
>> On 04/10/2013 04:11 PM, Mylene Josserand wrote:
>>
>>>> If it's the first spi transfer in the driver that hangs and if the
>>>> mcp251x works if loaded as a module, there is probably some
>>>> initialisation missing. Look for stuff that gets initialized after t=
he
>>>> mcp251x would have been loaded if compiled into the kernel. Make a
>>>> "diff" between the bootload with mcp251x compiled into the kernel an=
d
>>>> without. Other usual suspects are: clocks, pinmux (spi _and_ the mcp=
251x
>>>> dedicated IRQ line), gpio setup.
>>>
>>> Thanks for the advice and the ideas to look at ! I have already compa=
red
>>> the bootload and I have seen no differences (maybe I will check that
>>> another time). I will search about clocks, pinmux and gpio setup and =
I
>>> will update you if I found how to fix that.
>>
>> Save the bootlog of a system start with the driver compiled as a modul=
e
>> into file bootlog-module.txt. Make a second bootlog with the driver
>> compiled into the kernel, save as bootlog-builtin.txt. Then:
>>
>>      diff -u bootlog-module.txt bootlog-builtin.txt
>>
>> Look for the stuff that would have been initialized _after_ the system=

>> hangs. The diff should show you this.
>>
>> Marc
>>
>=20
> Thank you for the help.
> I have done it and instead of having the mcp configuration, in the=20
> bootlog-module, there is the libphy fec_net_mii_bus driver probed and=20
> other boot configurations.
>=20
> "
>   spi_imx imx27-cspi.0: master is unqueued, this is deprecated
>   spi_imx imx27-cspi.0: probed
>   CAN device driver interface
> -mcp251x_can_init
> -mcp251x_clean
> -mcp251x_can_probe
> -mcp251x_hw_probe
> -mcp251x_hw_reset
> -mcp251x_hw_reset : spi_write : start
> +libphy: fec_enet_mii_bus: probed
> +PPP generic driver version 2.4.2
> +PPP BSD Compression module registered
> +PPP Deflate Compression module registered
> +PPP MPPE Compression module registered
> +ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> +ehci-mxc: Freescale On-Chip EHCI Host driver
> +mxc-ehci mxc-ehci.2: initializing i.MX USB Controller
> [...]
> "
>=20
> If the MCP 251x is compiled as module, will it use the init configurati=
on ?
>=20
> I think I have a problem with the irq because I have tried to use it as=
=20
> module and when I do "ifconfig can0 up", I get :
> "
> root@navocap:~# ifconfig can0 up
> genirq: Threaded irq requested with handler=3DNULL and !ONESHOT for irq=
 201
> mcp251x spi0.0: failed to acquire irq 201

It's a bug in the driver....which was introduced in v3.5[1]. I'm looking
for a fix.

Marc

[1] 1c6c695 genirq: Reject bogus threaded irq requests

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2DVSXUBKFQUXMUXOHEKEL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFmayEACgkQjTAFq1RaXHOhOwCfUeKfJdFRNhHxXHAn8f0YplMX
9FMAn3wD8T8+Qb3PeMKREolJxqAPUSk+
=Hjyo
-----END PGP SIGNATURE-----

------enig2DVSXUBKFQUXMUXOHEKEL--
