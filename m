From: janusz.uzycki@elproma.com.pl
Subject: Re: slcanpty
Date: Tue, 11 Jun 2013 18:29:39 +0200
Message-ID: <b4ff288352031c6f215c601575e7be0d@beep.pl>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2>
 <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2>
 <51B0D58F.2010401@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout15.mailmx.agnat.pl ([193.239.45.95]:54489 "EHLO
	mailmxout15.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755259Ab3FKQ3x (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2013 12:29:53 -0400
In-Reply-To: <51B0D58F.2010401@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

Hi Oliver.

> The SLCAN protocol is a nice and simple ASCII protocol that fits for 
> many
> purposes. But it also has some disadvantages e.g. when you want 
> timestamps and
> additional error signaling you can usually get from a CAN controller.
> 
>> (https://github.com/dschanoeh/socketcand/blob/master/doc/protocol.md) 
>> some

I noticed that both slcanpty and socketcand don't implement bitrate 
settings yet.
iproute2 includes libnetlink but the library avoids CAN support.
libsocketcan seems to be the best choice but libnl also good.

What do you prefer for CAN interface control?

best regards
Janusz Uzycki

