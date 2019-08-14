From: "FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)"
        <fixed-term.Konstantin.Buecheler@escrypt.com>
Subject: can: tcan4x5x: spi bits_per_word issue on Raspberry PI
Date: Wed, 14 Aug 2019 15:01:44 +0000
Message-ID: <3f71bdff8f4f4fe19ad9a09be89bc73d@escrypt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: de-DE
Sender: netdev-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

> Hi all,
>=20
> I am trying to use a tcan4550 together with a Raspberry PI 3 B. I am usin=
g the
> tcan4x5x driver from net-next.
> I always get the following error during startup.
> 	tcan4x5x spi0.0: Probe failed, err=3D-22
> 	tcan4x5x: probe of spi0.0 failed with error -22
>=20
> I realized that this happens because the Raspberry PI does only support 8=
/9 bit
> words. https://elinux.org/index.php?title=3DRPi_SPI#Supported_bits_per_wo=
rd
> In the driver it is set to 32.
> 	spi->bits_per_word =3D 32;
>=20
> Setting this to 8 does not help of course since the tcan chip expects a m=
ultiple of
> 32 per spi transaction.
> I don't know if this is a Raspberry Pi specific problem or if there are m=
ore devices
> with this hardware limitation.
>=20
> Does anyone have a workaround for that?

It seems to be enough to just change the bits_per_word value to 8

>=20
> If this a common issue it might be a good idea to patch the driver. I wil=
l check if I
> can find proper a way to do so.
>=20
> Regards,
> Konstantin

Now I have another really confusing problem. Anything I write to SPI is wri=
tten little endian. The tcan chip expects big endian.=20
Anything I read from SPI is treated as little endian but is big endian. Doe=
s anyone know why this happens?=20
Is there a flag or something I can set for the SPI device/wire to fix this?

Regards,
Konstantin
