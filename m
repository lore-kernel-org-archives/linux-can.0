From: Mirza Krak <mirza.krak@gmail.com>
Subject: Re: Problems PEAK CAN SJA1000 CAN interface
Date: Mon, 7 Nov 2016 15:30:57 +0100
Message-ID: <CALw8SCU6ZRKAbtyfnJ_SELyRnewfUWy0bYamFn-hn_xuYZ8U6w@mail.gmail.com>
References: <CAPO0vctcyJMMVJ7BvhGYum+BzbhJ4vK+LM2fPPbVC_S-o=L9Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34645 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753016AbcKGObl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Nov 2016 09:31:41 -0500
Received: by mail-qk0-f177.google.com with SMTP id q130so177897270qke.1
        for <linux-can@vger.kernel.org>; Mon, 07 Nov 2016 06:30:59 -0800 (PST)
In-Reply-To: <CAPO0vctcyJMMVJ7BvhGYum+BzbhJ4vK+LM2fPPbVC_S-o=L9Ag@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rein Appeldoorn <reinappeldoorn@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

2016-11-07 15:15 GMT+01:00 Rein Appeldoorn <reinappeldoorn@gmail.com>:
> Hi all,
>
> We have two of these a linux machine:
>
> http://www.peak-system.com/PCAN-miniPCIe.285.0.html?&L=1
>
> According to http://elinux.org/CAN_Bus , the cards should be
> supported. They are getting discovered by the kernel and listed in
> ifconfig
>
> $ ifconfig can0
>
> can0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>
>           UP RUNNING NOARP  MTU:16  Metric:1
>
>           RX packets:17386379 errors:0 dropped:3 overruns:0 frame:0
>
>           TX packets:0 errors:17386373 dropped:3 overruns:0 carrier:3
>
>           collisions:0 txqueuelen:10
>
>           RX bytes:139091032 (139.0 MB)  TX bytes:0 (0.0 B)
>
>           Interrupt:16
>
> And it is possible to bring the interface up:
>
> $ ip link set can0 type can bitrate 500000 $ ifconfig can0 up
>
> However, candump and cansend do not seem to work. Another thing I
> noticed is that I have a lot of TX errors.
>
> Somebody any ideas? Any help is appreciated!

The output from "ip -d -s link show can0" would be interesting.

What is your physical network setup? How are the CAN busses connected?

My initial though is that you are missing CAN network termination (see
[1]) or do not have a node that ACKs on the bus.

[1]. http://www.ni.com/white-paper/9759/en/

Best Regards
Mirza
