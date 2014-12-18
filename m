From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 0/5] Consolidate and unify state change handling
Date: Thu, 18 Dec 2014 08:22:56 +0100
Message-ID: <549280D0.6060507@hartkopp.net>
References: <a0f69b4e-b1d5-4c3e-b960-b9f2b34a4e1a@GRBSR0089.marel.net> <loom.20141218T070747-796@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:47380 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbaLRHXL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Dec 2014 02:23:11 -0500
In-Reply-To: <loom.20141218T070747-796@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org



On 18.12.2014 07:09, Tom Evans wrote:
> Andri Yngvason <andri.yngvason <at> marel.com> writes:
>> Tested on sja1000 using
>>   cangen -Ii -g 100 can0
>> and
>>   candump -ta -e can0,0:0,#FFFFFFFF
>>
>> Disconnected bus:
>>   (1417614605.207964)  can0  07D   [6]  49 6E A1 7A 2A 3D
>>   (1417614605.308206)  can0  07E   [8]  5F 18 AA 0F E5 82 CA 11
>>   (1417614605.408107)  can0  07F   [5]  3E 12 B0 68 1A
>>   (1417614605.514235)  can0  20000004   [8]  00 08 00 00 00 00 60 00
> ERRORFRAME
>> 	controller-problem{tx-error-warning}
>> 	error-counter-tx-rx{{96}{0}}
>
> Is the version of candump that supports "-e" and prints the errors
> available? It would be very useful in my current testing.
>

The candump in can-utils provide this option:

	https://gitorious.org/linux-can/can-utils/

You may "git clone" the latest version and build it from source.

If you have a recent Debian or Ubuntu-style distro on your Linux-box:

	apt-get install can-utils

will make it.

Regards,
Oliver

