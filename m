From: Michael Dressel <michael.dressel@desy.de>
Subject: Re: reading from socket can
Date: Wed, 6 Sep 2017 12:54:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.21.1709061247040.26752@mpslxdressel.desy.de>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de> <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net> <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de> <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
 <alpine.LNX.2.21.1707311317460.14130@mpslxdressel.desy.de> <d108399b-5a25-7a0e-f3c4-8b8c1f55eedd@hartkopp.net> <alpine.LNX.2.21.1708010829350.1508@mpslxdressel.desy.de> <alpine.LNX.2.21.1708241234140.4021@mpslxdressel.desy.de>
 <68490316-f265-fe5f-cf57-6d7f170801bb@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-o-1.desy.de ([131.169.56.154]:51017 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753665AbdIFKy3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 6 Sep 2017 06:54:29 -0400
Received: from smtp-map-1.desy.de (smtp-map-1.desy.de [131.169.56.66])
        by smtp-o-1.desy.de (DESY-O-1) with ESMTP id 3056A2803C8
        for <linux-can@vger.kernel.org>; Wed,  6 Sep 2017 12:54:28 +0200 (CEST)
In-Reply-To: <68490316-f265-fe5f-cf57-6d7f170801bb@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org


On Wed, 6 Sep 2017, Oliver Hartkopp wrote:
> Do you also have different Linux Kernel versions on these different 
> hardwares?

No.

>
> There are continuous improvements and bugfixes in the CAN drivers. So maybe 
> an upgrade of the kernel or - at least - to upgrade to the latest of the 
> longterm kernels (e.g. 4.4.13 -> 4.4.60) will catch the fix you need.

We use 3.16.0-4-686 on the older and the newer computer.

We have replaced some of the effected computers with up to date computers
and run 4.9.0-3-686 on the newest computers. Here we have not seen
issues yet too.

It could really be not particularly related to the CAN cards maybe PCI
controller or ... ?

Thanks for your help.

Cheers,
Michael
