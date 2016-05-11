From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 May 2016 15:25:46 +0200
Message-ID: <573332DA.7070400@hartkopp.net>
References: <1378920814-sup-4559@pruts.nl> <1462908218-sup-6526@pruts.nl>
 <5732E1F9.1060908@hartkopp.net> <1462952665-sup-1016@pruts.nl>
 <5732EA89.5060303@hartkopp.net> <1462969665-sup-623@pruts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:48123 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444AbcEKN0A (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 May 2016 09:26:00 -0400
In-Reply-To: <1462969665-sup-623@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico Doornekamp <ico@pruts.nl>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 05/11/2016 02:28 PM, Ico Doornekamp wrote:
> * On 2016-05-11 10:17:13 +0200, Oliver Hartkopp wrote:
>
>> That's strange indeed.
>>
>> Can you send the output of
>>
>> ip -details link show vcan0
>> ip -details link show slcan0
>
> $ ip -details link show vcan0
> 4: vcan0: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1
>      link/can  promiscuity 0
>      vcan
>
> $ ip -details link show slcan0
> 7: slcan0: <NOARP,UP,LOWER_UP> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>

When my posted patch does not have an effect it may be worth looking at 
the differences of the selected qdiscs (noqueue/pfifo).

>> At least the CAN ID is 'AND'ed with CAN_ERR_MASK 0x1FFFFFFF :-)
>> That's the reason for the missing '2' due to  CAN_ERR_FLAG.
>
> Indeed, I figured that much already.
>
>> Btw, can you check if this patch fixes the issue:
>
> This pach seems to be already in the 4.4.0 kernel, which I'm running.

Hm - no.

The patch I posted changes slcan.c - which the original patch did not touch.

The slcan.c patch is based on latest Linux 4.6.0-rc7-00055-gc511462 :-)

Please try it out.

Regards,
Oliver
