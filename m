From: <kime@ixxat.de>
Subject: RE: CAN State Information
Date: Fri, 9 Dec 2011 09:03:08 +0100
Message-ID: <166589D0B9DD2547A1319599B9BADA1FC19968@vsv-exchange.ixxat.intranet.priv>
References: <166589D0B9DD2547A1319599B9BADA1FC1960C@vsv-exchange.ixxat.intranet.priv> <4EDE342E.8030102@grandegger.com> <166589D0B9DD2547A1319599B9BADA1FC1981F@vsv-exchange.ixxat.intranet.priv> <4EE10CB4.2090604@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.ixxat.net ([145.253.106.66]:52687 "EHLO mail.ixxat.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab1LIIDM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Dec 2011 03:03:12 -0500
Content-class: urn:content-classes:message
In-Reply-To: <4EE10CB4.2090604@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com
Cc: socketcan-core@lists.berlios.de, linux-can@vger.kernel.org

I plan to spend some time today tracking down the problem.  I am most c=
urious to discover if there is a problem in the msg returned from send_=
dump_request().=20

$ sudo ./canconfig can0 state
can0 state: STOPPED
$ sudo ./canconfig can1 state
can1 state: STOPPED
$ sudo ./canconfig can2 state
can2: failed to get state=20
$ sudo ./canconfig can3 state
can3: failed to get state=20
$ ip -d -s link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN=20
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    RX: bytes  packets  errors  dropped overrun mcast  =20
    500        8        0       0       0       0     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    500        8        0       0       0       0     =20
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast st=
ate UP qlen 1000
    link/ether 00:11:2f:72:cc:4d brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast  =20
    997317     7091     0       0       0       2     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    285592     3799     0       0       0       0     =20
3: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN qlen 10
    link/can=20
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0=20
    bitrate 0 sample-point 0.000=20
    tq 0 prop-seg 0 phase-seg1 0 phase-seg2 0 sjw 0
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0        =20
    RX: bytes  packets  errors  dropped overrun mcast  =20
    0          0        0       0       0       0     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    0          0        0       0       0       0     =20
4: can1: <NOARP,ECHO> mtu 16 qdisc noop state DOWN qlen 10
    link/can=20
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0=20
    bitrate 0 sample-point 0.000=20
    tq 0 prop-seg 0 phase-seg1 0 phase-seg2 0 sjw 0
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0        =20
    RX: bytes  packets  errors  dropped overrun mcast  =20
    0          0        0       0       0       0     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    0          0        0       0       0       0     =20
5: can2: <NOARP,ECHO> mtu 16 qdisc noop state DOWN qlen 10
    link/can=20
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0=20
    bitrate 0 sample-point 0.000=20
    tq 0 prop-seg 0 phase-seg1 0 phase-seg2 0 sjw 0
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0        =20
    RX: bytes  packets  errors  dropped overrun mcast  =20
    0          0        0       0       0       0     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    0          0        0       0       0       0     =20
6: can3: <NOARP,ECHO> mtu 16 qdisc noop state DOWN qlen 10
    link/can=20
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0=20
    bitrate 0 sample-point 0.000=20
    tq 0 prop-seg 0 phase-seg1 0 phase-seg2 0 sjw 0
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0        =20
    RX: bytes  packets  errors  dropped overrun mcast  =20
    0          0        0       0       0       0     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    0          0        0       0       0       0     =20

Mit freundlichen Gr=FCssen / Yours sincerely,

James Kime
Entwicklung / Development
--------------------------------------------
IXXAT Automation GmbH
Leibnizstr. 15, 88250 Weingarten, Germany
Phone +49-751-56146-181
=46ax   +49-751-56146-29
mailto:kime@ixxat.de
http://www.ixxat.de
--------------------------------------------
PRIVILEGED AND CONFIDENTIAL.
Any unauthorized use or disclosure
is strictly prohibited.
--------------------------------------------
Sitz der Gesellschaft: Weingarten
Handelsregister Ulm HRB 551905
Gesch=E4ftsf=FChrer:
Dipl.-Ing. Christian Schlegel
--------------------------------------------

-----Original Message-----
=46rom: Wolfgang Grandegger [mailto:wg@grandegger.com]=20
Sent: Thursday, December 08, 2011 8:15 PM
To: Kime, James
Cc: socketcan-core@lists.berlios.de; linux-can@vger.kernel.org
Subject: Re: CAN State Information

Hello James,

On 12/08/2011 09:43 AM, kime@ixxat.de wrote:
> Hello,
> Thanks for the response.  I am using can_get_state() as part of my st=
art_CAN routine.  After, I call can_do_start(), I read the state to see=
 if I need to do bus-off recovery.  So it is not a frequent call.  I wa=
s able to see the states correctly on all four CAN channels with "ip -d=
 -s link". =20

OK, just to be sure. Does the "canconfig canX state" from the
Pengutronix canutils list the state correctly for any device?
I just tried here and it works fine.

> I updated the code in plx_pci.c to include support for the IXXAT card=
=2E  I wanted to ask you how to submit the changes since I have not don=
e it before.  I attached a patch file.

Nice! A patch should be submitted as *inline* mail to the linux-can
*and* netdev mailing list with a proper subject, patch description and
signed-off-by line. The subject line should be something like:

"[PATCH net-next] can: plx_pci: add support for IXXAT PCI cards"

It's best to use git to create and send the patch but for simple patche=
s
it doesn't really matter.

Wolfgang.
