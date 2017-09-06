From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: reading from socket can
Date: Wed, 6 Sep 2017 12:26:14 +0200
Message-ID: <68490316-f265-fe5f-cf57-6d7f170801bb@hartkopp.net>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de>
 <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net>
 <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de>
 <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
 <alpine.LNX.2.21.1707311317460.14130@mpslxdressel.desy.de>
 <d108399b-5a25-7a0e-f3c4-8b8c1f55eedd@hartkopp.net>
 <alpine.LNX.2.21.1708010829350.1508@mpslxdressel.desy.de>
 <alpine.LNX.2.21.1708241234140.4021@mpslxdressel.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:12700 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752843AbdIFK0V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Sep 2017 06:26:21 -0400
In-Reply-To: <alpine.LNX.2.21.1708241234140.4021@mpslxdressel.desy.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Dressel <michael.dressel@desy.de>
Cc: linux-can@vger.kernel.org

On 09/06/2017 10:32 AM, Michael Dressel wrote:
> now after several weeks we still don't exactly know what causes our
> issues. But I think we can exclude it has anything to do with
> SocketCAN or the can bus.

Puh :-)

> Just for information:
> We see the problems appear in some older computers but not in computers
> that are of the same type but have just slightly different versions of
> hardware. There must be some small differences in the
> computer hardware that, maybe together with some linux driver, causes
> our issues.

Do you also have different Linux Kernel versions on these different 
hardwares?

There are continuous improvements and bugfixes in the CAN drivers. So 
maybe an upgrade of the kernel or - at least - to upgrade to the latest 
of the longterm kernels (e.g. 4.4.13 -> 4.4.60) will catch the fix you need.

Best regards,
Oliver

