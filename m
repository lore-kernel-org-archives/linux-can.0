From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: reading from socket can
Date: Wed, 6 Sep 2017 13:56:04 +0200
Message-ID: <5357d5dd-411d-f4b1-c14b-7b6ae4c7b92c@hartkopp.net>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de>
 <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net>
 <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de>
 <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
 <alpine.LNX.2.21.1707311317460.14130@mpslxdressel.desy.de>
 <d108399b-5a25-7a0e-f3c4-8b8c1f55eedd@hartkopp.net>
 <alpine.LNX.2.21.1708010829350.1508@mpslxdressel.desy.de>
 <alpine.LNX.2.21.1708241234140.4021@mpslxdressel.desy.de>
 <68490316-f265-fe5f-cf57-6d7f170801bb@hartkopp.net>
 <alpine.LNX.2.21.1709061247040.26752@mpslxdressel.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:31994 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbdIFL4X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Sep 2017 07:56:23 -0400
In-Reply-To: <alpine.LNX.2.21.1709061247040.26752@mpslxdressel.desy.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Dressel <michael.dressel@desy.de>
Cc: linux-can@vger.kernel.org



On 09/06/2017 12:54 PM, Michael Dressel wrote:
> 
> On Wed, 6 Sep 2017, Oliver Hartkopp wrote:
>> Do you also have different Linux Kernel versions on these different 
>> hardwares?
> 
> No.
> 
>>
>> There are continuous improvements and bugfixes in the CAN drivers. So 
>> maybe an upgrade of the kernel or - at least - to upgrade to the 
>> latest of the longterm kernels (e.g. 4.4.13 -> 4.4.60) will catch the 
>> fix you need.
> 
> We use 3.16.0-4-686 on the older and the newer computer.
> 
> We have replaced some of the effected computers with up to date computers
> and run 4.9.0-3-686 on the newest computers. Here we have not seen
> issues yet too.
> 
> It could really be not particularly related to the CAN cards maybe PCI
> controller or ... ?

You might just take a look into the logged changes for each CAN driver, 
e.g. for the FlexCAN here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/can/flexcan.c

 From 3.16 to 4.9 there was a bigger amount of changes/fixes.

Maybe you try the new kernel on the old hardware too ;-)

Best regards,
Oliver

