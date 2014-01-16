From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: Kvazer USB CAN driver
Date: Thu, 16 Jan 2014 12:02:04 +0100
Message-ID: <20140116110204.GA5286@hposo>
References: <a8d74bed340445f081325afedf044bb5@AMSPR06MB053.eurprd06.prod.outlook.com>
 <1389107792.5708.9.camel@blackbox>
 <85d7d20e09a64996a182e491c6d250e0@AMSPR06MB053.eurprd06.prod.outlook.com>
 <52CDC307.1020102@hartkopp.net>
 <64b7875c88bc4d9c914241f2fac0d448@AMSPR06MB053.eurprd06.prod.outlook.com>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61258 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbaAPLCf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 06:02:35 -0500
Received: by mail-lb0-f177.google.com with SMTP id z5so1722373lbh.8
        for <linux-can@vger.kernel.org>; Thu, 16 Jan 2014 03:02:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <64b7875c88bc4d9c914241f2fac0d448@AMSPR06MB053.eurprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "GARNERO, PIERRE (P.)" <pgarnero@visteon.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Daniel Berglund <db@kvaser.com>

Hello Pierre,

Sorry I didn't see your previous mails...

On Mon, Jan 13, 2014 at 09:31:55AM +0000, GARNERO, PIERRE (P.) wrote:
> Hello Olivier,
>=20
> I think I understand why this is not working.
>=20
> I have looked at the Kvaser drivers on USB and, basically, there are =
2 big families:
> =E2=80=A2	Leaf
> =E2=80=A2	USBII
>=20
> As far as I understand the current netdriver implements the Leaf fami=
ly only.

Indeed.

>=20
> I could see that all USB =E2=80=9Cproduct ids=E2=80=9D are well ident=
ical than the one defined in Kvaser leaf driver. However usbII devices =
with product ids 2,3,4,5 are not present.
> Effectivelly, le product id tied to my kvaser usbcan Rugged device is=
 "2".

If so, I wonder how you get the kernel panic you mentionned in a previo=
us
mail? I would be interrested in seeing where it crashes.

>=20
> I have tried to look at the differences (from kvaser driver sources) =
and there a lot of discrepencies between the leaf usb commands and the =
usbcan2 (helios?)  usb commands. So, supporting this device should not =
be an easy task....

Indeed the commands sent to hardware looks to be different.
I'll have a look once I found some time...

Kr,

Olivier

>=20
>=20
> Cheers,
>=20
> Pierre
>=20
> -----Message d'origine-----
> De=C2=A0: Oliver Hartkopp [mailto:socketcan@hartkopp.net]=20
> Envoy=C3=A9=C2=A0: mercredi 8 janvier 2014 22:29
> =C3=80=C2=A0: GARNERO, PIERRE (P.)
> Cc=C2=A0: linux-can@vger.kernel.org; Olivier Sobrie; Daniel Berglund
> Objet=C2=A0: Re: Kvazer USB CAN driver
>=20
> Hello Pierre,
>=20
> what exact kernel version are you using there?
>=20
> Do you use the Mainline driver that comes with Linux or did you use t=
he Kvaser driver from http://www.kvaser.com/en/downloads.html ??
>=20
> Can you provide a crash dump?
>=20
> I also added the Kvaser authors in CC
>=20
> Regards,
> Oliver
>=20
> On 07.01.2014 17:46, GARNERO, PIERRE (P.) wrote:
> > Hello,
> >=20
> > Thanks for all this information. And, basically the issue is the fa=
ct that no can network interface shows up.
> >=20
> > If I boot with the Kvaser device plugged, I could well see it using=
:
> >  Lsusb
> >=20
> > ...but
> >  sudo ip link list
> > ...does not reveal any can interface while I have loaded these modu=
les: can, can-raw, can-dev, kvaser-usb.
> > ...while dmesg displays "usbcore: registered new interface driver k=
vaser_usb"...
> >=20
> > In addition, if I hotplug Kvaser device, I get a kernel panic.
> >=20
> > So, I have probably made a mistake when I have built the kernel.
> >=20
> > Cheers,
> >=20
> > Pierre
> >=20
> > =20
> > -----Message d'origine-----
> > De : socketcan-users-bounces@lists.berlios.de [mailto:socketcan-use=
rs-bounces@lists.berlios.de] De la part de Max S.
> > Envoy=C3=A9 : mardi 7 janvier 2014 16:17
> > =C3=80 : socketcan-users@lists.berlios.de
> > Objet : Re: [Socketcan-users] Beginner question - Kvazer USB CAN=20
> > driver
> >=20
> > Hello,
> >=20
> > I'm not sure about the kvaser in particular, but the driver should =
create the network interfaces when the USB device is attached.
> >=20
> > so no need to add a new socketcan device.
> >=20
> > Check to make sure you have kvaser connected:
> > 	lsusb
> >=20
> > Check to make sure kvaser driver has made network interfaces:
> > 	sudo ip link list
> >=20
> > Then bring the interface up:
> > 	sudo ip link set can0 up type can bitrate 250000
> >=20
> > Listen to some frames:
> > 	candump can0
> >=20
> > Depending on how you have permissions set up you will require sudo =
to use most of the ip commands.
> >=20
> > Regards,
> > Max Schneider
> >=20
> > On Tue, 2014-01-07 at 14:17 +0000, GARNERO, PIERRE (P.) wrote:
> >> Hello.
> >>
> >> =20
> >>
> >> I would like to use a KVAZER USBcan Rugged device with the socketc=
an=20
> >> library.
> >>
> >> I use Raspbian OS and I have built a kernel with anything enabled=20
> >> regarding CAN.
> >>
> >> =20
> >>
> >> I have loaded the following modules:
> >>
> >> # modprobe can
> >>
> >> # modprobe vcan
> >>
> >> # modprobe can-raw
> >>
> >> # modprobe can-dev
> >>
> >> # modprobe kvazer-usb
> >>
> >> =20
> >>
> >> But any ip link command (ex: ip link add dev can0 type can) failed=
=20
> >> with =E2=80=9CRTNETLINK answer : operation not permitted=E2=80=9D =
(excepted for vcan=20
> >> which works well).
> >>
> >> =20
> >>
> >> Could someone provide me some hints regarding the steps to have a=20
> >> Kvaser USBcan device up and running using the net driver ?
> >>
> >> =20
> >>
> >> Many thanks in advance,
> >>
> >> =20
> >>
> >> Pierre
> >>
> >> =20
> >>
> >> =20
> >>
> >> =20
> >>
> >> =20
> >>
> >> =20
> >>
> >>
> >> _______________________________________________
> >> Socketcan-users mailing list
> >> Socketcan-users@lists.berlios.de
> >> https://lists.berlios.de/mailman/listinfo/socketcan-users
> >=20
> >=20
> > _______________________________________________
> > Socketcan-users mailing list
> > Socketcan-users@lists.berlios.de
> > https://lists.berlios.de/mailman/listinfo/socketcan-users
> > _______________________________________________
> > Socketcan-users mailing list
> > Socketcan-users@lists.berlios.de
> > https://lists.berlios.de/mailman/listinfo/socketcan-users
> >=20

--=20
Olivier
