From: Felix Obenhuber <felix@obenhuber.de>
Subject: Re: Wireshark / libpcap - was Re: [RFC] CAN FD support part 2 - ideas
 and commented source
Date: Mon, 7 May 2012 14:19:25 +0200
Message-ID: <CAJsOQGOwuMaKvizVf6rvtWevGULNmOC=tRnjr7o0+zKqVgqH4g@mail.gmail.com>
References: <4FA242D0.2070604@hartkopp.net>
	<4FA268B2.8030109@hartkopp.net>
	<20120503123755.GD416@vandijck-laurijssen.be>
	<4FA27F18.9080106@hartkopp.net>
	<4FA2C7FC.9070103@hartkopp.net>
	<20120504092937.GA420@vandijck-laurijssen.be>
	<4FA3A89C.8080209@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42674 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642Ab2EGMT0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 May 2012 08:19:26 -0400
Received: by werb10 with SMTP id b10so1200098wer.19
        for <linux-can@vger.kernel.org>; Mon, 07 May 2012 05:19:25 -0700 (PDT)
In-Reply-To: <4FA3A89C.8080209@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

>>>> You can look into the eth protocol and know the skb data layout.
>> Again, both layouts are compatible.
>
>
> Hm - nearly.
>
> As the canfd_frame.flags element is new AND you have a different PDU length.
>
> :-)
>
>>
>>>> The length information is some kind of implicit knowledge.
>> Again, there are so many checks to fix the length to one of 2 available
>> MTU's that I doubt the implicit character of the lenght information
>> for the CAN situation.

If I got you right, then I think there's no need for ETH_P_CANFD from
the pcap/wireshark point of view:

Both currently don't care about ETH_P_CAN. This could be improved,
cause the detection of a CAN interface is currently done via the
interface name. That works - but can drive people crazy when they
setup a different naming that canXX and vcanXX.

To handle the CANFD information in the Wireshark dissector, the packet
length information is sufficient. I think it's easier to manage the
different formats in wireshark and not down in pcap. Pcap is (almost)
not aware of the the packet content at all. Furthermore you can save a
the FD specific DLT.

Felix
