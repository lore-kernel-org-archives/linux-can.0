From: Mirza Krak <mirza.krak@gmail.com>
Subject: Re: Problems PEAK CAN SJA1000 CAN interface
Date: Mon, 7 Nov 2016 16:06:26 +0100
Message-ID: <CALw8SCUx+c2kif+7OTUPLCbpp6_f+7T+dvjBRYUJ2e+b2B7f7w@mail.gmail.com>
References: <CAPO0vctcyJMMVJ7BvhGYum+BzbhJ4vK+LM2fPPbVC_S-o=L9Ag@mail.gmail.com>
 <CALw8SCU6ZRKAbtyfnJ_SELyRnewfUWy0bYamFn-hn_xuYZ8U6w@mail.gmail.com> <CAPO0vcuV1eVSsPfWxsgXKT36D0ZswR=wBL6mhyE+uF4T7T_smQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36706 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbcKGPGz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Nov 2016 10:06:55 -0500
Received: by mail-qk0-f175.google.com with SMTP id n21so68342263qka.3
        for <linux-can@vger.kernel.org>; Mon, 07 Nov 2016 07:06:27 -0800 (PST)
In-Reply-To: <CAPO0vcuV1eVSsPfWxsgXKT36D0ZswR=wBL6mhyE+uF4T7T_smQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rein Appeldoorn <reinappeldoorn@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

2016-11-07 15:40 GMT+01:00 Rein Appeldoorn <reinappeldoorn@gmail.com>:
> Hi Mirza, Wolfgang,
>
> Thanks for your quick replies. This is the output of the command:
>
> $ip -d -s link show can0
>
> link/can  promiscuity 0
>
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>
>                   bitrate 500000 sample-point 0.875
>
>                   tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>
>                   sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>
>                   clock 8000000
>
>                   re-started bus-errors arbit-lost error-warn error-pass bus-off
>
>                   0          0          0          0          0
>   0
>
>     RX: bytes  packets  errors  dropped overrun mcast
>
>     0          0        0       0       0       0
>
>     TX: bytes  packets  errors  dropped carrier collsns
>
>     0          0        0       0       0       0
> -Rein
>

Above only shows that you the device is configured and that there has
not been any network activity.

If you are attempting to send data that please run a "cansend" or
similar and then "ip -d -s link show can0".

Best Regards
Mirza
