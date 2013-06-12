From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: slcanpty
Date: Wed, 12 Jun 2013 17:25:24 +0200
Message-ID: <51B892E4.6020907@hartkopp.net>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2> <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2> <51B0D58F.2010401@hartkopp.net> <b4ff288352031c6f215c601575e7be0d@beep.pl> <51B7896D.7080608@hartkopp.net> <a1ef1ba453a6dca8222147aab20b61f1@beep.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:27796 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab3FLPZ1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Jun 2013 11:25:27 -0400
In-Reply-To: <a1ef1ba453a6dca8222147aab20b61f1@beep.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: janusz.uzycki@elproma.com.pl
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

On 11.06.2013 23:19, janusz.uzycki@elproma.com.pl wrote:
>>>> The SLCAN protocol is a nice and simple ASCII protocol that fits for many
>>>> purposes. But it also has some disadvantages e.g. when you want timestamps
>>>> and
>>>> additional error signaling you can usually get from a CAN controller.
>>>>
>>>>> (https://github.com/dschanoeh/socketcand/blob/master/doc/protocol.md) some
>>>
>>> I noticed that both slcanpty and socketcand don't implement bitrate
>>> settings yet.
>>> iproute2 includes libnetlink but the library avoids CAN support.
>>> libsocketcan seems to be the best choice but libnl also good.
>>>
>>> What do you prefer for CAN interface control?
>>
>> I'm personally using the standard ip tool from iproute together with
>> this script:
>>
>> https://gitorious.org/linux-can/can-misc/blobs/master/etc/can_if
> 
> The script is nice but I thought about "< can0 B bitrate sample_point tq
> prop_seg phase_seg1 phase_seg2 sjw brp >" command in
> https://github.com/dschanoeh/socketcand/blob/master/doc/protocol.md exactly.
> I looked for a proper code in socketcand and I didn't find. Is the command
> planned?

Not yet.

Today the socketcand can run as normal user.

When we want to add the "B" option (which is generally a good idea) we need to
take care to run socketcand as root or as some sudo user to be able to
configure the CAN interfaces.

Configuring the CAN interfaces as administrator on the host that is connected
to CAN interfaces is IMO a good solution. Don't know what happens, if multiple
users connected to the socketcand and specifiy different bitrates %-(

> I'm asking because if it would be implemented in socketcand it could be also
> implemented in slcanpty for S/s command support. Unfortunately using an
> external library will introduce dependency :/

Btw. i would recommend the libsocketcan from the pengutronix git then.

Best regards,
Oliver

