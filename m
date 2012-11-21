From: Casper Mogensen <casper.mogensen@gmail.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Wed, 21 Nov 2012 17:58:03 +0100
Message-ID: <CABgkGoERKCNNb2V8UwNMJzm0hHiZkzXBmbdAg4N556Pb2nO5LQ@mail.gmail.com>
References: <loom.20121114T160521-534@post.gmane.org>
	<50A4972A.9070707@hartkopp.net>
	<50A4EA87.9020206@grandegger.com>
	<loom.20121115T171319-854@post.gmane.org>
	<50A55C65.2020003@grandegger.com>
	<loom.20121115T222748-977@post.gmane.org>
	<50A95FC1.3050907@grandegger.com>
	<loom.20121119T155735-163@post.gmane.org>
	<50AA4FB3.7070009@grandegger.com>
	<loom.20121119T171647-35@post.gmane.org>
	<50AA5EE6.6060105@grandegger.com>
	<loom.20121119T183819-427@post.gmane.org>
	<50AA86DB.7000506@grandegger.com>
	<loom.20121119T211403-520@post.gmane.org>
	<50AAA8C8.2080504@grandegger.com>
	<loom.20121120T151831-134@post.gmane.org>
	<50ABABDE.8060503@grandegger.com>
	<loom.20121120T192159-770@post.gmane.org>
	<50ABF09C.8040303@grandegger.com>
	<50ACABE2.2020306@grandegger.com>
	<loom.20121121T162041-774@post.gmane.org>
	<50ACF9C0.8050206@grandegger.com>
	<loom.20121121T170446-911@post.gmane.org>
	<50AD042B.3020305@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45361 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335Ab2KUQ6G (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Nov 2012 11:58:06 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so2400115eek.19
        for <linux-can@vger.kernel.org>; Wed, 21 Nov 2012 08:58:03 -0800 (PST)
In-Reply-To: <50AD042B.3020305@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Michael Pellegrini <mikep86@gmail.com>, linux-can@vger.kernel.org

Hi again

Just took a quick look in the C_CAN driver  and from what i can see,
it suffers from the same problem, as i described earlier with the
pch_can.
There is no locking what so ever, but the xmit function and the
can_do_tx uses same place in ram buffer, and uses same procedure as in
pch_can with setting registers and then writing them at the end of
both functions.

Regards

Casper Mogensen

On Wed, Nov 21, 2012 at 5:41 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On 11/21/2012 05:09 PM, Michael Pellegrini wrote:
>> Wolfgang Grandegger <wg <at> grandegger.com> writes:
>>
>>> OK, at least we have reached the level of the PHC_CAN driver. The driver
>>> does print some debug messages. Could you show them?
>>
>> Do you mean the dmesg output?  Dmesg output during the transmission problem is
>> an uninterrupted stream of "c_can_isr: irqstatus=0xXX", where XX is constant.
>> So far, I have seen the values 0x17, 0x19, and 0x1e in the three times I have
>> hit the transmission problem.
>
> Could you show the sequence? I need to lookup the meaning of the bits.
>
> Wolfgang.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards / Med venlig hilsen

Casper Mogensen
