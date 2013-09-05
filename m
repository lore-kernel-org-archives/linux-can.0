From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: can acknowledgment
Date: Thu, 05 Sep 2013 15:45:26 +0200
Message-ID: <6aada00421e51a3bffc2e4354e6fbb34@grandegger.com>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
 <11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
 <CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
 <818b112277dbc87b883edf93f165ecff@grandegger.com>
 <CAJU5jULyMTQYRuaJ2UMgONaGtm8CPfdW4-u1Dtx59ndzUNC=Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:37486 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374Ab3IENp2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Sep 2013 09:45:28 -0400
In-Reply-To: <CAJU5jULyMTQYRuaJ2UMgONaGtm8CPfdW4-u1Dtx59ndzUNC=Zw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Muldoon <mbmuldoon07@gmail.com>
Cc: "Aiken, Scott" <Scott.Aiken@karlstorz.com>, linux-can@vger.kernel.org

On Thu, 5 Sep 2013 08:47:44 -0400, Michael Muldoon <mbmuldoon07@gmail.com>

wrote:

> Before doing anything

> can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN

> mode DEFAULT qlen 10

>     link/can

>     can <TRIPLE-SAMPLING> state ERROR-ACTIVE restart-ms 0

>     bitrate 500000 sample-point 0.850

>     tq 100 prop-seg 8 phase-seg1 8 phase-seg2 3 sjw 1

>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1

>     clock 10000000

> 

> candump works fine as long as there are two other devices on the

> network if just one there is nothing.



Is the remaining "one" in listen-only mode?



> after attempting to send a can message:

> can0: <NO-CARRIER,NOARP,UP,ECHO> mtu 16 qdisc pfifo_fast state DOWN

> mode DEFAULT qlen 10

>     link/can

>     can <TRIPLE-SAMPLING> state BUS-OFF restart-ms 0



Well, you entered BUS_OFF!!! You need first recover using:



  # ip link set can0 type can restart



See

http://lxr.linux.no/#linux+v3.11/Documentation/networking/can.txt#L882.



This means that there are electical problems on the CAN bus. Is it

properly

terminated on both ends?



>     bitrate 500000 sample-point 0.850

>     tq 100 prop-seg 8 phase-seg1 8 phase-seg2 3 sjw 1

>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1

>     clock 10000000

>     re-started bus-errors arbit-lost error-warn error-pass bus-off

>     0          0          0          1          1          1

>     RX: bytes  packets  errors  dropped overrun mcast

>     101600     12700    0       0       0       0

>     TX: bytes  packets  errors  dropped carrier collsns

>     0          0        0       0       0       0

> if restart-ms is set it doesn't go down after sending a can message.



What do you mean? It will recover from bus-off after 1ms automatically.



> Also the device I' using is a Janus-RC intelligent terminus using busy

> box if you guys know anything about it and has two can networks and it

> is exactly the same for both so I don't know if that means it could

> still be a CAN_TX pin problem or not.



I don't think so but there are other electrical problem otherwise the

device

would not go bus-off. Does it work better at 125KB?



Wolfgang.


