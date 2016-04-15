From: Julien Pilet <julien@anemomind.com>
Subject: Bad reading from mcp2515 with j1939
Date: Fri, 15 Apr 2016 11:54:40 +0200
Message-ID: <136B5347-DD98-4021-98C5-2FD18FC925A4@anemomind.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:45739 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcDOJz6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Apr 2016 05:55:58 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id A493D47E94B
	for <linux-can@vger.kernel.org>; Fri, 15 Apr 2016 11:55:41 +0200 (CEST)
Received: from [192.168.1.103] (anemomind1.epfl.ch [128.179.67.52])
	(Authenticated sender: julien@anemomind.com)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 69BE5FB8BC
	for <linux-can@vger.kernel.org>; Fri, 15 Apr 2016 11:54:41 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

I am using a MCP2515 for a nautical application. It turns out that in m=
y lab, everything goes fine. On two boats, though, I get strange readin=
gs from can0.

I connected the MCP2515 to a sensor reporting a boat speed of 0 m/s.
  can0  09F50323   [8]  79 00 00 FF FF 00 FF FF

The first data byte is the sequence ID, it is incremented in each packe=
t.
The two following bytes encode the boat speed.

candump gives me the following:

  can0  09F50323   [8]  7A 00 00 FF FF 00 FF FF
  can0  09F50323   [8]  7B 00 00 FF FF 00 FF FF
  can0  09F50323   [8]  7C 00 00 FF FF 00 FF FF
  can0  09F50323   [8]  7D 00 00 FF FF 00 FF FF
  can0  09F50323   [8]  7E 00 00 FF FF 00 FF FF
  can0  09F50323   [8]  7F 00 00 FF FF 00 FF FF
  can0  09F50323   [8]  80 80 00 FF FF 00 FF FF
  can0  09F50323   [8]  81 00 00 FF FF 00 FF FF
  can0  09F50323   [8]  82 80 00 FF FF 00 FF FF
  can0  09F50323   [8]  83 00 00 FF FF 00 FF FF
  can0  09F50323   [8]  84 80 00 FF FF 00 FF FF
  can0  09F50323   [8]  85 00 00 FF FF 00 FF FF
  can0  09F50323   [8]  86 80 00 FF FF 00 FF FF

Suddenly, when SID reaches 0x80, the speed is not 0 anymore: it is 0x00=
80 (encoded little endian 80 00). This is clearly wrong.
I observed similar problems with sensors of different manufacturers, so=
 I do not think the sensor is faulty.=20
The pattern repeats: for seq ID between 00 and 0x79, everything works f=
ine. For seq ID 0x80 - 0xFA (the last seq ID sent) every packet with an=
 even sequence ID has a spurious bit set in the 2nd byte.

I failed to reproduce the error in the lab, so it is hard for me to plu=
g a oscilloscope and observe what is going on. I observe no error when =
transmitting the same data on my test network (which is much shorter an=
d simpler than a real one).

Did I miss something in the configuration ? How is it possible that bad=
 packets pass through?

Here=E2=80=99s how my configuration looks like:

# ifconfig can0
can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00=
-00-00-00-00 =20
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:22823 errors:3 dropped:0 overruns:0 frame:3
          TX packets:7 errors:1 dropped:1 overruns:0 carrier:1
          collisions:0 txqueuelen:10=20
          RX bytes:182584 (178.3 KiB)  TX bytes:31 (31.0 B)

# ./bin/ip -details link show can0
5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 mode DEFAULT qlen 10
    link/can=20
    can <TRIPLE-SAMPLING> state ERROR-PASSIVE restart-ms 0=20
    bitrate 250000 sample-point 0.875=20
    tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    j1939 on

I=E2=80=99m using a 3.10.17 kernel modified by Intel for their Edison m=
odule. I patched it with j1939-v3.10.

Any idea or suggestion would be appreciated!

Thanks,
Julien.