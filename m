From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: Web GUI for can-utils (i.e. cangw, cansend, candump)
Date: Mon, 10 Jun 2013 18:30:28 +0200
Message-ID: <zarafa.51b5ff24.7028.506b738f3f6d3b02@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:36393 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695Ab3FJQaa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 12:30:30 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Oliver_Hartkopp?= <socketcan@hartkopp.net>
Cc: =?utf-8?Q?linux-can_Mailing_List?= <linux-can@vger.kernel.org>

Hello Oliver,

OK!
Thnak you for pointing me to the interestin toolchain with .kcd files (=
CANbabel translator), socketcand and Kayak.
Nevertheless I did some tests last weekend on my BeagleBone Black setup=
 with DCAN0/DCAN1.

If I fire round about 37%@500kbit/s to DCAN0 I get a tast load of round=
 about 45% of socketcand. In general it's possible for me to use Kayak =
on i.e. my Windows machine and connect to my BeagleBone Black via ether=
net. But if I use the second CAN channel (DCAN1) or increase the busloa=
d of channel one (DCAN0) the taskload/CPUload increases unacceptable.

Did you have the same experience with socketcand and Kayak?
Why isn't it possible to connect directly to the can0/can1 socketcan in=
terfaces without socketcand?

Regards
Mike

-----Urspr=C3=BCngliche Nachricht-----
Von:	Oliver Hartkopp <socketcan@hartkopp.net>
Gesendet:	Sa 08.06.2013 14:31
Betreff:	Re: Web GUI for can-utils (i.e. cangw, cansend, candump)
An:	Michael Luxen <mluxen@gmx.net>;=20
CC:	linux-can Mailing List <linux-can@vger.kernel.org>;=20
> On 07.06.2013 22:10, Michael Luxen wrote:
>=20
> > I'm looking for a easy solution to make the powerful cangw tool mor=
e=20
> comfortable for endusers (dummy user).
> >=20
> > Therefore I prefer to have a webfrontend / Web GUI to configure the=
 cangw=20
> rules with a webbrowser which is available on each PC/smartphone/etc
> >=20
> > Is there already a configuration tool or best a Web GUI available w=
hich can=20
> i.e.:
> > cangw
> > - Load two Vector .dbc files (one for can0 and one for can1)
>=20
> I would suggest to start with kcd files instead of dbc files, which a=
re Vector
> property.
>=20
> E.g. The JAVA tool Kayak (http://kayak.2codeornot2code.org/) uses the=
 kcd
> format (see: http://kayak.2codeornot2code.org/tutorial.html). There's=
 also a
> kcd converter CANBabel at github: https://github.com/julietkilo/CANBa=
bel
>=20
> > - Select on one side (can0) the input CAN frame which should be rou=
ted from=20
> can0 to can via cagw
> > - Select on the other side (can1) the input CAN fram whcih should b=
e routed=20
> from can1 to can0 via cangw
> > - Manipulate of CAN-frames with some logic operations +/-/*/div to =
use the=20
> modification features of cangw
>=20
> Today there are only AND/OR/XOR/SET defined for CAN frame modificatio=
ns.
>=20
> To modify signals on the fly is a much more complex attempt than doin=
g some
> bit-wise operations. E.g. if you think about +/-/*/div operations: Yo=
u need to
> provide the other operands, you need to extract and shift the data fo=
r
> processing and afterward inject it at the right place (shifting, addi=
ng the
> original information that was not modified, etc).
>=20
> I wonder if this can/should be done in kernel context in a proper man=
ner.
>=20
> > - start cangw
> >=20
> > cansend
> > - load a Vector .dbc file
> > - select a CAN-frame for transmitting
> > - select a CAN-signal to fillin a value to transmit
> > - manipulate the CAN-frames/CAN-signals content/values independent
> > - start cansend for CAN simulation
> >=20
> > candump
> > - configure can interface to monitor/log
> > - start candump -l in background
>=20
> I would suggest to preserve cansend and candump as-is.
>=20
> Especially candump has become pretty complex by today to support all =
the
> CAN_RAW socket options and control information (from CAN FD to dropco=
unters &
> timestamps).
>=20
> Probably some new tools like sigdump and sigsend (signal...) that mak=
e use of
> kcd files are a better option here.
>=20
> But i don't know how this can be adapted to a web-based interface the=
n.
>=20
> Best regards,
> Oliver
>=20
>=20
> >=20
> >=20
> > Environment background:
> > I'm currently using the two internal CAN-Interfaces of the BeagleBo=
ne Black.=20
> They are perfectly working for me with the latest Angstrom or Debian =
images.
> >=20
> > Thanks for any hint or pointing me to the right place!
> >=20
> > Regards
> > Mike
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
>
