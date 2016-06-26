From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Clear transmit buffer (of pending queued tx-messages)
Date: Mon, 27 Jun 2016 09:31:03 +1000
Message-ID: <577065B7.3090809@optusnet.com.au>
References: <loom.20160622T135857-352@post.gmane.org>
 <loom.20160623T104337-28@post.gmane.org>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:52449 "EHLO
	mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751501AbcFZXbG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2016 19:31:06 -0400
In-Reply-To: <loom.20160623T104337-28@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org

On 23/06/16 18:45, ajneu wrote:
> Oliver Hartkopp <socketcan <at> hartkopp.net> writes:
>
>> The question is whether blocking write (and probably write outdated
>> content) is what you want for CAN.
>
> I've tried non-blocking.

I think you're trying to use the "available tools" to solve a different problem.

> Example:
> If I send out 2 messages (non-blocking) with no participant on the bus,
> those messages will remain queued.
> If 5 minutes later a participant joins the bus, he'll get those 2 very old
> messages: outdated content.
>
> What are my options to solve this?
 >
> (Can I find out if a message has actually been sent out onto the bus?)

Yes. You have THE OTHER END reply to a message stating "I've received it". 
"Message receipt" isn't CAN's problem. That's a higher level construct.

If you don't want the other end getting "outdated content", than have the 
sender queue up unimportant messages that don't have any time sensitive content.

So when the sender comes up it should send an "I'm here" or a "are you there?" 
message, and not send anything else until it gets some form of "I'm alive" 
message from the other end. Then you send "the real content".

Tom

