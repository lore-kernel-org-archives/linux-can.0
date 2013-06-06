From: janusz.uzycki@elproma.com.pl
Subject: Re: slcanpty
Date: Thu, 06 Jun 2013 22:43:49 +0200
Message-ID: <5977dc6800957db61319d72d8672409e@beep.pl>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2>
 <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2>
 <51B0D58F.2010401@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout15.mailmx.agnat.pl ([193.239.45.95]:42352 "EHLO
	mailmxout15.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752981Ab3FFUoH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Jun 2013 16:44:07 -0400
In-Reply-To: <51B0D58F.2010401@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

> The SLCAN protocol is a nice and simple ASCII protocol that fits for 
> many
> purposes. But it also has some disadvantages e.g. when you want 
> timestamps and
> additional error signaling you can usually get from a CAN controller.

Timestamps (Z) are supported. Error flags are emulated in slcanpty but 
SLCAN protocol seems more messy here, ie. there are different meaning 
conventions from each manufacturer.
Even CAN drivers (SocketCAN, can4linux, LinCAN etc.) are different. 
Which is optimal choice? I found tons of papers with title "our is 
better":) Good to have choice but 2-3 is enough.
However I was hope SLCAN is good supported by existing front-end 
software. Before I found old horch (origin: uClinux).

>> Is it possible to configure remote CAN using socketcand to use CAN 
>> Festival
>> both under Linux and Windows on PC?
> 
> I'm not that deep in CAN Festival, but why not? :-)

http://www.canfestival.org/doc Supported devices - the best multi OS 
support is for closed Peak System. VScom protocol is similar to SLCAN - 
it is why I asked about slcanpty.

>> Is the protocol
>> (https://github.com/dschanoeh/socketcand/blob/master/doc/protocol.md) 
>> some
>> kind of standard? What open source front-end could you advice?
> 
> The protocol has been created to have a language independent CAN 
> access over
> remote/localhost network sockets.
> 
> It was mainly intended to be used together with Java which knows 
> PF_INET
> sockets much better than PF_CAN sockets ...
> 
> See
> 
> http://kayak.2codeornot2code.org
> 
> and
> 
> http://kayak.2codeornot2code.org/tutorial.html

It would be great to have universal protocol for most third party 
frond-end software.

> If you have remarks to the doc/protocol.md please feel free to discuss 
> and
> extend it.

ok, first I'll try basics :)

> An other open protocol for this kind of remote CAN control purpose is 
> probably
> CANAL from http://www.vscp.org/wiki/doku.php/canal - did you know it?

Oh, I didn't know. The whole VSCP idea is very interesting because m2m 
-> IoT is trend for the future.

CAN bus issue, despite of defined industrial standards, is still quite 
fuzzy in APIs, networking protocols and finally software. In commercial 
solutions it is natural but in open source community common way would 
gain winner(s) and interoperability I guess. However thanks to your work 
it's going to be better.

kind regards
Janusz
