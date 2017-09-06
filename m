From: Michael Dressel <michael.dressel@desy.de>
Subject: Re: reading from socket can
Date: Wed, 6 Sep 2017 14:53:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.21.1709061450250.1485@mpslxdressel.desy.de>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de> <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net> <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de> <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
 <alpine.LNX.2.21.1707311317460.14130@mpslxdressel.desy.de> <d108399b-5a25-7a0e-f3c4-8b8c1f55eedd@hartkopp.net> <alpine.LNX.2.21.1708010829350.1508@mpslxdressel.desy.de> <alpine.LNX.2.21.1708241234140.4021@mpslxdressel.desy.de> <68490316-f265-fe5f-cf57-6d7f170801bb@hartkopp.net>
 <alpine.LNX.2.21.1709061247040.26752@mpslxdressel.desy.de> <5357d5dd-411d-f4b1-c14b-7b6ae4c7b92c@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-o-3.desy.de ([131.169.56.156]:49328 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753828AbdIFMxy (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 6 Sep 2017 08:53:54 -0400
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
        by smtp-o-3.desy.de (DESY-O-3) with ESMTP id 4771C280313
        for <linux-can@vger.kernel.org>; Wed,  6 Sep 2017 14:53:53 +0200 (CEST)
In-Reply-To: <5357d5dd-411d-f4b1-c14b-7b6ae4c7b92c@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Wed, 6 Sep 2017, Oliver Hartkopp wrote:

> On 09/06/2017 12:54 PM, Michael Dressel wrote:
>
> You might just take a look into the logged changes for each CAN driver, e.g. 
> for the FlexCAN here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/can/flexcan.c
>
> From 3.16 to 4.9 there was a bigger amount of changes/fixes.
>
> Maybe you try the new kernel on the old hardware too ;-)

We already did upgrade the old computer. We have it run in a test
environment. With the old linux we could reproduce the problem. Now we
are letting it run with the new operation  system.  Let's see.

Cheers,
Michael



