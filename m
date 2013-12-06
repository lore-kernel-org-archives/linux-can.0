From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ
 handler return value
Date: Fri, 06 Dec 2013 19:32:23 +0100
Message-ID: <52A21837.3030709@grandegger.com>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <ac6a947c7ec842f67e9d23abd877b884@grandegger.com> <loom.20131206T112023-62@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46676 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654Ab3LFSc1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2013 13:32:27 -0500
In-Reply-To: <loom.20131206T112023-62@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@rg-mechatronics.com>, linux-can@vger.kernel.org

On 12/06/2013 11:32 AM, Richard Andrysek wrote:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> 
>>
>> ...
>>
>>> I've just studied sja1000.c I do not know yet, if it is healthy.
>>
>> This is normally due to hardware/electrical problems. It has nothing to do
>>
>> with software. Well, is there *any* relation to the patch mentioned in the
>>
>> subject? I mean, does the problem *not* show up without that patch.
> 
> 
> Patch solved a problem with unhandled IRQs. The original problem is solved.

What did it fix? Could you elaborate on that issue. You actually never
reported a problem.

Wolfgang.
