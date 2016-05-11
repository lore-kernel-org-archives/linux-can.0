From: Ico Doornekamp <ico@pruts.nl>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 May 2016 14:28:56 +0200
Message-ID: <1462969665-sup-623@pruts.nl>
References: <1378920814-sup-4559@pruts.nl> <1462908218-sup-6526@pruts.nl> <5732E1F9.1060908@hartkopp.net> <1462952665-sup-1016@pruts.nl> <5732EA89.5060303@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:33734 "EHLO fe2.pruts.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbcEKM30 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 May 2016 08:29:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by fe2.pruts.nl (Postfix) with ESMTP id 5AD06140065
	for <linux-can@vger.kernel.org>; Wed, 11 May 2016 14:29:21 +0200 (CEST)
Received: from fe2.pruts.nl ([IPv6:::ffff:127.0.0.1])
	by localhost (fe2.local [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 77Yq6e5cBFMC for <linux-can@vger.kernel.org>;
	Wed, 11 May 2016 14:29:21 +0200 (CEST)
In-reply-to: <5732EA89.5060303@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>

* On 2016-05-11 10:17:13 +0200, Oliver Hartkopp wrote:
 
> That's strange indeed.
> 
> Can you send the output of
> 
> ip -details link show vcan0
> ip -details link show slcan0

$ ip -details link show vcan0
4: vcan0: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1
    link/can  promiscuity 0 
    vcan 

$ ip -details link show slcan0
7: slcan0: <NOARP,UP,LOWER_UP> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0 

> At least the CAN ID is 'AND'ed with CAN_ERR_MASK 0x1FFFFFFF :-)
> That's the reason for the missing '2' due to  CAN_ERR_FLAG.

Indeed, I figured that much already.

> Btw, can you check if this patch fixes the issue:

This pach seems to be already in the 4.4.0 kernel, which I'm running.

-- 
:wq
^X^Cy^K^X^C^C^C^C
