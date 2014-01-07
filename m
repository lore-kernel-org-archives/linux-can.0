From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re:  Kvazer USB CAN driver
Date: Tue, 07 Jan 2014 15:45:41 +0100
Message-ID: <52CC1315.6060209@hartkopp.net>
References: <a8d74bed340445f081325afedf044bb5@AMSPR06MB053.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:11857 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbaAGOps (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Jan 2014 09:45:48 -0500
In-Reply-To: <a8d74bed340445f081325afedf044bb5@AMSPR06MB053.eurprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "GARNERO, PIERRE (P.)" <pgarnero@visteon.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

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
> But any ip link command (ex: ip link add dev can0 type can) failed wi=
th
> =93RTNETLINK answer : operation not permitted=94 (excepted for vcan w=
hich works well).

When your modprobe succeeded (and the USB adapter is attached) a can0
interface should have been created by the kvaser-usb driver automatical=
ly.

The "ip link add dev can0 type can" is wrong.
You may add virtual CAN devices with this procedure, e.g.
ip link add dev vcan0 type vcan

But you can never create a real CAN interface with the ip tool.

>=20
> Could someone provide me some hints regarding the steps to have a Kva=
ser
> USBcan device up and running using the net driver ?
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

