From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] can: ifi: use correct register to read rx status
Date: Fri, 14 Apr 2017 14:23:05 +0200
Message-ID: <cb03e0d8-5ea4-2228-33ac-26033088d63a@denx.de>
References: <e4cba95c-0a88-03cb-3e10-e49bb06b18ee@denx.de>
 <20170410200733.GA5101@noone-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56957 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdDNMXI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Apr 2017 08:23:08 -0400
In-Reply-To: <20170410200733.GA5101@noone-desktop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Markus Marb <markus@marb.org>
Cc: linux-can@vger.kernel.org

On 04/10/2017 10:07 PM, Markus Marb wrote:
> Hi,

Hi!

>> Which version of the core do you use ? Can you also share value of
>> register 0x54 and 0x58 ?
> I am using core version 0x020F5B14 (register 0x54).

Thanks!

> Register 0x58 is fixed i guess ? It holds 0xD073CAFD.
> 
> Regards,
> Markus Marb
> 


-- 
Best regards,
Marek Vasut
