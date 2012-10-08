From: Steffen Rose <ro@emtas.de>
Subject: unsure - socketCAN blocking
Date: Mon, 08 Oct 2012 12:16:40 +0200
Message-ID: <6309304.MqJsLKDGaO@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64917 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab2JHKQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Oct 2012 06:16:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 50D3B5636ED
	for <linux-can@vger.kernel.org>; Mon,  8 Oct 2012 12:16:43 +0200 (CEST)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P96jaK13o0kV for <linux-can@vger.kernel.org>;
	Mon,  8 Oct 2012 12:16:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id D789E563704
	for <linux-can@vger.kernel.org>; Mon,  8 Oct 2012 12:16:42 +0200 (CEST)
Received: from lisa.localnet (lisa.emtas.de [192.168.3.54])
	by kolab.emtas.de (Postfix) with ESMTPS id A1DBC5636ED
	for <linux-can@vger.kernel.org>; Mon,  8 Oct 2012 12:16:42 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,=20
I'm unsure, what I see.

I use:
Virtual box - Host Win 7/Guest kubuntu=20
Linux lisa 3.2.0-30-generic #48-Ubuntu SMP Fri Aug 24 16:52:48 UTC 2012=
 x86_64=20
x86_64 x86_64 GNU/Linux

SocketCAN connector is a EMS CPC-USB.

On startup, the network works fine.
In different situation one or both directions (RX/TX) stop it's work.
My Linux program say:

	write: No buffer space available

It's the write to the socketcan device can0.

=46or the current situation the communication stopped in general.

$ ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN=20
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast st=
ate UP=20
qlen 1000
    link/ether 08:00:27:62:24:48 brd ff:ff:ff:ff:ff:ff
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 qlen=20
100
    link/can=20

$ cat /proc/net/can/stats

      717 transmitted frames (TXF)
      820 received frames (RXF)
      607 matched frames (RXMF)

       74 % total match ratio (RXMR)
        0 frames/s total tx rate (TXR)
        0 frames/s total rx rate (RXR)

      100 % current match ratio (CRXMR)
        0 frames/s current tx rate (CTXR)
        0 frames/s current rx rate (CRXR)

      100 % max match ratio (MRXMR)
       11 frames/s max tx rate (MTXR)
       20 frames/s max rx rate (MRXR)

        2 current receive list entries (CRCV)
        2 maximum receive list entries (MRCV)

$ ip -det -stat link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 qlen=20
100
    link/can=20
    can state ERROR-ACTIVE restart-ms 0=20
    bitrate 250000 sample-point 0.875=20
    tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    ems_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0        =20
    RX: bytes  packets  errors  dropped overrun mcast  =20
    106        213      0       0       0       0     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    607        607      0       0       0       0     =20

$ ./candump any
say nothing

I'm unsure to interprete the data. I cannot see any mistake.=20

--=20
Mit freundlichen Gr=FC=DFen / Best regards
Steffen Rose

