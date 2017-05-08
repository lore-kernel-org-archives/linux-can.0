From: Mirza Krak <mirza.krak@gmail.com>
Subject: Fwd: CanBus2Ethernet Bridge
Date: Mon, 8 May 2017 11:47:26 +0200
Message-ID: <CALw8SCVJdOeHgM7avuBSrr+gb+HuZm5eA9vH=EQ+CEMvGDgucQ@mail.gmail.com>
References: <e17fc677-1f3a-5a29-10f8-d27cea173b47@eurekelettronica.it> <CALw8SCWzZTLM4S_EBwpLFu3yT8Z1hLrNKPkE6n1XDcVfGXZqnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33206 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbdEHJr2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 May 2017 05:47:28 -0400
Received: by mail-qk0-f179.google.com with SMTP id y201so14568239qka.0
        for <linux-can@vger.kernel.org>; Mon, 08 May 2017 02:47:28 -0700 (PDT)
In-Reply-To: <CALw8SCWzZTLM4S_EBwpLFu3yT8Z1hLrNKPkE6n1XDcVfGXZqnA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, gianluca <gianlucarenzi@eurekelettronica.it>

---------- Forwarded message ----------
From: Mirza Krak <mirza.krak@gmail.com>
Date: 2017-05-08 11:45 GMT+02:00
Subject: Re: CanBus2Ethernet Bridge
To: gianluca <gianlucarenzi@eurekelettronica.it>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


2017-05-08 11:31 GMT+02:00 gianluca <gianlucarenzi@eurekelettronica.it>:
>
> Hello list!
>
> I am looking for a simple bridge who collect canbus packets over a socket=
can device (i.e. can0) and send them to a socket device (i.e. a network soc=
ket).
>
> I have a embedded board who run Linux Debian with CanBus (i.MX6 with Flex=
Can) and I would like to send/receive those messages to a "server" who is l=
istening on the network socket and "translate" them to can frames to an exi=
sting can device (i.e. vcan0 or a real can0 device).
>
> Because on the "server" there is an application software who is using the=
 socketcan device to exchange data and such.
>
> I was thinking about socketcand daemon but to my knowledge has a few limi=
tiations:
>
> 1- It uses the REAL socketcan device as accessing device (-i option [vcan=
0,can1] ...)
> 2- It uses the interface to bind to, and NOT the address to send the pack=
ets to (-l).
>
> I would like to have something like this on the embedded (it does not wor=
k actually!!):
>
> (iMX6 IP: 192.168.1.101)
> # socketcand -i can0 -l 192.168.1.100
>
> and on the server (192.168.1.100):
>
> # socketcand -i vcan0 -l 192.168.1.101
>
> In this way every packet sent from the application to the vcan0 can be ro=
uted through the ethernet to the iMX6 @ address 192.168.1.101 and every pac=
ket received from the real canbus CAN0 on the iMX6 can be routed to the ser=
ver 192.168.1.100 to the vcan0 interface.
>
> There is such possibility without writing a bridge from scratch???

(re-send, first attempt had HTML parts)

There is an project that I believe does what you are after. Take a look at =
[1].

[1]. https://github.com/mguentner/cannelloni

--=20
Best Regards
Mirza
