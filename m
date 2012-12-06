From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [mcp251x - spi] Blocked to "wait_for_completion"
Date: Thu, 06 Dec 2012 15:21:52 +0100
Message-ID: <50C0AA00.204@pengutronix.de>
References: <CA78C307B8F06747967D122FC656B1537FEDF4@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig99FA86A042C21FBA83B50087"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57218 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2LFOV6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 09:21:58 -0500
In-Reply-To: <CA78C307B8F06747967D122FC656B1537FEDF4@SERVEUR0.nvp.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mylene Josserand <Mylene.Josserand@navocap.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig99FA86A042C21FBA83B50087
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/06/2012 02:43 PM, Mylene Josserand wrote:
>> what SPI controller are you using? Which SoC are you on?
>=20
> We are using a IMX27 and the spi controller is inside I think.

uuuhhh....2.6.32 is pretty old for an imx27. There are probably a lot of
spi fixes, too.

>=20
>> Do you have a MCP2510 or a MCP2515?
>=20
> We have a MCP2515.
>=20
>=20
>> A lot of fixes have been applied to the driver since v2.6.34, you
>> should backport them, too.
>=20
> Yes, I see it. I have tried to update the MCP driver with a patch
> that you have wrote to "fix and optimize" this driver. Unfortunately,
> it did not seem to solve the problem. But I will try to backport the
> new driver version.

I suggest to cherry-pick the patches from your kernel to the current
one:

3c8ac0f can: remove __dev* attributes
cab32f3 can: mcp251x: avoid repeated frame bug
194b9a4 can: mark bittiming_const pointer in struct can_priv as const
c2fd03a drivers: net: Remove casts to same type
aabdfd6 can: replace the dev_dbg/info/err/... with the new netdev_xxx mac=
ros
34206f2 can: mcp251x: Allow pass IRQ flags through platform data.
58a69cb workqueue, freezer: unify spelling of 'freeze' + 'able' to 'freez=
able'
b9958a9 can: mcp251x: fix reception of standard RTR frames
612eef4 can: mcp251x: fix generation of error frames
5601b2d can: mcp251x: fix endless loop in interrupt handler if CANINTF_ME=
RRF is set
9c473fc can: mcp251x: optimize 2515, rx int gets cleared automatically
beab675 can: mcp251x: define helper functions mcp251x_is_2510, mcp251x_is=
_2515
f1f8c6c can: mcp251x: Don't use pdata->model for chip selection anymore
d3cd156 can: mcp251x: write intf only when needed
7e15de3 can: mcp251x: read-modify-write eflag only when needed
f3a3ed3 can: mcp251x: allow to read two registers in one spi transfer
711e4d6 can: mcp251x: increase rx_errors on overflow, not only rx_over_er=
rors
57d3c7b can: mcp251x: fix NOHZ local_softirq_pending 08 warning
1ae5dc3 net: trans_start cleanups
829e001 Fix some #includes in CAN drivers (rebased for net-next-2.6)
e446630 Add hotplug support to mcp251x driver
5a0e3ad include cleanup: Update gfp.h and slab.h includes to prepare for =
breaking implicit slab.h inclusion from percpu.h
bf66f37 can: mcp251x: Move to threaded interrupts instead of workqueues.
ad72c34 can: Proper ctrlmode handling for CAN devices
3ccd4c6 can: Unify droping of invalid tx skbs and netdev stats
ce739b4 drivers/net/can: Correct NULL test
c7cd606 can: Fix data length code handling in rx path
615534b can: fix setting mcp251x bit timing on open
e000016 can: Driver for the Microchip MCP251x SPI CAN controllers

But you have to omit some that are not compatible with your kernel.

>> The CAN driver calls into the SPI layer to send a message
>> synchronously. The SPI layer kicks the SPI driver to send the
>> message, bus, this is done asynchronously. In the completion
>> handler of the SPI driver the SPI layer is told that the SPI
>> transfer is complete.
>=20
>> In the above described mechanism the SPI layer is waiting with=20
>> wait_for_completion(), the SPI driver will call (either directly,
>> or via a callback, which has been set by the SPI layer) a
>> complete() which will wake up the SPI layer.
>=20
>> If the SPI layer is still in wait_for_completion(), the SPI
>> transfer never finished...there's might be a bug in the SPI
>> driver.
>=20
> Okay. It was what I am thinking of. It was like waiting something...
>=20
>=20
>> Never seen it.
>=20
> Arf ! I thought that maybe, it was a bug known that you/someone had
> fixed with new versions.
>=20
>> Debug your SPI driver. Especially the completion of a transfer.
>> Hook up a scope to the SPI lines.
>=20
> Okay. So the spi.c with the wait_for_completion is the spi layer ? My
> problem would not be in this file but in the spi driver (which I do
> not know where it is but I will search it ! ) ?

Maybe there is the same mechanism in the spi driver, too.

>> Updating the Kernel is always a good idea. Use latest v3.7-rc or
>> newer if updating.
>=20
> Okay ! This was something that I propose to my company. I will maybe
> try directly to update the kernel (so the driver too) ! I will let
> you know if I find why it is happening.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig99FA86A042C21FBA83B50087
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDAqgMACgkQjTAFq1RaXHMC1wCfaRfXkdFQnOANOhPMqRx237c4
YdkAn3aLtV6m2dAFsOkz4US1/w5QXt6V
=bw9L
-----END PGP SIGNATURE-----

--------------enig99FA86A042C21FBA83B50087--
