From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: arbitration lost error reporting
Date: Fri, 06 Dec 2013 18:59:30 +0100
Message-ID: <52A21082.9010102@grandegger.com>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <52A1A323.1030605@pengutronix.de> <loom.20131206T114831-779@post.gmane.org> <52A1B8DA.1030700@pengutronix.de> <52A1BCEE.5070101@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44602 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab3LFR7b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2013 12:59:31 -0500
In-Reply-To: <52A1BCEE.5070101@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Richard Andrysek <richard.andrysek@rg-mechatronics.com>, linux-can@vger.kernel.org

On 12/06/2013 01:02 PM, Oliver Hartkopp wrote:
> 
> 
> On 06.12.2013 12:45, Marc Kleine-Budde wrote:
>> On 12/06/2013 11:57 AM, Richard Andrysek wrote:
>>>> You can send a diff, to illustrate your changes.
>>>
>>> $ diff /cygdrive/X/bug1/sja1000.c /cygdrive/X/modified_sja1000.c
>>
>> "diff -u" is preferred, but no need to resend it.
>>
>>>>> But I prefare to make some kind of "ioctl" support for that. There are
>>>>> applications, where it shall not happend. Concurrently I've played with
>>>>> taskset and priorities.
>>>>
>>>> ioctl() is not a option here, but there are two options:
>>>> 1) We can put the arbitration lost error to the bus errors,
>>>>    but I think that's wrong.
>>>> 2) You can add another ctrlmode to disable arbitration lost error
>>>>    reporting.
>>
>>> As Wolgang mentioned it has nothing to do with the patch v6.
>>> Enabling/diabling IRQs is a new feature. So I don't know, if here it is a
>>> right place to continue about that.
>>
>> Yes, why not? :)
>> As I outlined above you have two options. I prefer option 2 and it has a
>> big change of going mainline. The implementation is similar to
>> CAN_CTRLMODE_BERR_REPORTING, just look for it in the kernel source tree
>> and add a new define for arbitration lost error reporting.
>>
>> Do you have a preferred name for the define?
>> - CAN_CTRLMODE_AERR_REPORTING
>> - CAN_CTRLMODE_ARBITRATIONERR_REPORTING to
> 
> Loosing the arbitration is not an error. It just can happen from time to time.

Well, if it does not happen often, why do we want to suppress reporting
this error? I still do not see what it's good for.

Wolfgang.

