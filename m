From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Any thing against non-blocking socketCan?
Date: Thu, 11 Jan 2018 20:47:05 +0100
Message-ID: <b56731fe-4b3b-5bc2-8a35-c72ac0f96723@hartkopp.net>
References: <CAM=RW1+MsQt=Qz6bJdokBXB3A_CRcqnVPMXeFRRtXKbJt-84xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:16785 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934582AbeAKTrI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Jan 2018 14:47:08 -0500
In-Reply-To: <CAM=RW1+MsQt=Qz6bJdokBXB3A_CRcqnVPMXeFRRtXKbJt-84xw@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yousof Ebneddin Hamidi <youebned@gmail.com>, linux-can <linux-can@vger.kernel.org>

Hi Yousof,

On 01/11/2018 09:03 AM, Yousof Ebneddin Hamidi wrote:

> I was trying to use signal driven socket CAN which as far as I
> understood it is not a good idea. Because the correct way of doing it
> is similar to reading the flags of the fd.
> 
> Just I want to check with you if it is ok to make a non-blocking
> socket and reads it always and when the read was successful, the data
> is being processed.
> OR
> I should use the socketCan exactly like what is happening in candump?
> 
> the non-blocking socketCan seems to work nicely. but I want to know
> your opinion if there is something against it.

No - you can do it either way.

Using select() as it can be seen in candump allows more options to read 
from several different file descriptors and/or specify timeouts.

If you don't need that functionality there's no need to use select().

Best regards
Oliver
