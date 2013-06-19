From: j.uzycki@elproma.com.pl
Subject: Re: slcanpty
Date: Thu, 20 Jun 2013 00:39:40 +0200
Message-ID: <57ec0d6e974a0a9688d1f68c5204d95e@beep.pl>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2>
 <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2>
 <51B0D58F.2010401@hartkopp.net> <b4ff288352031c6f215c601575e7be0d@beep.pl>
 <51B7896D.7080608@hartkopp.net> <a1ef1ba453a6dca8222147aab20b61f1@beep.pl>
 <51B892E4.6020907@hartkopp.net> mid:1927
 <3dc287504f468fde2629107bdc65c4ae@beep.pl> <51C1E74A.70107@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout12.mailmx.agnat.pl ([193.239.45.92]:58705 "EHLO
	mailmxout12.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935295Ab3FSWjp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Jun 2013 18:39:45 -0400
In-Reply-To: <51C1E74A.70107@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

>> I've just implemented SJA1000 filter emulator. I didn't test it yet. 
>> What do
>> you think about the idea?
> 
> Pretty funny.
> 
> Your referenced docs (and your patch) are very informative, but I just 
> wonder
> if the filters have really ever been used by anybody.
> 
> They look *very* special.
> 
> If there's a need to implement it, it's ok.
> But IMHO adding the filters just for the completeness of an emulation 
> can be
> omitted when nobody is ever using it.

The whole solution is very specific. The main idea is to reuse existing 
CAN applications ecosystem by common protocols (based on serial port or 
TCP/IP stack).
An universal remote CAN gateway sends data via eg. GPRS which generates 
costs, delays etc. Therefore filters are very appreciated. In other case 
the filters could be negligible.
The simplest choice seems just emulate cheap SLCAN adapters using eg. 
slcanpty.
Another option is socketcand - much better but desired for the future 
front-end applications (I hope).
Any better idea?

best regards
Janusz

