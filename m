From: Michael Dressel <michael.dressel@desy.de>
Subject: Re: reading from socket can
Date: Sat, 29 Jul 2017 09:56:41 +0200 (CEST)
Message-ID: <alpine.LRH.2.20.1707290947400.19613@pal45.desy.de>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de> <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net> <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de> <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-o-1.desy.de ([131.169.56.154]:60092 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752066AbdG2H4o (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 29 Jul 2017 03:56:44 -0400
Received: from smtp-map-1.desy.de (smtp-map-1.desy.de [131.169.56.66])
        by smtp-o-1.desy.de (DESY-O-1) with ESMTP id 2AED02809DA
        for <linux-can@vger.kernel.org>; Sat, 29 Jul 2017 09:56:42 +0200 (CEST)
In-Reply-To: <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi,

thanks again for your reply.

On Fri, 28 Jul 2017, Oliver Hartkopp wrote:

>>  nread = read(can_fd, &rx[0], sizeof(struct can_frame) * 10);
>>       if (nread > 0) {
>>           int i;
>
> If you wanted to check whether only 'correct & complete' struct can_frames 
> have been read from the socket at least this should be done:

That is not code written by us. I don't know why it was done like that.
We are only using that software.

For clarifying if my problem is related to the read at all I did something
similar to your suggestion and added printing a message in case incomplete
can_frames are read.

The difficulty is that my problem takes some weeks to occur and I have
not been able to set up a test case showing the problem.

It could very well be completely unrelated to the read issue.

Thanks for your help. I will post my result if I find one.

Cheers,
Michael
