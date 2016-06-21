From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Kernel Oops with: ip link set can0 type can
Date: Tue, 21 Jun 2016 12:19:31 +0200
Message-ID: <d9d3c57a-1c47-2220-7b09-40b46966c80a@hartkopp.net>
References: <loom.20160621T095606-63@post.gmane.org>
 <loom.20160621T105023-651@post.gmane.org>
 <53a1d68d-6267-e3fc-af7d-ba4d49f8124a@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:65253 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbcFUKTz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2016 06:19:55 -0400
In-Reply-To: <53a1d68d-6267-e3fc-af7d-ba4d49f8124a@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>



On 06/21/2016 11:17 AM, Oliver Hartkopp wrote:
> On 06/21/2016 10:55 AM, ajneu wrote:
>> ajneu <ajneu1 <at> gmail.com> writes:
>>
>>>
>>> Hi,
>>>
>>> issuing the command
>>>    sudo ip link set can0 type can
>>> I get Kernel Oops (NULL pointer dereference)


> But the OOPS should no occur due to your ip usage anyway :-(
> This has to be fixed ...

Can you please check whether my posted patch fixes your problem?

http://marc.info/?l=linux-can&m=146650412017263&w=2

I tested it myself with success.

Thanks for catching this issue!

Regards,
Oliver
