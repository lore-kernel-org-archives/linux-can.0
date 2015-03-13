From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: LEDs: documentation
Date: Fri, 13 Mar 2015 14:01:55 +0100
Message-ID: <CAJ=nTst7-1KeL3tG9BAB-mc9298K6qeHPB4hdX5RWp12jTqs9Q@mail.gmail.com>
References: <CAGm1_ktxocqFvQQ9Mrnk+ravrgpq-+RWw3vN0qsS=Qpa+o3WGA@mail.gmail.com>
	<CAGm1_kuKuFaEyj-JicFfiX=qBjOeNLEzdrCQLLrXxE04OL=2Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:36811 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbbCMNB5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Mar 2015 09:01:57 -0400
Received: by labgd6 with SMTP id gd6so22414816lab.3
        for <linux-can@vger.kernel.org>; Fri, 13 Mar 2015 06:01:55 -0700 (PDT)
In-Reply-To: <CAGm1_kuKuFaEyj-JicFfiX=qBjOeNLEzdrCQLLrXxE04OL=2Kw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, fabio.baltieri@gmail.com

I haven't actually ever tried running events on CAN device but I have
on network devices and it would surprise me if it does not work in the
same way (can is a network interface? :)).

There you can combine events trough the "mode" attribute.

/sys/class/leds/mx4-wifi# ls
brightness      device_name     max_brightness  power           trigger
device          interval        mode            subsystem       uevent

/sys/class/leds/mx4-wifi# cat mode
link tx rx

/sys/class/leds/mx4-wifi# cat trigger
none nand-disk mmc0 [netdev]

/sys/class/leds/mx4-wifi# cat device_name
wlan0

2015-03-12 15:00 GMT+01:00 Yegor Yefremov <yegorslists@googlemail.com>:
> On Thu, Mar 12, 2015 at 10:21 AM, Yegor Yefremov
> <yegorslists@googlemail.com> wrote:
>> I have am335x based system and would like to use LED feature. Where
>> can I find info about CAN LEDs subsystem? How can I configure LEDs v=
ia
>> device tree?
>>
>> So far I couldn't find anything related under
>> Documentation/devicetree/bindings/net/can/ or in
>> Documentation/networking/can.txt.
>
> So I got "can0-tx" running. But I have only one LED, that is called
> "Data" and it just shows activity. It seems like one cannot combine
> two triggers for one LED. Do I see it right? If yes, what about
> creating another event called iface-rxtx or iface-activity like LEDs
> in network interfaces?
>
> What about errors? We have also "Error" LED. The main purpose is to
> indicate "bus off" state.
>
> Yegor
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
