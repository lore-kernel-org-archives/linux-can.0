From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Bug? -- NEVER getting controller-problem{back-to-error-active}
Date: Mon, 20 Jun 2016 16:28:21 +0200
Message-ID: <5767FD85.9020701@grandegger.com>
References: <loom.20160620T110554-742@post.gmane.org>
 <5767C65D.2010303@grandegger.com> <loom.20160620T145908-586@post.gmane.org>
 <5767F01F.50700@grandegger.com> <loom.20160620T154404-130@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.140]:41161 "EHLO
	mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbcFTOwd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2016 10:52:33 -0400
In-Reply-To: <loom.20160620T154404-130@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

hello,

Am 20.06.2016 um 15:53 schrieb ajneu:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
>
>>
>>
>> Am 20.06.2016 um 15:00 schrieb ajneu:
>>> Hi Wolfgang,
>>>
>>> yes wonderful: you patch works (and solves both issues)!
>>> Will it be going into the mainline linux kernel?
>>
>> I'm going to prepare a patch for mainline inclusion. Can I add your
>> "Tested-by: ajneu <ajneu1 <at> gmail.com>"?
>
> Well ok, you may.
> (Just note I only tested the bugs I reported, and can confirm: those bugs
> are gone. I cannot account for any side-effects, since I didn't do any
> "complete" tests. But scanning the code (*briefly*) it looks sortof ok...

Yes, the changes are obvious. Don't understand why 
CAN_STATE_ERROR_ACTIVE is handled differently. I have added the author.

> Just question: Your change eliminates
>     dev->can.state = CAN_STATE_ERROR_ACTIVE;
> where dev references usb_if, which is passed into the function as parameter.
> Is it ok to eliminate that call??
> (Perhaps its equiv to the line
>     can_change_state(netdev, cf, tx_state, rx_state);
> which is called somewhat lower???)

The state is set in can_change_state().:

http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L341

Wolfgang.
