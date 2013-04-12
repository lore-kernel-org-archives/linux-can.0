From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Fri, 12 Apr 2013 11:49:08 +0200
Message-ID: <5167D894.1020002@pengutronix.de>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local> <51666B21.10109@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445D@SERVEUR0.nvp.local> <516676B5.6090903@pengutronix.de> <CA78C307B8F06747967D122FC656B153774460@SERVEUR0.nvp.local> <51668741.6030909@pengutronix.de> <CA78C307B8F06747967D122FC656B153774467@SERVEUR0.nvp.local> <5166D231.2040107@pengutronix.de> <CA78C307B8F06747967D122FC656B15377446C@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HVKGKWJTLPRUQVHFHWWM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45798 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab3DLJtK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Apr 2013 05:49:10 -0400
In-Reply-To: <CA78C307B8F06747967D122FC656B15377446C@SERVEUR0.nvp.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mylene Josserand <Mylene.Josserand@navocap.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HVKGKWJTLPRUQVHFHWWM
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/12/2013 11:24 AM, Mylene Josserand wrote:
>>> I have read 15 383 frames but after 15 834, it hangs. And after that,=
 I
>>> can not act on the CAN anymore. A "ifconfig can0 down" hangs the kern=
el
>>> (even with ^C) and I have to restart the board to use the CAN again !=

>>
>> Ohhh, not good.
>>
>> Activate "MAGIC_SYSRQ" in the kernel via "make menuconfog" (Kernel
>> hacking ->  Magic SysRq key) and bring your system to hang again. Then=

>> connect via serial line to your embedded system and send a "break". (S=
ee
>> documentation of your terminal program.). After the "break" send a
>> normal "?" to get the help. If I remember correctly, use "break" +  "d=
"
>> to create a stackdump (see
>> http://lxr.linux.no/linux+v3.8.6/Documentation/sysrq.txt for more
>> documentation). You might want to try the magic sys request if your
>> system is still alive to test if your setup is working.
>>
>> With the stack trace you might figure out what the system is doing.
>=20
>=20
> Oouuhhhaaa ! Very useful ! It did not know the sysrq and it seems to be=
=20
> very powerful ! Thanks ! :D

You're welcome.

> About serious things, the "d" command did not work (it prints the help)=
=20
> but the "w" command ["dump tasks that are uninterruptable (blocked)=20
> state"] shows interesting things :

Maybe it was not 'd', but you've found the interesting information.

> ---- when not blocked (so nothing in there) :
> "
> SysRq : Show Blocked State
>    task                PC stack   pid father
> Sched Debug Version: v0.10, 3.8.2-9-can-modules+ #1
> [...]
> "
>=20
> ---- when blocked :
> "
> SysRq : Show Blocked State
>    task                PC stack   pid father
> kworker/u:0     D c03d6b20     0     6      2 0x00000000
> [<c03d6b20>] (__schedule+0x298/0x434) from [<c03d59c8>]=20
> (schedule_timeout+0x170/0x1c0)
> [<c03d59c8>] (schedule_timeout+0x170/0x1c0) from [<c03d70d4>]=20
> (wait_for_common+0x148/0x1a4)
> [<c03d70d4>] (wait_for_common+0x148/0x1a4) from [<c0287078>]=20
> (spi_imx_transfer+0x70/0x84)
> [<c0287078>] (spi_imx_transfer+0x70/0x84) from [<c0285284>]=20
> (bitbang_work+0x130/0x390)

The spi driver is waiting for a transfer to finish, it hangs in the
wait_for_completion():

http://lxr.linux.no/linux+v3.8.6/drivers/spi/spi-imx.c#L712

The corresponding function (i.e. complete()) is called from the
interrupt handler, once a transfer ins completed:

http://lxr.linux.no/linux+v3.8.6/drivers/spi/spi-imx.c#L649

> [<c0285284>] (bitbang_work+0x130/0x390) from [<c002ee44>]=20
> (process_one_work+0x28c/0x504)
> [<c002ee44>] (process_one_work+0x28c/0x504) from [<c002f688>]=20
> (worker_thread+0x1f0/0x648)
> [<c002f688>] (worker_thread+0x1f0/0x648) from [<c0036894>]=20
> (kthread+0xa0/0xac)
> [<c0036894>] (kthread+0xa0/0xac) from [<c00093b0>] (ret_from_fork+0x14/=
0x24)
> irq/201-mcp251x D c03d6b20     0   950      2 0x00000000
> [<c03d6b20>] (__schedule+0x298/0x434) from [<c03d59c8>]=20
> (schedule_timeout+0x170/0x1c0)
> [<c03d59c8>] (schedule_timeout+0x170/0x1c0) from [<c03d70d4>]=20
> (wait_for_common+0x148/0x1a4)
> [<c03d70d4>] (wait_for_common+0x148/0x1a4) from [<c02839b0>]=20
> (__spi_sync+0x58/0x9c)
> [<c02839b0>] (__spi_sync+0x58/0x9c) from [<bf08f138>]=20
> (mcp251x_spi_trans+0xa4/0xd0 [mcp251x])
> [<bf08f138>] (mcp251x_spi_trans+0xa4/0xd0 [mcp251x]) from [<bf090140>] =

> (mcp251x_can_ist+0x60/0x348 [mcp251x])
> [<bf090140>] (mcp251x_can_ist+0x60/0x348 [mcp251x]) from [<c005bbf4>]=20
> (irq_thread_fn+0x1c/0x34)
> [<c005bbf4>] (irq_thread_fn+0x1c/0x34) from [<c005bce4>]=20
> (irq_thread+0xd8/0x148)
> [<c005bce4>] (irq_thread+0xd8/0x148) from [<c0036894>] (kthread+0xa0/0x=
ac)
> [<c0036894>] (kthread+0xa0/0xac) from [<c00093b0>] (ret_from_fork+0x14/=
0x24)
> Sched Debug Version: v0.10, 3.8.2-9-can-modules+ #1
> [...]
> "
>=20
> We can see that the problem is during the spi transfer.
> Do you think it is a hardware problem ?

Maybe a hardware problem, a driver problem or a problem in the hardware
triggering a bug in the driver.

> What is the "kworker" task ?
> How fix it ?

The "kworker" is some infrastructure task in that parts of the imx spi
driver "live". Here the scenario is:

- The spi_imx_transfer() is waiting for a transfer to finish.
- The finish of the transfer is signaled via the
  complete() <-> wait_for_completion()
- An Interrupt will call complete()
- Did we get an Interrupt? Did we miss the Interrupt?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2HVKGKWJTLPRUQVHFHWWM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFn2JQACgkQjTAFq1RaXHP34QCZAfyynZYeIyPJwyBagNl/+ACH
1WQAn0JY+wMcD4lgw4cTKi9rtlU7yIQQ
=JnZ4
-----END PGP SIGNATURE-----

------enig2HVKGKWJTLPRUQVHFHWWM--
