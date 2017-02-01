From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: cansend linux system memoryleak
Date: Wed, 1 Feb 2017 19:01:11 +0100
Message-ID: <4bc67515-dfd3-ed7c-4db6-2ee9be0446be@hartkopp.net>
References: <CAJc8+a+Vu794K2wnvpKONQakt3Vn61w2Kdzj0-etYgwWpVvrHQ@mail.gmail.com>
 <ac6c3309-2795-48e9-21b7-093bb81379a6@hartkopp.net>
 <CAJc8+aJmsjhrWXQYE7+6KC2oCZk9+ZKtHHSKDvCG426YSM35Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:14552 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbdBASBP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2017 13:01:15 -0500
In-Reply-To: <CAJc8+aJmsjhrWXQYE7+6KC2oCZk9+ZKtHHSKDvCG426YSM35Ng@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: saber mesgary <smesgary@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 02/01/2017 08:25 AM, saber mesgary wrote:
> I have an imx28 module that have two can bus, can0 and can1.

Ok.

> I run your code:
>> ip -det link show can0
> and this is the output:
> 
> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
> UNKNOWN mode DEFAULT group default qlen 10
>     link/can  promiscuity 0
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>  bitrate 800000 sample-point 0.800
>  tq 83 prop-seg 5 phase-seg1 6 phase-seg2 3 sjw 1
>  flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>  clock 24000000

Hm. The flexcan is a very mature driver - I doubt there is any memory leak.

> and for your question:
>> Can you send some of the outputs which leads to your assumption?
> I run the cansend command in an infinite loop in terminal

How do you run this command? With a shell script? Can you send the command?

Can you check whether you see the same behavior when using cangen instead?

> and I watch
> the memory in top command. it is like this:
> 
> Mem: 31020K used, 92712K free, 216K shrd, 0K buff, 10816K cached
> 
> and I see the used memory increase to about 110mb and free memory
> decrease to about 7mb

This could be anything userspace related stuff - e.g. loading some shared library.

I don't think it's a CAN related memory leak.

> and the system reset.

To be clear: The system resets on its own when you start your cansend command?

Regards,
Oliver

