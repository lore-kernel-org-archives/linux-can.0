From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: slcanpty
Date: Tue, 11 Jun 2013 22:32:45 +0200
Message-ID: <51B7896D.7080608@hartkopp.net>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2> <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2> <51B0D58F.2010401@hartkopp.net> <b4ff288352031c6f215c601575e7be0d@beep.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:15439 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756342Ab3FKUcq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2013 16:32:46 -0400
In-Reply-To: <b4ff288352031c6f215c601575e7be0d@beep.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: janusz.uzycki@elproma.com.pl
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

On 11.06.2013 18:29, janusz.uzycki@elproma.com.pl wrote:
> Hi Oliver.
> 
>> The SLCAN protocol is a nice and simple ASCII protocol that fits for many
>> purposes. But it also has some disadvantages e.g. when you want timestamps and
>> additional error signaling you can usually get from a CAN controller.
>>
>>> (https://github.com/dschanoeh/socketcand/blob/master/doc/protocol.md) some
> 
> I noticed that both slcanpty and socketcand don't implement bitrate settings yet.
> iproute2 includes libnetlink but the library avoids CAN support.
> libsocketcan seems to be the best choice but libnl also good.
> 
> What do you prefer for CAN interface control?

I'm personally using the standard ip tool from iproute together with this script:

https://gitorious.org/linux-can/can-misc/blobs/master/etc/can_if

BR,
Oliver

