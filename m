From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 3/3] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN
 controller
Date: Fri, 03 Aug 2012 21:09:25 +0200
Message-ID: <501C21E5.9080106@pengutronix.de>
References: <1343913191-14722-1-git-send-email-anilkumar@ti.com> <1343913191-14722-4-git-send-email-anilkumar@ti.com> <79CD15C6BA57404B839C016229A409A83EA7F150@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig06AFB5DFAF6BDBF027AD5AF2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48933 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab2HCTJo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Aug 2012 15:09:44 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA7F150@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Gole, Anant" <anantgole@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig06AFB5DFAF6BDBF027AD5AF2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/03/2012 08:32 AM, Hiremath, Vaibhav wrote:
> On Thu, Aug 02, 2012 at 18:43:11, AnilKumar, Chimata wrote:
>> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
>> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
>> register of C_CAN/D_CAN IP when clock is turned off.
>>
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> ---
>>  drivers/net/can/c_can/c_can_platform.c |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/=
c_can/c_can_platform.c
>> index d0a66cf..83a1e17 100644
>> --- a/drivers/net/can/c_can/c_can_platform.c
>> +++ b/drivers/net/can/c_can/c_can_platform.c
>> @@ -32,6 +32,7 @@
>>  #include <linux/clk.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/pm_runtime.h>
>> =20
>>  #include <linux/can/dev.h>
>> =20
>> @@ -177,6 +178,9 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>>  		goto exit_free_device;
>>  	}
>> =20
>> +	pm_runtime_enable(&pdev->dev);
>> +	pm_runtime_get_sync(&pdev->dev);
>> +
>=20
> If module is inserted or built into the kernel, module stays in enabled=
=20
> state always, isn't that wrong?
> Ideally, you should enable the module when it is required or being used=
=2E

Good point.

If you don't access the module's registers in the probe- (or its
subroutines) it should be enough to enable the module in the open()
function. Have a look at clk_prepare_enable / clk_disable_unprepare in
the flexcan driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig06AFB5DFAF6BDBF027AD5AF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAcIekACgkQjTAFq1RaXHNSFwCfdR+CAddUCFCxosRzNC2Jbt8C
QYsAoIi+2Ooi+2fMa7eIAs5mqU5bMs4l
=36ot
-----END PGP SIGNATURE-----

--------------enig06AFB5DFAF6BDBF027AD5AF2--
