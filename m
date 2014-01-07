From: "GARNERO, PIERRE (P.)" <pgarnero@visteon.com>
Subject: RE:  Kvazer USB CAN driver
Date: Tue, 7 Jan 2014 15:15:51 +0000
Message-ID: <f84eb6f3008148548f8af41287cb725c@AMSPR06MB053.eurprd06.prod.outlook.com>
References: <a8d74bed340445f081325afedf044bb5@AMSPR06MB053.eurprd06.prod.outlook.com>
 <52CC1315.6060209@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3lp0077.outbound.protection.outlook.com ([213.199.154.77]:33595
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752485AbaAGPam convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Jan 2014 10:30:42 -0500
In-Reply-To: <52CC1315.6060209@hartkopp.net>
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Oliver,

Thanks a lot for your answer. I will check if I get a can0 device when =
modules are loaded.

I will register to this new mailing list. I was a little bit reluctant =
initially to post on this mailing list because I thought it was reserve=
d for development discussions.

Have a nice day,

Pierre

-----Message d'origine-----
De=A0: Oliver Hartkopp [mailto:socketcan@hartkopp.net]=20
Envoy=E9=A0: mardi 7 janvier 2014 15:46
=C0=A0: GARNERO, PIERRE (P.)
Cc=A0: linux-can@vger.kernel.org
Objet=A0: Re: Kvazer USB CAN driver

Hello Pierre,

I moved your question to the new linux-can mailing list you should use =
in future.

On 07.01.2014 15:17, GARNERO, PIERRE (P.) wrote:

>=20
> I would like to use a KVAZER USBcan Rugged device with the socketcan =
library.
>=20
> I use Raspbian OS and I have built a kernel with anything enabled reg=
arding CAN.
>=20
> =20
>=20
> I have loaded the following modules:
>=20
> # modprobe can
>=20
> # modprobe vcan
>=20
> # modprobe can-raw
>=20
> # modprobe can-dev
>=20
> # modprobe kvazer-usb
>=20
> =20
>=20
> But any ip link command (ex: ip link add dev can0 type can) failed=20
> with "RTNETLINK answer : operation not permitted" (excepted for vcan =
which works well).

When your modprobe succeeded (and the USB adapter is attached) a can0 i=
nterface should have been created by the kvaser-usb driver automaticall=
y.

The "ip link add dev can0 type can" is wrong.
You may add virtual CAN devices with this procedure, e.g.
ip link add dev vcan0 type vcan

But you can never create a real CAN interface with the ip tool.

>=20
> Could someone provide me some hints regarding the steps to have a=20
> Kvaser USBcan device up and running using the net driver ?
>=20

Once can0 showed up:

e.g. with dmesg | grep can0

or in=20

cat /proc/net/dev

You can set the bitrate and set the interface to up afterwards:

http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tre=
e/Documentation/networking/can.txt?h=3Dlinux-3.12.y#n758

Regards,
Oliver

