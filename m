From: "FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)"
        <fixed-term.Konstantin.Buecheler@escrypt.com>
Subject: can: tcan4x5x: spi bits_per_word issue on Raspberry PI
Date: Wed, 14 Aug 2019 09:43:21 +0000
Message-ID: <f1e2a3fba8604996b16e11f9405542d1@escrypt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: de-DE
Sender: netdev-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

Hi all,

I am trying to use a tcan4550 together with a Raspberry PI 3 B. I am using =
the tcan4x5x driver from net-next.=20
I always get the following error during startup.
	tcan4x5x spi0.0: Probe failed, err=3D-22
	tcan4x5x: probe of spi0.0 failed with error -22

I realized that this happens because the Raspberry PI does only support 8/9=
 bit words. https://elinux.org/index.php?title=3DRPi_SPI#Supported_bits_per=
_word
In the driver it is set to 32.
	spi->bits_per_word =3D 32;

Setting this to 8 does not help of course since the tcan chip expects a mul=
tiple of 32 per spi transaction.=20
I don't know if this is a Raspberry Pi specific problem or if there are mor=
e devices with this hardware limitation.=20

Does anyone have a workaround for that?=20

If this a common issue it might be a good idea to patch the driver. I will =
check if I can find proper a way to do so.=20

Regards,=20
Konstantin=20
