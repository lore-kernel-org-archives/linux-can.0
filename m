From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Kernel Oops with: ip link set can0 type can
Date: Tue, 21 Jun 2016 11:17:22 +0200
Message-ID: <53a1d68d-6267-e3fc-af7d-ba4d49f8124a@hartkopp.net>
References: <loom.20160621T095606-63@post.gmane.org>
 <loom.20160621T105023-651@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:28008 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbcFUJRc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2016 05:17:32 -0400
In-Reply-To: <loom.20160621T105023-651@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org



On 06/21/2016 10:55 AM, ajneu wrote:
> ajneu <ajneu1 <at> gmail.com> writes:
>
>>
>> Hi,
>>
>> issuing the command
>>    sudo ip link set can0 type can
>> I get Kernel Oops (NULL pointer dereference)
>> Command line prints: "Killed".
>>
>> [...]
>>
>> dmesg shows
>> [...]
>
>
> Question:
> How should one add and set a can device???

You do can not add a CAN device.

A 'real' CAN netdevice is detected and initialized automatically.

You only can add 'virtual' CAN devices:

ip link add dev vcan0 type vcan


But the OOPS should no occur due to your ip usage anyway :-(
This has to be fixed ...

Regards,
Oliver

