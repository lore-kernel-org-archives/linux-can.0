From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: Re: MCP2515 implementation is slow
Date: Wed, 26 Nov 2014 17:13:37 +0100
Message-ID: <5475FC31.6020105@eurekelettronica.it>
References: <84a1d29551f84f5494b309e1ad1e0840@SGPMBX1004.APAC.bosch.com> <5474B2BD.1030901@eurekelettronica.it> <45c8e0a27f1140be831e1c21d65a2091@SGPMBX1004.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx7.acantho.net ([213.174.182.181]:50134 "EHLO mx7.acantho.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbaKZQNw (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 26 Nov 2014 11:13:52 -0500
Received: (from root@localhost)
	by mx7.acantho.net (8.14.3/8.13.4/Debian-3sarge1) id sAQGDo1s027141
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2014 17:13:50 +0100
In-Reply-To: <45c8e0a27f1140be831e1c21d65a2091@SGPMBX1004.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Pankajkumar Misra (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 11/26/2014 06:02 AM, Pankajkumar Misra (RBEI/EEA2) wrote:

> But we are doing it on Kernel version 3.4.
>
>>
>> http://clientes.netvisao.pt/anbadeol/mcp2515.html
>>
>> Actually it runs on a 2.6.27 kernel with a Samsung S3C2442 SoC. It r=
uns
>> without any problem running @ 250Kbit/s and 125Kbit/s with some burs=
t of
>> a frame every 2 or 4 msecs. For sure your application has to be 'nic=
ed'

I've told you it runs for sure on 2.6.27.

> Lets see what is possible.

I think with some minor changes to the SPI API it is a viable way to do=
=2E

If you reach a working driver why not including it in the -next linux=20
merge window??

Regards,
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
