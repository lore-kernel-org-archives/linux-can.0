From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH RFC] can: add Virtual CAN Tunnel driver (vxcan)
Date: Tue, 25 Apr 2017 08:28:11 +0200
Message-ID: <73a30dda-c0c6-a1f8-62d0-2cf4a193a7cc@hartkopp.net>
References: <20170424201238.3587-1-socketcan@hartkopp.net>
 <1817567.PFpAbEA6ZR@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:33491 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979542AbdDYG22 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2017 02:28:28 -0400
In-Reply-To: <1817567.PFpAbEA6ZR@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

Hi Alexander,

On 04/25/2017 07:35 AM, Alexander Stein wrote:
> On Monday 24 April 2017 22:12:37, Oliver Hartkopp wrote:

>> +
>> +	netif_rx_ni(skb);
>      ^^^^^^^^^^
> Wouldn't this result in the known out-of-order problem on SMP systems?

I don't think so.
We're not dealing with irqs here that could reach different CPUs.
This is all in softirq/userspace context.
It's the same thing we have with the virtual CAN vcan.

When there's something to fix, then we could fix up both vcan and vxcan.
But I don't think so.

Regards,
Oliver
