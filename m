From: Michael Muldoon <mbmuldoon07@gmail.com>
Subject: Re: can acknowledgment
Date: Thu, 5 Sep 2013 15:47:23 -0400
Message-ID: <CAJU5jU+4n=DhqZyGCNix=k1cA8Bbm9+DJx=qy-7Tssvuz_5e-g@mail.gmail.com>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
	<11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
	<CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
	<818b112277dbc87b883edf93f165ecff@grandegger.com>
	<CAJU5jULyMTQYRuaJ2UMgONaGtm8CPfdW4-u1Dtx59ndzUNC=Zw@mail.gmail.com>
	<6aada00421e51a3bffc2e4354e6fbb34@grandegger.com>
	<CAJU5jULo5Lu1Qbe2Qibr78OZuAMhyD=bD+vP+xrXERV2ZeN-2A@mail.gmail.com>
	<430e94b292fb21c91a1f128f83bb8ad3@grandegger.com>
	<CAJU5jULTsLvi4BrB5kuKC7QGVeUjTKY4ad_UA7sJ9aoXNax__g@mail.gmail.com>
	<57acf912689fb58466cb5aaac1993a59@grandegger.com>
	<CAJU5jU+F6t+WSLnsF8j7V2v9WBW+BVqQFf=00E2469RybocjzA@mail.gmail.com>
	<5228DA82.4050203@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:40298 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab3IETrY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Sep 2013 15:47:24 -0400
Received: by mail-wi0-f180.google.com with SMTP id hj3so16787wib.1
        for <linux-can@vger.kernel.org>; Thu, 05 Sep 2013 12:47:23 -0700 (PDT)
In-Reply-To: <5228DA82.4050203@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

And the hardware is mcp2515

On Thu, Sep 5, 2013 at 3:24 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On 09/05/2013 07:17 PM, Michael Muldoon wrote:
>> Linux version 3.2.20 (tomh@turbo_tom) (gcc version 4.5.3 (Buildroot
>> 2012.05) ) and no I didn't do it myself it came setup.
>
> Well, not that old but a few issues have been fixed in the meantime. Any
> chance to switch to a more recent kernel version?
>
> What hardware do you use? MCP2510 or MCP2515? Could you show the boot
> log (output of "dmesg)?
>
> Wolfgang,
>
>>
>> On Thu, Sep 5, 2013 at 11:55 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>> On Thu, 5 Sep 2013 11:33:19 -0400, Michael Muldoon <mbmuldoon07@gmail.com>
>>> wrote:
>>>> So I noticed that the can state is always UNKNOWN or DOWN could this
>>>> be the problem?
>>>> can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN
>>>> mode DEFAULT qlen 10
>>>>     link/can
>>>>     can state BUS-OFF restart-ms 100
>>>>     bitrate 125000 sample-point 0.875
>>>>     tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>>>>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
>>>>     clock 10000000
>>>>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>>>>     0          0          0          327        327        0
>>>>     RX: bytes  packets  errors  dropped overrun mcast
>>>>     84592      10574    0       0       0       0
>>>>     TX: bytes  packets  errors  dropped carrier collsns
>>>>     0          0        0       0       0       0
>>>> When I tried "# ip link set can0 type can reastart" can0 was definitely
>>> on.
>>>
>>> Just to be sure: s/reastart/restart/
>>>
>>>> I tried change the settings you suggested still no changes.
>>>
>>> OK, what kernel version and distribution do you use?
>>> Did you do the mc251x platform setup yourself?
>>>
>>> Wolfgang.
>>
>>
>
