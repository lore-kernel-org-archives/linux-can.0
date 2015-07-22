From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Wed, 22 Jul 2015 10:57:22 +0200
Message-ID: <55AF5AF2.6050905@pengutronix.de>
References: <559D35CA.2050402@uweschneider.de> <2576741.YrBIndJIHB@ws-stein>
 <CAOpc7mEc+kr=Es34772fcTnsQpJsaCaoVOx67AhfRjxucPhAhw@mail.gmail.com>
 <3634451.aFQ5B85Yzk@ws-stein>
 <CAOpc7mG52ni5ESuijv1qVLpMznZXSxxU8gmkhjGqtKZfXuxUNQ@mail.gmail.com>
 <55AF4D9D.8040904@uweschneider.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4m0Tgq820dFgKAoBbsAEsVoatLrMqSS5D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38368 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063AbbGVI5a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jul 2015 04:57:30 -0400
In-Reply-To: <55AF4D9D.8040904@uweschneider.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Torsten Lang <torsten.lang@uweschneider.de>
Cc: Holger Schurig <holgerschurig@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4m0Tgq820dFgKAoBbsAEsVoatLrMqSS5D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/22/2015 10:00 AM, Torsten Lang wrote:
> Am 09.07.2015 um 09:59 schrieb Holger Schurig:
>>> The early parts (ColdFire) have 16 buffers, didn't have "Message Queu=
eing" or the FIFO, so aren't supported by Linux at all.
>> Fine, so we can ignore them :-)
> That would be one more reason to at least have an option for working wi=
thout the hardware FIFO.
>>
>>> Is it "normal" to have interrupts locked out for more than 300us (six=
 50us CAN messages at 1MHz)?
>> Unfortunately yes.  My $CUSTOMER had overruns with 500 kB/s, 80% bus
>> load, and CAN messages with 3 bytes of data. My guess this was mostly
>> due to the sucky SDHCI (eMMC) driver code in Linux. I fixed that, but
>> occassionally ftrace still shows large times with irqsoff, I need to
>> dig into them as well. Still /me thinks that an RxFIFO of just 6 CAN
>> messages isn't swell for an OS that is known to not guarantee response=

>> times, like Linux. Especially not for CAN, people use it after all
>> because of it's reliability guarantees.
> I've done some tests with FTRACE, same result. The trace results show t=
hat the SDHCI driver executes long sequences of code under spinlock_irqsa=
ve. As far as I can see from the trace, sdhci_do_set_ios first locks the =
interrupts, then activates the clock, does the operation and deactivates =
the clock again. The actual busy looping appears in the IMX SD/MMC driver=
 which is waiting after every clock change. Turning off CONFIG_MMC_CLKGAT=
E doesn't help here. Even when these busy waits would be avoided there st=
ill would be ~100us of operations under spinlock_irqsave.

IIRC you can insert a SD/MMC/eMMC and mark it as non removable in the DT
to work around the problem - connecting the Card Detection pin might
also work.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4m0Tgq820dFgKAoBbsAEsVoatLrMqSS5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVr1rzAAoJEP5prqPJtc/H74EIAL/uXUIO73CfCkURdq2glfE2
GmrtEzb/m4jjpuvRFrYM9kgWP46TN7v4jNnK9pANG5oHOSyWbfFKBpzSdvQwOEkl
POPhc+UK48QeK0si/mS4NaGDpIF6ehPEL9Q9EDOvPzwRY1TH6sTK5X5P9f8CF2vF
kUrND7iTJPvoYQEZma7jgeV/myo1l3Ihx7MSbzejeLR7upspB0qE5jCsBJ1+6LJT
5kIb5sbISUG7aM5pOQDjH6n+/Wk3IaY5d1kydQAJYYRUwdkgWqZjNY6JjXI2rKhd
C7cWKD1GuoqygqJqYe3ZA3gRKmc0u6m+o9828tlArrZOTVK960q6udbsYCANy70=
=89Ny
-----END PGP SIGNATURE-----

--4m0Tgq820dFgKAoBbsAEsVoatLrMqSS5D--
