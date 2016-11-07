From: Rein Appeldoorn <reinappeldoorn@gmail.com>
Subject: Re: Problems PEAK CAN SJA1000 CAN interface
Date: Mon, 7 Nov 2016 15:40:53 +0100
Message-ID: <CAPO0vcuV1eVSsPfWxsgXKT36D0ZswR=wBL6mhyE+uF4T7T_smQ@mail.gmail.com>
References: <CAPO0vctcyJMMVJ7BvhGYum+BzbhJ4vK+LM2fPPbVC_S-o=L9Ag@mail.gmail.com>
 <CALw8SCU6ZRKAbtyfnJ_SELyRnewfUWy0bYamFn-hn_xuYZ8U6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38719 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbcKGPkE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Nov 2016 10:40:04 -0500
Received: by mail-wm0-f52.google.com with SMTP id f82so126209473wmf.1
        for <linux-can@vger.kernel.org>; Mon, 07 Nov 2016 07:39:16 -0800 (PST)
In-Reply-To: <CALw8SCU6ZRKAbtyfnJ_SELyRnewfUWy0bYamFn-hn_xuYZ8U6w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Mirza, Wolfgang,

Thanks for your quick replies. This is the output of the command:

$ip -d -s link show can0

link/can  promiscuity 0

    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0

                  bitrate 500000 sample-point 0.875

                  tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1

                  sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1

                  clock 8000000

                  re-started bus-errors arbit-lost error-warn error-pass bus-off

                  0          0          0          0          0
  0

    RX: bytes  packets  errors  dropped overrun mcast

    0          0        0       0       0       0

    TX: bytes  packets  errors  dropped carrier collsns

    0          0        0       0       0       0
-Rein


On Mon, Nov 7, 2016 at 3:30 PM, Mirza Krak <mirza.krak@gmail.com> wrote:
> 2016-11-07 15:15 GMT+01:00 Rein Appeldoorn <reinappeldoorn@gmail.com>:
>> Hi all,
>>
>> We have two of these a linux machine:
>>
>> http://www.peak-system.com/PCAN-miniPCIe.285.0.html?&L=1
>>
>> According to http://elinux.org/CAN_Bus , the cards should be
>> supported. They are getting discovered by the kernel and listed in
>> ifconfig
>>
>> $ ifconfig can0
>>
>> can0      Link encap:UNSPEC  HWaddr
>> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>>
>>           UP RUNNING NOARP  MTU:16  Metric:1
>>
>>           RX packets:17386379 errors:0 dropped:3 overruns:0 frame:0
>>
>>           TX packets:0 errors:17386373 dropped:3 overruns:0 carrier:3
>>
>>           collisions:0 txqueuelen:10
>>
>>           RX bytes:139091032 (139.0 MB)  TX bytes:0 (0.0 B)
>>
>>           Interrupt:16
>>
>> And it is possible to bring the interface up:
>>
>> $ ip link set can0 type can bitrate 500000 $ ifconfig can0 up
>>
>> However, candump and cansend do not seem to work. Another thing I
>> noticed is that I have a lot of TX errors.
>>
>> Somebody any ideas? Any help is appreciated!
>
> The output from "ip -d -s link show can0" would be interesting.
>
> What is your physical network setup? How are the CAN busses connected?
>
> My initial though is that you are missing CAN network termination (see
> [1]) or do not have a node that ACKs on the bus.
>
> [1]. http://www.ni.com/white-paper/9759/en/
>
> Best Regards
> Mirza
