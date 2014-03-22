From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: TX timestamping
Date: Sat, 22 Mar 2014 20:22:46 +0100
Message-ID: <532DE306.1060302@hartkopp.net>
References: <CAGfq0uugZi8+BrF_D1cLXjVZ9nePuKeX2fQ5c9vLGRiYQO0RQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:23570 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaCVTWs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 22 Mar 2014 15:22:48 -0400
In-Reply-To: <CAGfq0uugZi8+BrF_D1cLXjVZ9nePuKeX2fQ5c9vLGRiYQO0RQg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Kirienko <pavel.kirienko.list@gmail.com>, linux-can@vger.kernel.org

Hello Pavel,

On 20.03.2014 17:28, Pavel Kirienko wrote:
> Hi linux-can,
> 
> What are my options to get the hardware TX timestamp of an outgoing
> CAN frame? I couldn't find complete manual for that, but here's what I
> googled so far:
> 
> 1. Use generic socket timestamping, as described in the network man
> (http://os1a.cs.columbia.edu/lxr/source/Documentation/networking/timestamping.txt?a=x86);
> 
> 2. Read my own frames back through CAN_RAW_RECV_OWN_MSGS, supposedly
> RX timestamps of the loopbacked frames will be the same as their TX
> timestamps.
> 
> Are these the correct methods?

Yes.

With CAN_RAW_RECV_OWN_MSGS you get the echoed frame on a socket which
originally sent the frame.

The timestamps are currently only set at RX time.

http://os1a.cs.columbia.edu/lxr/source/net/core/dev.c?a=x86#2864
http://os1a.cs.columbia.edu/lxr/source/net/core/dev.c?a=x86#1463

As you can see in net_timestamp_check()

http://os1a.cs.columbia.edu/lxr/source/net/core/dev.c?a=x86#1471

the timestamp is only set if it was empty before.

E.g. if you forward a CAN frame with can-gw there's an extra option to not
clear the timestamp when routing the frame (option -t [preserve src_dev rx
timestamp]).

As the sent frames are echoed back you are pretty right that the RX timestamp
and the TX timestamp are the same.

Regards,
Oliver

