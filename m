From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: Re: MCP2515 implementation is slow
Date: Tue, 25 Nov 2014 17:47:57 +0100
Message-ID: <5474B2BD.1030901@eurekelettronica.it>
References: <84a1d29551f84f5494b309e1ad1e0840@SGPMBX1004.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx7.acantho.net ([213.174.182.181]:34947 "EHLO mx7.acantho.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbaKYQzH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 25 Nov 2014 11:55:07 -0500
Received: (from root@localhost)
	by mx7.acantho.net (8.14.3/8.13.4/Debian-3sarge1) id sAPGn7Un010742
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2014 17:49:07 +0100
In-Reply-To: <84a1d29551f84f5494b309e1ad1e0840@SGPMBX1004.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Pankajkumar Misra (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>
Cc: linux-can@vger.kernel.org

On 11/25/2014 05:19 PM, Pankajkumar Misra (RBEI/EEA2) wrote:
> Hello Guys,
>
> I have compiled MCP251x.c kernel driver module for Olimex A20-Olinuxi=
no Micro.
>
> The device is working fine for one frame at a time at 500ms. If I sen=
d two or more frame at the same time,
> CAN is going to bus-off due to overrun errors.
> Even if I send one frame at faster rate say, 100ms,results in bus-off=
=2E
>
> I am communicating with module with ip commands, cansend & candump.
> Also my SPI module is working only at 250K baud, not any other baud.
>
> Any suggestions.
>
> Best Regards,
> Pankaj
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

Once upon a time there were a custom mcp2515.c driver rewritten by=20
Oliveira and modified by myself to obtain the maximum performance=20
possible with this VERY POOR chip.

http://clientes.netvisao.pt/anbadeol/mcp2515.html

If you are interested, please feel-free to contact me to obtain a=20
modified version (maybe better? :-P ) of this driver.

Actually it runs on a 2.6.27 kernel with a Samsung S3C2442 SoC. It runs=
=20
without any problem running @ 250Kbit/s and 125Kbit/s with some burst o=
f=20
a frame every 2 or 4 msecs. For sure your application has to be 'niced'=
=20
to a be almost-real-time over other processes and the socket receive=20
queues have to be increased a little bit.
But it works good over the past 3 years with approx. 1k custom boards=20
batch worldwide sold.

It would not so difficult to adapt it to run over a 3.x kernel and mayb=
e=20
in a near future I will add a DEVICE TREE support for it.

Best regards,
--=20
            ,,,
           (o o)
=3D=3D=3D=3D=3D=3DoOO=3D=3D(_)=3D=3DOOo=3D=3D=3D=3D=3D=3D

Gianluca Renzi
R&D
phone: +39.0542.609120
fax:   +39.0542.609212

       .oooO  Oooo.
=3D=3D=3D=3D=3D=3D(   )=3D=3D(   )=3D=3D=3D=3D=3D=3D=3D
        \ (    ) /
         \_)  (_/

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
  \ source code!  /
   ---------------
     =C2=AF\_(".)_/=C2=AF
