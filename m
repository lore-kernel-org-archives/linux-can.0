From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: fix loss of frames due to wrong assumption in raw_rcv
Date: Wed, 24 Jun 2015 21:56:31 +0200
Message-ID: <558B0B6F.6010304@hartkopp.net>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net> <558A1244.3010908@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:62280 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbbFXT4o (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Jun 2015 15:56:44 -0400
In-Reply-To: <558A1244.3010908@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 24.06.2015 04:13, Tom Evans wrote:
> On 23/06/15 18:01, Oliver Hartkopp wrote:
>> An alternative to force the timestamp to be set would be to add another
>> 'counter' to struct can_skb_priv which is just increased by the driver with
>> every received CAN frame.
>>
>> But I wonder if its worth the effort in opposite to just enable timestamping
>> in every skb. What do you think?
>
>  From a programming standpoint, using a "timestamp" as a "unique identifier"
> is opaque and a poor design. If the SKB requires a "unique identifier" then it
> should be provided with something that has that description and purpose.

Hey Tom,

> The timestamp may be optional for a reason. Maybe some platforms simply don't
> provide a high resolution timestamp, and/or the timestamp comes with a high
> overhead. Can you guarantee that all current, future and past platforms
> support a low overhead and high resolution timestamp?

I have used the CAN stuff on two PowerPC, one ARM and several x86 platforms - 
always with enabled timestamping - without any problems in performance.

> A new "feature" probably shouldn't change something that was optional to being
> compulsory. Would all existing CAN drivers need to be rewritten to add this
> timestamping, or is the timestamp added in higher (and more generic) layers,
> and in the one place?

The point is that out-of-tree drivers (like the PEAK-System driver) would need 
to set the timestamp too to take advantage of the joint filter feature.
The mainline drivers are adapted for now with the stable patch

http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=36c01245eb8046c16eee6431e7dbfbb302635fa8

But I felt not very comfortable with this fix. The point is that I have to 
take care that the processing of an incoming skb in can_receive() in af_can.c 
is done in 'one step' with an unique skb. So marking the skb for the joint 
filter feature in raw_rcv() can probably be done in can_receive().

I'm looking for a SMP save solution for this - to finally revert the fix 
above. So thanks for the 'wake-up call' by naming the timestamping solution  a 
'poor design'  ;-)

Best regards,
Oliver

