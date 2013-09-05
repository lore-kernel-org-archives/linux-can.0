From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: can acknowledgment
Date: Thu, 05 Sep 2013 21:24:50 +0200
Message-ID: <5228DA82.4050203@grandegger.com>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com> <11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp> <CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com> <818b112277dbc87b883edf93f165ecff@grandegger.com> <CAJU5jULyMTQYRuaJ2UMgONaGtm8CPfdW4-u1Dtx59ndzUNC=Zw@mail.gmail.com> <6aada00421e51a3bffc2e4354e6fbb34@grandegger.com> <CAJU5jULo5Lu1Qbe2Qibr78OZuAMhyD=bD+vP+xrXERV2ZeN-2A@mail.gmail.com> <430e94b292fb21c91a1f128f83bb8ad3@grandegger.com> <CAJU5jULTsLvi4BrB5kuKC7QGVeUjTKY4ad_UA7sJ9aoXNax__g@mail.gmail.com> <57acf912689fb58466cb5aaac1993a59@grandegger.com> <CAJU5jU+F6t+WSLnsF8j7V2v9WBW+BVqQFf=00E2469RybocjzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44111 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab3IETYy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Sep 2013 15:24:54 -0400
In-Reply-To: <CAJU5jU+F6t+WSLnsF8j7V2v9WBW+BVqQFf=00E2469RybocjzA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Muldoon <mbmuldoon07@gmail.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

On 09/05/2013 07:17 PM, Michael Muldoon wrote:
> Linux version 3.2.20 (tomh@turbo_tom) (gcc version 4.5.3 (Buildroot
> 2012.05) ) and no I didn't do it myself it came setup.

Well, not that old but a few issues have been fixed in the meantime. Any
chance to switch to a more recent kernel version?

What hardware do you use? MCP2510 or MCP2515? Could you show the boot
log (output of "dmesg)?

Wolfgang,

> 
> On Thu, Sep 5, 2013 at 11:55 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> On Thu, 5 Sep 2013 11:33:19 -0400, Michael Muldoon <mbmuldoon07@gmail.com>
>> wrote:
>>> So I noticed that the can state is always UNKNOWN or DOWN could this
>>> be the problem?
>>> can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN
>>> mode DEFAULT qlen 10
>>>     link/can
>>>     can state BUS-OFF restart-ms 100
>>>     bitrate 125000 sample-point 0.875
>>>     tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>>>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
>>>     clock 10000000
>>>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>>>     0          0          0          327        327        0
>>>     RX: bytes  packets  errors  dropped overrun mcast
>>>     84592      10574    0       0       0       0
>>>     TX: bytes  packets  errors  dropped carrier collsns
>>>     0          0        0       0       0       0
>>> When I tried "# ip link set can0 type can reastart" can0 was definitely
>> on.
>>
>> Just to be sure: s/reastart/restart/
>>
>>> I tried change the settings you suggested still no changes.
>>
>> OK, what kernel version and distribution do you use?
>> Did you do the mc251x platform setup yourself?
>>
>> Wolfgang.
> 
> 

