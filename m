From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [BULK]Re: [PATCH] can: fix loss of frames due to wrong assumption
 in raw_rcv
Date: Mon, 29 Jun 2015 18:13:48 +0200
Message-ID: <55916EBC.2010807@hartkopp.net>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net> <558A1244.3010908@optusnet.com.au> <558B0B6F.6010304@hartkopp.net> <558BBC92.6040906@peak-system.com> <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store>
Reply-To: Oliver Hartkopp <socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:10331 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbbF2QOV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Jun 2015 12:14:21 -0400
In-Reply-To: <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, tom_usenet@optusnet.com.au

Hi Stephane,

On 25.06.2015 11:36, Oliver Hartkopp wrote:
>> Stephane Grosjean <s.grosjean@peak-system.com>

 >> (..)
>> tells that he's facing some loss of frames with the PEAK-System PCAN-USB
>> adapter, in case of "relatively"  high bus load... He's running two
>> Kernels (3.19 and the last 4.1 patched with this recent "fix"). At the
>> moment, he says he always notes some frame leakage, especially when he
>> (for example) "resizes windows on his desktop"...
>
> The patch
>
> http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit?id=36c01245eb8046c16eee6431e7dbfbb302635fa8
>
> especially adds
>
>     __net_timestamp(skb);
>
> after dev_alloc_skb().
>
> So you need to add this in pcan_netdev_rx() in pcan_netdev.c analogue to the
> patch above, e.g. directly after the successful dev_alloc_skb().
>
> Can you check, if this fixes the issue with the (patched) 4.1 kernel?

Any feedback?

Today I checked for frame loss with kernel 4.0.6 + all relevant patches and 
had no frame loss with a PCAN USB pro at 100% bus load.

Regards,
Oliver
