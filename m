From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Kvazer USB CAN driver
Date: Wed, 08 Jan 2014 22:28:39 +0100
Message-ID: <52CDC307.1020102@hartkopp.net>
References: <a8d74bed340445f081325afedf044bb5@AMSPR06MB053.eurprd06.prod.outlook.com> <1389107792.5708.9.camel@blackbox> <85d7d20e09a64996a182e491c6d250e0@AMSPR06MB053.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:8273 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757320AbaAHV2p (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 Jan 2014 16:28:45 -0500
In-Reply-To: <85d7d20e09a64996a182e491c6d250e0@AMSPR06MB053.eurprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "GARNERO, PIERRE (P.)" <pgarnero@visteon.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>, Daniel Berglund <db@kvaser.com>

Hello Pierre,

what exact kernel version are you using there?

Do you use the Mainline driver that comes with Linux or did you use the=
 Kvaser
driver from http://www.kvaser.com/en/downloads.html ??

Can you provide a crash dump?

I also added the Kvaser authors in CC

Regards,
Oliver

On 07.01.2014 17:46, GARNERO, PIERRE (P.) wrote:
> Hello,
>=20
> Thanks for all this information. And, basically the issue is the fact=
 that no can network interface shows up.
>=20
> If I boot with the Kvaser device plugged, I could well see it using:
>  Lsusb
>=20
> ...but=20
>  sudo ip link list
> ...does not reveal any can interface while I have loaded these module=
s: can, can-raw, can-dev, kvaser-usb.
> ...while dmesg displays "usbcore: registered new interface driver kva=
ser_usb"...
>=20
> In addition, if I hotplug Kvaser device, I get a kernel panic.
>=20
> So, I have probably made a mistake when I have built the kernel.
>=20
> Cheers,
>=20
> Pierre=20
>=20
> =20
> -----Message d'origine-----
> De : socketcan-users-bounces@lists.berlios.de [mailto:socketcan-users=
-bounces@lists.berlios.de] De la part de Max S.
> Envoy=C3=A9 : mardi 7 janvier 2014 16:17
> =C3=80 : socketcan-users@lists.berlios.de
> Objet : Re: [Socketcan-users] Beginner question - Kvazer USB CAN driv=
er
>=20
> Hello,
>=20
> I'm not sure about the kvaser in particular, but the driver should cr=
eate the network interfaces when the USB device is attached.
>=20
> so no need to add a new socketcan device.
>=20
> Check to make sure you have kvaser connected:
> 	lsusb
>=20
> Check to make sure kvaser driver has made network interfaces:
> 	sudo ip link list
>=20
> Then bring the interface up:
> 	sudo ip link set can0 up type can bitrate 250000
>=20
> Listen to some frames:
> 	candump can0
>=20
> Depending on how you have permissions set up you will require sudo to=
 use most of the ip commands.
>=20
> Regards,
> Max Schneider
>=20
> On Tue, 2014-01-07 at 14:17 +0000, GARNERO, PIERRE (P.) wrote:
>> Hello.
>>
>> =20
>>
>> I would like to use a KVAZER USBcan Rugged device with the socketcan=
=20
>> library.
>>
>> I use Raspbian OS and I have built a kernel with anything enabled=20
>> regarding CAN.
>>
>> =20
>>
>> I have loaded the following modules:
>>
>> # modprobe can
>>
>> # modprobe vcan
>>
>> # modprobe can-raw
>>
>> # modprobe can-dev
>>
>> # modprobe kvazer-usb
>>
>> =20
>>
>> But any ip link command (ex: ip link add dev can0 type can) failed=20
>> with =E2=80=9CRTNETLINK answer : operation not permitted=E2=80=9D (e=
xcepted for vcan=20
>> which works well).
>>
>> =20
>>
>> Could someone provide me some hints regarding the steps to have a=20
>> Kvaser USBcan device up and running using the net driver ?
>>
>> =20
>>
>> Many thanks in advance,
>>
>> =20
>>
>> Pierre
>>
>> =20
>>
>> =20
>>
>> =20
>>
>> =20
>>
>> =20
>>
>>
>> _______________________________________________
>> Socketcan-users mailing list
>> Socketcan-users@lists.berlios.de
>> https://lists.berlios.de/mailman/listinfo/socketcan-users
>=20
>=20
> _______________________________________________
> Socketcan-users mailing list
> Socketcan-users@lists.berlios.de
> https://lists.berlios.de/mailman/listinfo/socketcan-users
> _______________________________________________
> Socketcan-users mailing list
> Socketcan-users@lists.berlios.de
> https://lists.berlios.de/mailman/listinfo/socketcan-users
>=20
