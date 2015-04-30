From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: kvaser leaf and SocketCAN
Date: Thu, 30 Apr 2015 09:27:30 +0200
Message-ID: <5541D962.5040103@hartkopp.net>
References: <loom.20150422T090300-352@post.gmane.org> <553755E8.20704@pengutronix.de> <loom.20150429T040002-878@post.gmane.org> <CANGgnMbtZz2M=-7ydV6iSFtCskTeXnKsWVB9rqnwX1M+SE1AAg@mail.gmail.com> <loom.20150429T063429-693@post.gmane.org> <55406A03.9060105@pengutronix.de> <20150429104528.GA5712@linux> <loom.20150430T051006-395@post.gmane.org> <loom.20150430T080326-120@post.gmane.org> <5541D057.2020003@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:44773 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbbD3H2Q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Apr 2015 03:28:16 -0400
In-Reply-To: <5541D057.2020003@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Leo Stan <leo.stanislas@qut.edu.au>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

On 30.04.2015 08:48, Marc Kleine-Budde wrote:
> On 04/30/2015 08:14 AM, Leo Stan wrote:


>>          close(s);
>> 	
>>          return 0;
>> }
>>
>> I get this flag :
>>
>> can0 at index 3
>> can raw socket read: Network is down
>                         ^^^^^^^^^^^^^^^
> You have to configure your CAN network device first, then bring it into
> an operational state, this means the network is "up".
>
>      ip link set can0 type can bitrate 500000
>      ip link set can0 up
>
> See section "6.5.1 Netlink interface to set/get devices properties"
> http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L990
>

Yes.

Stan: please download

	https://github.com/linux-can/can-utils

compile and install them (make && make install) or with autotools.

And use 'cansend' and 'candump' to check whether its working.

On recent Debian / Ubuntu you can try

	apt-get install can-utils

Programming your own stuff makes sense when you have a working CAN setup.
But when you are fighting on the basic driver side *and* the userspace apps it 
becomes very hard.

There are also code examples in

	https://github.com/linux-can/can-tests

which will help you more than the Wikipedia code sniplet.

And read

	https://www.kernel.org/doc/Documentation/networking/can.txt

which Marc already suggested.

Best regards,
Oliver
