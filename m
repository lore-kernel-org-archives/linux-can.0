From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] Add TX limit for SocketCAN.
Date: Fri, 1 Sep 2017 17:39:13 +0200
Message-ID: <44327c45-1d78-84be-c2df-c256ee1e4c29@hartkopp.net>
References: <1504232079-2583-1-git-send-email-zhongjie.shi@intel.com>
 <CANGgnMb5-cKT=PjxEF6yYAcUkcP29BRnHU+_xY3ASsT-GQ6qzQ@mail.gmail.com>
 <106C4230743D00439F3B474E2F2FC8CD53885BF7@SHSMSX101.ccr.corp.intel.com>
 <59A966AD.3030002@mothictech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:20839 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbdIAPjj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Sep 2017 11:39:39 -0400
In-Reply-To: <59A966AD.3030002@mothictech.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Brandon Martin <martinbv@mothictech.com>, "Shi, Zhongjie" <zhongjie.shi@intel.com>, Austin Schuh <austin@peloton-tech.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

Hi all,

On 09/01/2017 03:54 PM, Brandon Martin wrote:
> On 08/31/2017 11:22 PM, Shi, Zhongjie wrote:
>> It will be also appreciated if you or Oliver can share with me the 
>> details of how to "use queuing discipline" to achieve this.
> 
> Presumably it works (or is supposed to work) just like any other 
> socket/packet interface.  The "tc" userspace command (friend of 
> iproute2) would configure it.  Whether this is actually functional at 
> this time is not something I can speak to.

Yes, in fact using queuing disciplines is the right way to do.

You wanted to create some 'kind of' firewall via bandwidth limitation 
which could be created with 'tc'.

The paper about using CAN with queuing disciplines can be found here:
http://rtime.felk.cvut.cz/can/

http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

Especially on this level it would work with PF_PACKET sockets too.
Limiting CAN traffic in the CAN network layer in linux/net/can does not 
limit the access to CAN network devices e.g. via packet sockets or 
in-kernel traffic generators (I think there is a traffic generator - but 
I didn't check if it knows about CAN interfaces).

Regards,
Oliver
