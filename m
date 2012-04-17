From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: read() question from newbie
Date: Tue, 17 Apr 2012 08:08:18 +0200
Message-ID: <4F8D08D2.3090701@hartkopp.net>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com> <CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com> <4F51DEF0.9060501@hartkopp.net> <CABHoAvmiu2JY70zJ8K20n8b=ahCDe8owRRWaSLMJoTd36ub7iw@mail.gmail.com> <4F553BDA.8060106@hartkopp.net> <4F553CA5.8080704@hartkopp.net> <CABHoAv=WuK0WZWNyi7jgBTNUbHub8AuGtPzbjL4dYaQ1ZGpu_g@mail.gmail.com> <4F56701E.3020104@hartkopp.net> <CABHoAv=FhULnAY+a2CbNjdyEEOoBKdEAezL7NQLo+PdfeyRTow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:50490 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307Ab2DQGIT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Apr 2012 02:08:19 -0400
In-Reply-To: <CABHoAv=FhULnAY+a2CbNjdyEEOoBKdEAezL7NQLo+PdfeyRTow@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Economides <mecono@gmail.com>
Cc: linux-can@vger.kernel.org

On 17.04.2012 06:16, Michael Economides wrote:


>>
>> I assume there is a CAN bus problem:
>>
>> - wiring (CAN_L/CAN_H)
>> - correct CAN termination (2x 120 Ohms)
>> - different bitrate
>>
> 
> I think you are right, but I have checked that, it looks ok.  I will
> check again.
> 
> I am using a PCAN USB adapter, and the PCAN software says there is an
> "acknowledge error" when it sends a frame to my Linux board.


This is an indication for a missing counterpart CAN node:

- Wrong connection wiring
- Wrong termination
- Wrong bitrate

> 
> When the Linux board tries to send a frame to PCAN, the PCAN software
> says "form error acknowledge delimiter".
> 
> It seems this is the same error in both cases, just worded differently.


Yes. But this means the same regarding the obvious problems.

> 
> In your opinion, is this most likely a hardware issue?  Or is there
> still some way I could be doing something wrong at the software level?


Did you swap CAN_H / CAN_L ??

It's definitely one of the three points above. No SW problem ...

Try to add a third CAN node - if you have one.

Regards,
Oliver
