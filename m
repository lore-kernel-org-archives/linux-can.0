From: "Janusz Uzycki" <janusz.uzycki@elproma.com.pl>
Subject: Re: slcanpty
Date: Fri, 14 Jun 2013 10:42:58 +0200
Message-ID: <CCE90059EAE64C808630EF8EA86C9EAF@laptop2>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2> <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2> <51B0D58F.2010401@hartkopp.net> <b4ff288352031c6f215c601575e7be0d@beep.pl> <51B7896D.7080608@hartkopp.net> <a1ef1ba453a6dca8222147aab20b61f1@beep.pl> <51B892E4.6020907@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout12.mailmx.agnat.pl ([193.239.45.92]:49783 "EHLO
	mailmxout12.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751058Ab3FNInN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Jun 2013 04:43:13 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

>>>> What do you prefer for CAN interface control?
>>>
>>> I'm personally using the standard ip tool from iproute together with
>>> this script:
>>>
>>> https://gitorious.org/linux-can/can-misc/blobs/master/etc/can_if
>>
>> The script is nice but I thought about "< can0 B bitrate sample_point tq
>> prop_seg phase_seg1 phase_seg2 sjw brp >" command in
>> https://github.com/dschanoeh/socketcand/blob/master/doc/protocol.md 
>> exactly.
>> I looked for a proper code in socketcand and I didn't find. Is the 
>> command
>> planned?
>
> Not yet.
>
> Today the socketcand can run as normal user.
> When we want to add the "B" option (which is generally a good idea) we 
> need to
> take care to run socketcand as root or as some sudo user to be able to
> configure the CAN interfaces.
>
> Configuring the CAN interfaces as administrator on the host that is 
> connected
> to CAN interfaces is IMO a good solution.

Yes.

> Don't know what happens, if multiple
> users connected to the socketcand and specifiy different bitrates %-(

I think it will be rare case :)


>> I'm asking because if it would be implemented in socketcand it could be 
>> also
>> implemented in slcanpty for S/s command support. Unfortunately using an
>> external library will introduce dependency :/
>
> Btw. i would recommend the libsocketcan from the pengutronix git then.

ok, it's nice library API.

BTW:
I've learnt about HW filters in SJA1000. I compared the datasheet with 
acceptance filter explanation here http://www.can232.com/?page_id=72
According to datasheet's figures filter output bit acceptance is (AMRn | 
(input ^ ACCn)) and according to the tables in explanation acceptance is 
(AMRn | !(input ^ ACCn)). Do you have experience in practive about it?
I want to convert SJA1000 filter to SocetCAN. SJA1000 has several difficult 
features: dual filter (problem with overlapped filters - additional checking 
required), data filter for 1st and/or 2nd data byte (BCM mode supports, RAW 
mode requires userland filtering but ok).
Finally I consider it is better to use socketCAN filters or implement the 
whole well defined filter (not universal like socketcan filter) in userland. 
What could be more CPU effective?

best regards
Janusz Uzycki

