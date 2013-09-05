From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: can acknowledgment
Date: Thu, 05 Sep 2013 17:15:55 +0200
Message-ID: <430e94b292fb21c91a1f128f83bb8ad3@grandegger.com>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
 <11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
 <CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
 <818b112277dbc87b883edf93f165ecff@grandegger.com>
 <CAJU5jULyMTQYRuaJ2UMgONaGtm8CPfdW4-u1Dtx59ndzUNC=Zw@mail.gmail.com>
 <6aada00421e51a3bffc2e4354e6fbb34@grandegger.com>
 <CAJU5jULo5Lu1Qbe2Qibr78OZuAMhyD=bD+vP+xrXERV2ZeN-2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:54960 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752250Ab3IEPP6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Sep 2013 11:15:58 -0400
In-Reply-To: <CAJU5jULo5Lu1Qbe2Qibr78OZuAMhyD=bD+vP+xrXERV2ZeN-2A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Muldoon <mbmuldoon07@gmail.com>
Cc: "Aiken, Scott" <Scott.Aiken@karlstorz.com>, linux-can@vger.kernel.org

On Thu, 5 Sep 2013 10:10:50 -0400, Michael Muldoon <mbmuldoon07@gmail.com>

wrote:

> None of the devices are in listen only mode.  The can network is

> properly terminated the other two devices are a pcan and a intrepid

> fire which both show can traffic in their monitoring software.  When I

> attempt  "# ip link set can0 type can restart" I receive the message

> "RTNETLINK answers: Invalid argument". I ran it at 125Kb everything



Was the device in bus-off state when you issued the command?



> was the same it can view messages as long as there are two other

> devices on the network it can't send.



Why did you enable TRIPLE-SAMPLING. It's unusual to use it. Try to disable

it.

You could also try adding "sjw 3" when you configure the device (with ip).



Wolfgang.



> 

> 

> 

> On Thu, Sep 5, 2013 at 9:45 AM, Wolfgang Grandegger <wg@grandegger.com>

> wrote:

>> On Thu, 5 Sep 2013 08:47:44 -0400, Michael Muldoon

>> <mbmuldoon07@gmail.com>

>> wrote:

>>> Before doing anything

>>> can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN

>>> mode DEFAULT qlen 10

>>>     link/can

>>>     can <TRIPLE-SAMPLING> state ERROR-ACTIVE restart-ms 0

>>>     bitrate 500000 sample-point 0.850

>>>     tq 100 prop-seg 8 phase-seg1 8 phase-seg2 3 sjw 1

>>>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1

>>>     clock 10000000

>>>

>>> candump works fine as long as there are two other devices on the

>>> network if just one there is nothing.

>>

>> Is the remaining "one" in listen-only mode?

>>

>>> after attempting to send a can message:

>>> can0: <NO-CARRIER,NOARP,UP,ECHO> mtu 16 qdisc pfifo_fast state DOWN

>>> mode DEFAULT qlen 10

>>>     link/can

>>>     can <TRIPLE-SAMPLING> state BUS-OFF restart-ms 0

>>

>> Well, you entered BUS_OFF!!! You need first recover using:

>>

>>   # ip link set can0 type can restart

>>

>> See

>> http://lxr.linux.no/#linux+v3.11/Documentation/networking/can.txt#L882.

>>

>> This means that there are electical problems on the CAN bus. Is it

>> properly

>> terminated on both ends?

>>

>>>     bitrate 500000 sample-point 0.850

>>>     tq 100 prop-seg 8 phase-seg1 8 phase-seg2 3 sjw 1

>>>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1

>>>     clock 10000000

>>>     re-started bus-errors arbit-lost error-warn error-pass bus-off

>>>     0          0          0          1          1          1

>>>     RX: bytes  packets  errors  dropped overrun mcast

>>>     101600     12700    0       0       0       0

>>>     TX: bytes  packets  errors  dropped carrier collsns

>>>     0          0        0       0       0       0

>>> if restart-ms is set it doesn't go down after sending a can message.

>>

>> What do you mean? It will recover from bus-off after 1ms automatically.

>>

>>> Also the device I' using is a Janus-RC intelligent terminus using busy

>>> box if you guys know anything about it and has two can networks and it

>>> is exactly the same for both so I don't know if that means it could

>>> still be a CAN_TX pin problem or not.

>>

>> I don't think so but there are other electrical problem otherwise the

>> device

>> would not go bus-off. Does it work better at 125KB?

>>

>> Wolfgang.

>>

> --

> To unsubscribe from this list: send the line "unsubscribe linux-can" in

> the body of a message to majordomo@vger.kernel.org

> More majordomo info at  http://vger.kernel.org/majordomo-info.html
