From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Problems PEAK CAN SJA1000 CAN interface
Date: Mon, 7 Nov 2016 15:25:30 +0100
Message-ID: <d3e56e77-15c7-750e-f7cb-83011fe768a4@grandegger.com>
References: <CAPO0vctcyJMMVJ7BvhGYum+BzbhJ4vK+LM2fPPbVC_S-o=L9Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.151]:51134 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbcKGOsx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Nov 2016 09:48:53 -0500
In-Reply-To: <CAPO0vctcyJMMVJ7BvhGYum+BzbhJ4vK+LM2fPPbVC_S-o=L9Ag@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rein Appeldoorn <reinappeldoorn@gmail.com>, linux-can@vger.kernel.org

Hello,

Am 07.11.2016 um 15:15 schrieb Rein Appeldoorn:
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

What does "ip -d -s link show can0" report?

Wolfgang.
